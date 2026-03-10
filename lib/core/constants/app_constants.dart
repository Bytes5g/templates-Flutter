/// ثوابت التطبيق - لا تحتوي على قيم ثابتة (Hard-coded)
/// فقط مفاتيح البيئة والأسماء المنطقية تُعرَّف هنا
library;

/// مفاتيح ملفات البيئة
class EnvKeys {
  EnvKeys._();

  static const String apiBaseUrl    = 'API_BASE_URL';
  static const String apiKey        = 'API_KEY';
  static const String apiTimeout    = 'API_TIMEOUT';
  static const String appName       = 'APP_NAME';
  static const String appVersion    = 'APP_VERSION';
  static const String appEnv        = 'APP_ENV';
  static const String cacheMaxAge   = 'CACHE_MAX_AGE';
  static const String cacheMaxStale = 'CACHE_MAX_STALE';
  static const String imageCdnUrl   = 'IMAGE_CDN_URL';
  static const String imageMaxWidth = 'IMAGE_MAX_WIDTH';
  static const String imageQuality  = 'IMAGE_QUALITY';
}

/// مفاتيح التخزين المحلي
class StorageKeys {
  StorageKeys._();

  static const String authToken        = 'auth_token';
  static const String refreshToken     = 'refresh_token';
  static const String userProfile      = 'user_profile';
  static const String appLocale        = 'app_locale';
  static const String appTheme         = 'app_theme';
  static const String onboardingDone   = 'onboarding_done';
  static const String cachedCategories = 'cached_categories';
  static const String cachedTimestamp  = 'cached_timestamp';
}

/// أسماء مربعات Hive
class HiveBoxes {
  HiveBoxes._();

  static const String cache    = 'cache_box';
  static const String settings = 'settings_box';
  static const String queue    = 'offline_queue_box';
}

/// نوع الطلبات في طابور الانتظار دون اتصال
class OfflineQueueType {
  OfflineQueueType._();

  static const String post   = 'POST';
  static const String put    = 'PUT';
  static const String delete = 'DELETE';
}
