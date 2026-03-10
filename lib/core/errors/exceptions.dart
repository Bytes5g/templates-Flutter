/// استثناءات الطبقة البعيدة - تُحوَّل إلى Failures في Repository
library;

/// الاستثناء الأساسي
class AppException implements Exception {
  const AppException({required this.message, this.statusCode, this.errors});

  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  @override
  String toString() => 'AppException: $message (status: $statusCode)';
}

/// استثناء الشبكة
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'خطأ في الشبكة',
    super.statusCode,
    super.errors,
  });
}

/// استثناء انتهاء المهلة
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'انتهت مهلة الطلب',
    super.statusCode = 408,
    super.errors,
  });
}

/// استثناء عدم الاتصال
class NoConnectionException extends AppException {
  const NoConnectionException({
    super.message = 'لا يوجد اتصال بالإنترنت',
    super.statusCode,
    super.errors,
  });
}

/// استثناء المصادقة
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'غير مصرح بالوصول',
    super.statusCode = 401,
    super.errors,
  });
}

/// استثناء الصلاحيات
class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'ممنوع الوصول',
    super.statusCode = 403,
    super.errors,
  });
}

/// استثناء عدم الوجود
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'العنصر غير موجود',
    super.statusCode = 404,
    super.errors,
  });
}

/// استثناء التحقق
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.statusCode = 422,
    super.errors,
  });
}

/// استثناء الخادم
class ServerException extends AppException {
  const ServerException({
    super.message = 'خطأ في الخادم',
    super.statusCode = 500,
    super.errors,
  });
}

/// استثناء التخزين المحلي
class CacheException extends AppException {
  const CacheException({
    super.message = 'خطأ في التخزين المحلي',
    super.statusCode,
    super.errors,
  });
}
