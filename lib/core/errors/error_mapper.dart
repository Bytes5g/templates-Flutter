/// محوّل الاستثناءات إلى Failures
library;

import 'package:dio/dio.dart';
import 'exceptions.dart';
import 'failures.dart';

/// محوّل مركزي: يحوّل أي استثناء إلى AppFailure مناسب
class ErrorMapper {
  const ErrorMapper._();

  static AppFailure map(Object error) {
    if (error is AppException) {
      return _mapAppException(error);
    }
    if (error is DioException) {
      return _mapDioException(error);
    }
    return const UnexpectedFailure();
  }

  static AppFailure _mapAppException(AppException e) {
    if (e is NoConnectionException) return const OfflineFailure();
    if (e is TimeoutException)      return const NetworkFailure(message: 'انتهت مهلة الطلب.');
    if (e is UnauthorizedException) return const AuthFailure();
    if (e is ForbiddenException)    return const PermissionFailure();
    if (e is NotFoundException)     return const NotFoundFailure();
    if (e is ValidationException)   return ValidationFailure(message: e.message);
    if (e is ServerException)       return const ServerFailure();
    if (e is CacheException)        return const CacheFailure();
    return UnexpectedFailure(message: e.message);
  }

  static AppFailure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'انتهت مهلة الاتصال.');
      case DioExceptionType.connectionError:
        return const OfflineFailure();
      case DioExceptionType.badResponse:
        return _mapStatusCode(e.response?.statusCode);
      default:
        return const UnexpectedFailure();
    }
  }

  static AppFailure _mapStatusCode(int? code) {
    switch (code) {
      case 401: return const AuthFailure();
      case 403: return const PermissionFailure();
      case 404: return const NotFoundFailure();
      case 422: return const ValidationFailure(message: 'بيانات غير صالحة.');
      case >= 500: return const ServerFailure();
      default:  return const UnexpectedFailure();
    }
  }
}
