import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/item_model.dart';

/// تطبيق مستودع Home - يجمع بين البيانات البعيدة والمحلية (Offline-First)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories({
    String? parentId,
    bool forceRefresh = false,
  }) async {
    // إذا لا يوجد اتصال، استخدم البيانات المخزنة
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      final cached = localDataSource.getCachedCategories();
      if (cached != null) return Right(cached);
      return const Left(NetworkFailure());
    }

    // إذا لم ينته الـ cache، استخدمه (Offline-First Strategy)
    if (!forceRefresh && !localDataSource.isCategoriesCacheExpired()) {
      final cached = localDataSource.getCachedCategories();
      if (cached != null) return Right(cached);
    }

    // جلب من الخادم وتخزين محلياً
    try {
      final categories =
          await remoteDataSource.getCategories(parentId: parentId);
      await localDataSource.cacheCategories(categories);
      return Right(categories);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on AuthException {
      return const Left(AuthFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    } on ServerException catch (e) {
      // الرجوع للـ cache عند فشل الخادم
      final cached = localDataSource.getCachedCategories();
      if (cached != null) return Right(cached);
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getItems({
    required String categoryId,
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      final cached = localDataSource.getCachedItems(categoryId);
      if (cached != null) return Right(cached);
      return const Left(NetworkFailure());
    }

    if (!forceRefresh &&
        !localDataSource.isItemsCacheExpired(categoryId) &&
        page == 1) {
      final cached = localDataSource.getCachedItems(categoryId);
      if (cached != null) return Right(cached);
    }

    try {
      final items = await remoteDataSource.getItems(
        categoryId: categoryId,
        page: page,
        pageSize: pageSize,
      );
      if (page == 1) {
        await localDataSource.cacheItems(categoryId, items);
      }
      return Right(items);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      final cached = localDataSource.getCachedItems(categoryId);
      if (cached != null) return Right(cached);
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Item>> getItemById(String id) async {
    try {
      final item = await remoteDataSource.getItemById(id);
      return Right(item);
    } on NetworkException {
      return const Left(NetworkFailure());
    } on NotFoundException {
      return const Left(NotFoundFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> searchItems({
    required String query,
    String? categoryId,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return const Left(NetworkFailure());

    try {
      final items = await remoteDataSource.searchItems(
        query: query,
        categoryId: categoryId,
      );
      return Right(items);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
