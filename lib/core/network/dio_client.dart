/// إعداد عميل Dio المركزي مع الاعتراضات
library;

import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../errors/exceptions.dart';
import '../storage/secure_storage.dart';
import '../utils/app_logger.dart';

/// عميل HTTP مُهيَّأ مسبقاً مع interceptors للأخطاء، التوثيق، والسجل
class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: AppConfig.apiTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.apiTimeout),
        sendTimeout: Duration(milliseconds: AppConfig.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': 'ar',
        },
      ),
    );

    dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }

  /// إعادة ضبط الـ instance (للاختبارات)
  static void reset() => _instance = null;
}

/// اعتراض إضافة رمز المصادقة
class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// اعتراض تسجيل الطلبات والاستجابات
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('[HTTP] ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.debug(
      '[HTTP] ${response.statusCode} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '[HTTP ERROR] ${err.type} ${err.requestOptions.uri}',
      err,
    );
    handler.next(err);
  }
}

/// اعتراض معالجة الأخطاء وتحويلها لاستثناءات معرَّفة
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = switch (err.type) {
      DioExceptionType.connectionError    => const NoConnectionException(),
      DioExceptionType.connectionTimeout  ||
      DioExceptionType.sendTimeout        ||
      DioExceptionType.receiveTimeout     => const TimeoutException(),
      DioExceptionType.badResponse        => _fromStatusCode(
          err.response?.statusCode,
          err.response?.data,
        ),
      _ => const AppException(message: 'خطأ غير متوقع في الشبكة'),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }

  AppException _fromStatusCode(int? code, dynamic data) {
    final message = _extractMessage(data);
    return switch (code) {
      401 => const UnauthorizedException(),
      403 => const ForbiddenException(),
      404 => const NotFoundException(),
      422 => ValidationException(message: message ?? 'بيانات غير صالحة'),
      >= 500 => const ServerException(),
      _ => AppException(message: message ?? 'خطأ غير متوقع', statusCode: code),
    };
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
             data['error'] as String?;
    }
    return null;
  }
}
