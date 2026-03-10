/// واجهة مستودع التصنيفات
library;

import '../../core/utils/either.dart';
import '../entities/category_entity.dart';
import '../entities/pagination.dart';

/// عقد مستودع التصنيفات
abstract class CategoryRepository {
  /// جلب التصنيفات الجذرية (المستوى الأول)
  Future<AppResult<List<CategoryEntity>>> getRootCategories();

  /// جلب التصنيفات الفرعية لتصنيف معين
  Future<AppResult<List<CategoryEntity>>> getSubCategories(String parentId);

  /// جلب تصنيف محدد مع أطفاله
  Future<AppResult<CategoryEntity>> getCategoryById(String id);

  /// جلب شجرة كاملة من الجذر
  Future<AppResult<List<CategoryEntity>>> getCategoryTree();

  /// البحث في التصنيفات
  Future<AppResult<PaginatedResult<CategoryEntity>>> searchCategories(
    PaginationParams params,
  );
}
