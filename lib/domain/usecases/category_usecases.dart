/// حالات استخدام التصنيفات
library;

import '../../core/utils/either.dart';
import '../entities/category_entity.dart';
import '../entities/pagination.dart';
import '../repositories/category_repository.dart';
import 'use_case.dart';

/// جلب شجرة التصنيفات الكاملة
class GetCategoryTreeUseCase extends UseCaseNoParams<List<CategoryEntity>> {
  const GetCategoryTreeUseCase({required CategoryRepository repository})
      : _repository = repository;

  final CategoryRepository _repository;

  @override
  Future<AppResult<List<CategoryEntity>>> call() =>
      _repository.getCategoryTree();
}

/// جلب تصنيفات جذرية
class GetRootCategoriesUseCase
    extends UseCaseNoParams<List<CategoryEntity>> {
  const GetRootCategoriesUseCase({required CategoryRepository repository})
      : _repository = repository;

  final CategoryRepository _repository;

  @override
  Future<AppResult<List<CategoryEntity>>> call() =>
      _repository.getRootCategories();
}

/// جلب تصنيف محدد
class GetCategoryByIdUseCase extends UseCase<CategoryEntity, String> {
  const GetCategoryByIdUseCase({required CategoryRepository repository})
      : _repository = repository;

  final CategoryRepository _repository;

  @override
  Future<AppResult<CategoryEntity>> call(String id) =>
      _repository.getCategoryById(id);
}

/// جلب تصنيفات فرعية
class GetSubCategoriesUseCase
    extends UseCase<List<CategoryEntity>, String> {
  const GetSubCategoriesUseCase({required CategoryRepository repository})
      : _repository = repository;

  final CategoryRepository _repository;

  @override
  Future<AppResult<List<CategoryEntity>>> call(String parentId) =>
      _repository.getSubCategories(parentId);
}

/// معاملات البحث في التصنيفات
class SearchCategoriesParams {
  const SearchCategoriesParams({required this.params});
  final PaginationParams params;
}

/// البحث في التصنيفات
class SearchCategoriesUseCase
    extends UseCase<PaginatedResult<CategoryEntity>, SearchCategoriesParams> {
  const SearchCategoriesUseCase({required CategoryRepository repository})
      : _repository = repository;

  final CategoryRepository _repository;

  @override
  Future<AppResult<PaginatedResult<CategoryEntity>>> call(
    SearchCategoriesParams params,
  ) =>
      _repository.searchCategories(params.params);
}
