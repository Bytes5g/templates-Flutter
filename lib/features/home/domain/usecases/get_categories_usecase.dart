import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/category.dart';
import '../repositories/home_repository.dart';

/// حالة الاستخدام: جلب التصنيفات
/// كل حالة استخدام = مسؤولية واحدة (Single Responsibility Principle)
class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Either<Failure, List<Category>>> call({
    String? parentId,
    bool forceRefresh = false,
  }) {
    return _repository.getCategories(
      parentId: parentId,
      forceRefresh: forceRefresh,
    );
  }
}
