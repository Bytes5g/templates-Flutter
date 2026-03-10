import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/category.dart';
import '../entities/item.dart';

/// واجهة مستودع Home - طبقة Domain
/// الـ Repository تعرّف "ماذا" وليس "كيف" (Abstraction)
abstract class HomeRepository {
  /// جلب قائمة التصنيفات
  Future<Either<Failure, List<Category>>> getCategories({
    String? parentId,
    bool forceRefresh = false,
  });

  /// جلب قائمة العناصر
  Future<Either<Failure, List<Item>>> getItems({
    required String categoryId,
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  });

  /// جلب عنصر واحد بمعرّفه
  Future<Either<Failure, Item>> getItemById(String id);

  /// البحث في العناصر
  Future<Either<Failure, List<Item>>> searchItems({
    required String query,
    String? categoryId,
  });
}
