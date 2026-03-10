/// خدمة التسجيل المركزية - تعتمد على logger package
library;

import 'package:logger/logger.dart';
import '../config/app_config.dart';

/// مُسجِّل مركزي يطبع في وضع التطوير فقط
class AppLogger {
  AppLogger._();

  static Logger? _logger;

  static Logger get _instance {
    _logger ??= Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
      ),
      // إيقاف التسجيل في الإنتاج
      level: AppConfig.isProduction ? Level.off : Level.debug,
    );
    return _logger!;
  }

  static void debug(String message) => _instance.d(message);
  static void info(String message)  => _instance.i(message);
  static void warning(String message) => _instance.w(message);
  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _instance.e(message, error: error, stackTrace: stackTrace);
}
