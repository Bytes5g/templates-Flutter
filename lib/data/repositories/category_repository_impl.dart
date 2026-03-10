/// تنفيذ مستودع التصنيفات مع Offline-First
library;

import '../../../core/errors/error_mapper.dart';
import '../../../core/network/network_info.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/utils/either.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/pagination.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../datasources/local/local_data_source.dart';
import '../../datasources/remote/remote_data_source.dart';
import '../../models/category_model.dart';

/// تنفيذ مستودع التصنيفات
class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl({
    required RemoteDataSource remoteDataSource,
    required LocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remote = remoteDataSource,
        _local = localDataSource,
        _network = networkInfo;

  final RemoteDataSource _remote;
  final LocalDataSource _local;
  final NetworkInfo _network;

  @override
  Future<AppResult<List<CategoryEntity>>> getRootCategories() async {
    return _fetchWithCache(
      cacheGet: _local.getRootCategories,
      remoteFetch: _remote.getRootCategories,
      cacheSave: _local.saveRootCategories,
      toEntity: (models) =>
          models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Future<AppResult<List<CategoryEntity>>> getSubCategories(
    String parentId,
  ) async {
    return _fetchWithCache(
      cacheGet: () => _local.getSubCategories(parentId),
      remoteFetch: () => _remote.getSubCategories(parentId),
      cacheSave: (data) => _local.saveSubCategories(parentId, data),
      toEntity: (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Future<AppResult<CategoryEntity>> getCategoryById(String id) async {
    return _fetchSingleWithCache(
      cacheGet: () => _local.getCategoryById(id),
      remoteFetch: () => _remote.getCategoryById(id),
      cacheSave: _local.saveCategory,
      toEntity: (m) => m.toEntity(),
    );
  }

  @override
  Future<AppResult<List<CategoryEntity>>> getCategoryTree() async {
    return _fetchWithCache(
      cacheGet: _local.getCategoryTree,
      remoteFetch: _remote.getCategoryTree,
      cacheSave: _local.saveCategoryTree,
      toEntity: (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Future<AppResult<PaginatedResult<CategoryEntity>>> searchCategories(
    PaginationParams params,
  ) async {
    try {
      if (!await _network.isConnected) {
        return left(const OfflineFailure());
      }
      final response = await _remote.searchCategories(params.toQueryParams());
      return right(PaginatedResult(
        items: response.data.map((m) => m.toEntity()).toList(),
        total: response.total,
        page: response.page,
        perPage: response.perPage,
        nextPage: response.nextPage,
        previousPage: response.previousPage,
      ));
    } catch (e) {
      AppLogger.error('[CategoryRepository] خطأ في البحث', e);
      return left(ErrorMapper.map(e));
    }
  }

  /// نمط DRY لجلب قائمة مع كاش
  Future<AppResult<List<T>>> _fetchWithCache<T, M>({
    required List<M>? Function() cacheGet,
    required Future<List<M>> Function() remoteFetch,
    required Future<void> Function(List<M>) cacheSave,
    required List<T> Function(List<M>) toEntity,
  }) async {
    try {
      // أولاً: محاولة الكاش المحلي
      final cached = cacheGet();
      final isOnline = await _network.isConnected;

      if (!isOnline) {
        if (cached != null) return right(toEntity(cached));
        return left(const OfflineFailure());
      }

      // ثانياً: جلب من الخادم وتحديث الكاش
      final remote = await remoteFetch();
      await cacheSave(remote);
      return right(toEntity(remote));
    } catch (e) {
      AppLogger.error('[CategoryRepository] خطأ', e);
      // عند فشل الشبكة، استخدم الكاش القديم إن وُجد
      final cached = cacheGet();
      if (cached != null) return right(toEntity(cached));
      return left(ErrorMapper.map(e));
    }
  }

  /// نمط DRY لجلب عنصر واحد مع كاش
  Future<AppResult<T>> _fetchSingleWithCache<T, M>({
    required M? Function() cacheGet,
    required Future<M> Function() remoteFetch,
    required Future<void> Function(M) cacheSave,
    required T Function(M) toEntity,
  }) async {
    try {
      final cached = cacheGet();
      final isOnline = await _network.isConnected;

      if (!isOnline) {
        if (cached != null) return right(toEntity(cached));
        return left(const OfflineFailure());
      }

      final remote = await remoteFetch();
      await cacheSave(remote);
      return right(toEntity(remote));
    } catch (e) {
      AppLogger.error('[CategoryRepository] خطأ', e);
      final cached = cacheGet();
      if (cached != null) return right(toEntity(cached));
      return left(ErrorMapper.map(e));
    }
  }
}
