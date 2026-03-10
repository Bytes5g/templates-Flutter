/// تعريفات الأخطاء - طبقة موحدة لمعالجة جميع أنواع الأخطاء
library;

import 'package:equatable/equatable.dart';

/// الفئة الأساسية لجميع أخطاء التطبيق
abstract class AppFailure extends Equatable {
  const AppFailure({required this.message, this.code});

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// خطأ في الشبكة أو الاتصال
class NetworkFailure extends AppFailure {
  const NetworkFailure({
    super.message = 'تعذّر الاتصال بالخادم. تحقق من اتصالك بالإنترنت.',
    super.code,
  });
}

/// عدم وجود اتصال بالإنترنت
class OfflineFailure extends AppFailure {
  const OfflineFailure({
    super.message = 'لا يوجد اتصال بالإنترنت. يتم عرض البيانات المخزنة مؤقتاً.',
    super.code = 'OFFLINE',
  });
}

/// خطأ في المصادقة (401)
class AuthFailure extends AppFailure {
  const AuthFailure({
    super.message = 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.',
    super.code = 'UNAUTHORIZED',
  });
}

/// خطأ في الصلاحيات (403)
class PermissionFailure extends AppFailure {
  const PermissionFailure({
    super.message = 'ليس لديك صلاحية الوصول لهذا المحتوى.',
    super.code = 'FORBIDDEN',
  });
}

/// العنصر غير موجود (404)
class NotFoundFailure extends AppFailure {
  const NotFoundFailure({
    super.message = 'المحتوى المطلوب غير موجود.',
    super.code = 'NOT_FOUND',
  });
}

/// خطأ في التحقق من البيانات (422)
class ValidationFailure extends AppFailure {
  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.code = 'VALIDATION_ERROR',
  });

  final Map<String, List<String>>? fieldErrors;

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

/// خطأ في الخادم (5xx)
class ServerFailure extends AppFailure {
  const ServerFailure({
    super.message = 'خطأ في الخادم. يرجى المحاولة لاحقاً.',
    super.code = 'SERVER_ERROR',
  });
}

/// خطأ في التخزين المحلي
class CacheFailure extends AppFailure {
  const CacheFailure({
    super.message = 'خطأ في التخزين المحلي.',
    super.code = 'CACHE_ERROR',
  });
}

/// خطأ غير معروف
class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({
    super.message = 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
    super.code = 'UNEXPECTED_ERROR',
  });
}
