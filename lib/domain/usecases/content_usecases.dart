/// حالات استخدام المحتوى
library;

import '../../core/utils/either.dart';
import '../entities/content_entity.dart';
import '../entities/pagination.dart';
import '../repositories/content_repository.dart';
import 'use_case.dart';

/// جلب المحتوى المميز
class GetFeaturedContentsUseCase
    extends UseCase<List<ContentEntity>, int> {
  const GetFeaturedContentsUseCase({required ContentRepository repository})
      : _repository = repository;

  final ContentRepository _repository;

  @override
  Future<AppResult<List<ContentEntity>>> call(int limit) =>
      _repository.getFeaturedContents(limit: limit);
}

/// جلب تفاصيل محتوى
class GetContentByIdUseCase extends UseCase<ContentEntity, String> {
  const GetContentByIdUseCase({required ContentRepository repository})
      : _repository = repository;

  final ContentRepository _repository;

  @override
  Future<AppResult<ContentEntity>> call(String id) =>
      _repository.getContentById(id);
}

/// جلب محتوى بـ slug
class GetContentBySlugUseCase extends UseCase<ContentEntity, String> {
  const GetContentBySlugUseCase({required ContentRepository repository})
      : _repository = repository;

  final ContentRepository _repository;

  @override
  Future<AppResult<ContentEntity>> call(String slug) =>
      _repository.getContentBySlug(slug);
}

/// معاملات جلب محتوى تصنيف
class GetContentsByCategoryParams {
  const GetContentsByCategoryParams({
    required this.categoryId,
    required this.params,
  });
  final String categoryId;
  final PaginationParams params;
}

/// جلب محتوى تصنيف
class GetContentsByCategoryUseCase
    extends UseCase<PaginatedResult<ContentEntity>, GetContentsByCategoryParams> {
  const GetContentsByCategoryUseCase({required ContentRepository repository})
      : _repository = repository;

  final ContentRepository _repository;

  @override
  Future<AppResult<PaginatedResult<ContentEntity>>> call(
    GetContentsByCategoryParams params,
  ) =>
      _repository.getContentsByCategory(params.categoryId, params.params);
}

/// معاملات البحث في المحتوى
class SearchContentsParams {
  const SearchContentsParams({required this.query, required this.params});
  final String query;
  final PaginationParams params;
}

/// البحث في المحتوى
class SearchContentsUseCase
    extends UseCase<PaginatedResult<ContentEntity>, SearchContentsParams> {
  const SearchContentsUseCase({required ContentRepository repository})
      : _repository = repository;

  final ContentRepository _repository;

  @override
  Future<AppResult<PaginatedResult<ContentEntity>>> call(
    SearchContentsParams params,
  ) =>
      _repository.searchContents(params.query, params.params);
}
