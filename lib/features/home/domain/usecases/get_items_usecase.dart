import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/item.dart';
import '../repositories/home_repository.dart';

/// معاملات جلب العناصر
class GetItemsParams {
  final String categoryId;
  final int page;
  final int pageSize;
  final bool forceRefresh;

  const GetItemsParams({
    required this.categoryId,
    this.page = 1,
    this.pageSize = 20,
    this.forceRefresh = false,
  });
}

/// حالة الاستخدام: جلب العناصر
class GetItemsUseCase {
  final HomeRepository _repository;

  GetItemsUseCase(this._repository);

  Future<Either<Failure, List<Item>>> call(GetItemsParams params) {
    return _repository.getItems(
      categoryId: params.categoryId,
      page: params.page,
      pageSize: params.pageSize,
      forceRefresh: params.forceRefresh,
    );
  }
}
