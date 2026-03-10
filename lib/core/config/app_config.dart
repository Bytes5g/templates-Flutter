/// تكوين بيئة التطبيق من ملف .env
/// لا تُعرَّف أي قيمة ثابتة هنا - كل القيم تأتي من ملف البيئة
library;

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// خدمة تكوين البيئة - تُقرأ كل القيم من ملف .env
class AppConfig {
  AppConfig._();

  /// تهيئة البيئة من ملف .env المناسب
  static Future<void> initialize({String envFile = '.env'}) async {
    await dotenv.load(fileName: envFile);
  }

  // ─── إعدادات API ───
  static String get apiBaseUrl =>
      _require('API_BASE_URL');

  static String get apiKey =>
      _require('API_KEY');

  static int get apiTimeout =>
      int.parse(_require('API_TIMEOUT'));

  // ─── إعدادات التطبيق ───
  static String get appName =>
      _require('APP_NAME');

  static String get appVersion =>
      _require('APP_VERSION');

  static String get appEnv =>
      _require('APP_ENV');

  static bool get isProduction => appEnv == 'production';
  static bool get isStaging    => appEnv == 'staging';
  static bool get isDevelopment => appEnv == 'development';

  // ─── إعدادات الكاش ───
  static int get cacheMaxAge =>
      int.parse(_require('CACHE_MAX_AGE'));

  static int get cacheMaxStale =>
      int.parse(_require('CACHE_MAX_STALE'));

  // ─── إعدادات الصور ───
  static String get imageCdnUrl =>
      _require('IMAGE_CDN_URL');

  static int get imageMaxWidth =>
      int.parse(_require('IMAGE_MAX_WIDTH'));

  static int get imageQuality =>
      int.parse(_require('IMAGE_QUALITY'));

  /// قراءة قيمة مطلوبة - يرفع استثناء إن لم تُوجد
  static String _require(String key) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.isEmpty) {
      throw StateError('مفتاح البيئة "$key" غير موجود في ملف .env');
    }
    return value;
  }
}
