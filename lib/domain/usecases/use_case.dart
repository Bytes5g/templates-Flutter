/// حالة الاستخدام الأساسية - DRY للاستدعاء المنهجي
library;

import '../../core/utils/either.dart';
import '../../core/errors/failures.dart';

/// واجهة حالة استخدام بمعاملات
abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Either<AppFailure, Type>> call(Params params);
}

/// واجهة حالة استخدام بدون معاملات
abstract class UseCaseNoParams<Type> {
  const UseCaseNoParams();
  Future<Either<AppFailure, Type>> call();
}

/// معاملات فارغة (للحالات التي لا تحتاج معاملات)
class NoParams {
  const NoParams();
}
