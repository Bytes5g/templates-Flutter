/// تنفيذ مستودع المحتوى مع Offline-First
library;

import '../../../core/errors/error_mapper.dart';
import '../../../core/network/network_info.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/utils/either.dart';
import '../../../domain/entities/content_entity.dart';
import '../../../domain/entities/pagination.dart';
import '../../../domain/repositories/content_repository.dart';
import '../../datasources/local/local_data_source.dart';
import '../../datasources/remote/remote_data_source.dart';

/// تنفيذ مستودع المحتوى
class ContentRepositoryImpl implements ContentRepository {
  const ContentRepositoryImpl({
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
  Future<AppResult<PaginatedResult<ContentEntity>>> getContents(
    PaginationParams params,
  ) async {
    try {
      if (!await _network.isConnected) {
        // عند عدم الاتصال، جلب الصفحة الأولى من الكاش
        final cached = _local.getContentsByCategory('all', params.page);
        if (cached != null) {
          return right(PaginatedResult(
            items: cached.map((m) => m.toEntity()).toList(),
            total: cached.length,
            page: params.page,
            perPage: params.perPage,
          ));
        }
        return left(const OfflineFailure());
      }
      final response = await _remote.getContents(params.toQueryParams());
      // تخزين محلي
      await _local.saveContentsByCategory('all', params.page, response.data);
      for (final m in response.data) {
        await _local.saveContent(m);
      }
      return right(PaginatedResult(
        items: response.data.map((m) => m.toEntity()).toList(),
        total: response.total,
        page: response.page,
        perPage: response.perPage,
        nextPage: response.nextPage,
        previousPage: response.previousPage,
      ));
    } catch (e) {
      AppLogger.error('[ContentRepository] خطأ في getContents', e);
      return left(ErrorMapper.map(e));
    }
  }

  @override
  Future<AppResult<ContentEntity>> getContentById(String id) async {
    try {
      final cached = _local.getContentById(id);
      if (!await _network.isConnected) {
        if (cached != null) return right(cached.toEntity());
        return left(const OfflineFailure());
      }
      final remote = await _remote.getContentById(id);
      await _local.saveContent(remote);
      return right(remote.toEntity());
    } catch (e) {
      AppLogger.error('[ContentRepository] خطأ في getContentById', e);
      final cached = _local.getContentById(id);
      if (cached != null) return right(cached.toEntity());
      return left(ErrorMapper.map(e));
    }
  }

  @override
  Future<AppResult<ContentEntity>> getContentBySlug(String slug) async {
    try {
      final cached = _local.getContentBySlug(slug);
      if (!await _network.isConnected) {
        if (cached != null) return right(cached.toEntity());
        return left(const OfflineFailure());
      }
      final remote = await _remote.getContentBySlug(slug);
      await _local.saveContentBySlug(remote);
      return right(remote.toEntity());
    } catch (e) {
      AppLogger.error('[ContentRepository] خطأ في getContentBySlug', e);
      final cached = _local.getContentBySlug(slug);
      if (cached != null) return right(cached.toEntity());
      return left(ErrorMapper.map(e));
    }
  }

  @override
  Future<AppResult<List<ContentEntity>>> getFeaturedContents({
    int limit = 10,
  }) async {
    try {
      final cached = _local.getFeaturedContents();
      if (!await _network.isConnected) {
        if (cached != null) {
          return right(cached.map((m) => m.toEntity()).toList());
        }
        return left(const OfflineFailure());
      }
      final remote = await _remote.getFeaturedContents(limit: limit);
      await _local.saveFeaturedContents(remote);
      return right(remote.map((m) => m.toEntity()).toList());
    } catch (e) {
      AppLogger.error('[ContentRepository] خطأ في getFeaturedContents', e);
      final cached = _local.getFeaturedContents();
      if (cached != null) return right(cached.map((m) => m.toEntity()).toList());
      return left(ErrorMapper.map(e));
    }
  }

  @override
  Future<AppResult<PaginatedResult<ContentEntity>>> getContentsByCategory(
    String categoryId,
    PaginationParams params,
  ) async {
    try {
      final cached = _local.getContentsByCategory(categoryId, params.page);
      if (!await _network.isConnected) {
        if (cached != null) {
          return right(PaginatedResult(
            items: cached.map((m) => m.toEntity()).toList(),
            total: cached.length,
            page: params.page,
            perPage: params.perPage,
          ));
        }
        return left(const OfflineFailure());
      }
      final response = await _remote.getContentsByCategory(
        categoryId,
        params.toQueryParams(),
      );
      await _local.saveContentsByCategory(categoryId, params.page, response.data);
      return right(PaginatedResult(
        items: response.data.map((m) => m.toEntity()).toList(),
        total: response.total,
        page: response.page,
        perPage: response.perPage,
        nextPage: response.nextPage,
        previousPage: response.previousPage,
      ));
    } catch (e) {
      AppLogger.error('[ContentRepository] خطأ في getContentsByCategory', e);
      return left(ErrorMapper.map(e));
    }
  }

  @override
  Future<AppResult<PaginatedResult<ContentEntity>>> searchContents(
    String query,
    PaginationParams params,
  ) async {
    try {
      if (!await _network.isConnected) {
        return left(const OfflineFailure());
      }
      final response = await _remote.searchContents(query, params.toQueryParams());
      return right(PaginatedResult(
        items: response.data.map((m) => m.toEntity()).toList(),
        total: response.total,
        page: response.page,
        perPage: response.perPage,
        nextPage: response.nextPage,
        previousPage: response.previousPage,
      ));
    } catch (e) {
      AppLogger.error('[ContentRepository] خطأ في searchContents', e);
      return left(ErrorMapper.map(e));
    }
  }
}
