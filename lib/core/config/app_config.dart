import 'package:flutter_dotenv/flutter_dotenv.dart';

/// إعدادات التطبيق - مستخرجة من ملف .env
/// يمنع تضمين أي قيمة ثابتة في الكود المصدري (Zero Hard-coding)
class AppConfig {
  AppConfig._();

  /// عنوان API الأساسي
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.example.com/v1';

  /// مفتاح API
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// مهلة الطلب بالثواني
  static int get apiTimeoutSeconds =>
      int.tryParse(dotenv.env['API_TIMEOUT_SECONDS'] ?? '30') ?? 30;

  /// اسم صندوق Hive للتخزين المحلي
  static String get hiveBoxName =>
      dotenv.env['HIVE_BOX_NAME'] ?? 'app_cache';

  /// مدة صلاحية التخزين المؤقت بالساعات
  static int get cacheTtlHours =>
      int.tryParse(dotenv.env['CACHE_TTL_HOURS'] ?? '24') ?? 24;

  /// اسم التطبيق
  static String get appName => dotenv.env['APP_NAME'] ?? 'تطبيقي';

  /// معرّف الحزمة
  static String get appBundleId =>
      dotenv.env['APP_BUNDLE_ID'] ?? 'com.example.flutter_template';

  /// إصدار التطبيق
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';

  /// مخطط الرابط العميق
  static String get deepLinkScheme =>
      dotenv.env['DEEP_LINK_SCHEME'] ?? 'myapp';

  /// مضيف الرابط العميق
  static String get deepLinkHost =>
      dotenv.env['DEEP_LINK_HOST'] ?? 'app.example.com';

  /// صورة placeholder الافتراضية
  static String get imagePlaceholderUrl =>
      dotenv.env['IMAGE_PLACEHOLDER_URL'] ??
      'https://via.placeholder.com/300';

  /// بيئة التشغيل
  static String get appEnv => dotenv.env['APP_ENV'] ?? 'development';

  /// هل نحن في بيئة الإنتاج؟
  static bool get isProduction => appEnv == 'production';

  /// هل نحن في بيئة التطوير؟
  static bool get isDevelopment => appEnv == 'development';
}
