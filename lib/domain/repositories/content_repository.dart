/// واجهة مستودع المحتوى
library;

import '../../core/utils/either.dart';
import '../entities/content_entity.dart';
import '../entities/pagination.dart';

/// عقد مستودع المحتوى
abstract class ContentRepository {
  /// جلب قائمة المحتوى المُقسَّمة
  Future<AppResult<PaginatedResult<ContentEntity>>> getContents(
    PaginationParams params,
  );

  /// جلب محتوى محدد بالمعرّف
  Future<AppResult<ContentEntity>> getContentById(String id);

  /// جلب محتوى محدد بـ slug
  Future<AppResult<ContentEntity>> getContentBySlug(String slug);

  /// جلب المحتوى المميز
  Future<AppResult<List<ContentEntity>>> getFeaturedContents({int limit = 10});

  /// جلب محتوى تصنيف معين
  Future<AppResult<PaginatedResult<ContentEntity>>> getContentsByCategory(
    String categoryId,
    PaginationParams params,
  );

  /// البحث في المحتوى
  Future<AppResult<PaginatedResult<ContentEntity>>> searchContents(
    String query,
    PaginationParams params,
  );
}
