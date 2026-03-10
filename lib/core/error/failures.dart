import 'package:equatable/equatable.dart';

/// فئات الأخطاء (Failures) على مستوى Domain
/// يُستخدم مع Either<Failure, T> من dartz
abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

/// خطأ الشبكة / الخادم
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required super.message, this.statusCode});

  @override
  List<Object> get props => [message, statusCode ?? 0];
}

/// خطأ الاتصال بالإنترنت
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'لا يوجد اتصال بالإنترنت'});
}

/// خطأ التخزين المحلي
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// خطأ المصادقة / التصريح
class AuthFailure extends Failure {
  const AuthFailure({super.message = 'غير مصرح لك بالوصول'});
}

/// محتوى غير موجود
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'المحتوى المطلوب غير موجود'});
}

/// خطأ في التحقق من المدخلات
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  const ValidationFailure({required super.message, this.fieldErrors});

  @override
  List<Object> get props => [message, fieldErrors ?? {}];
}

/// خطأ غير متوقع
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'حدث خطأ غير متوقع'});
}
