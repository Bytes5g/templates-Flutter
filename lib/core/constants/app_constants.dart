/// ثوابت الأبعاد والمسافات - مرجعية لجميع الأحجام في التطبيق
/// لا تُستخدم قيم صلبة في أي مكان آخر
abstract class AppSizes {
  // المسافات الأساسية
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // نصف قطر الحواف
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 100.0;

  // أحجام الخطوط
  static const double fontXs = 10.0;
  static const double fontSm = 12.0;
  static const double fontMd = 14.0;
  static const double fontLg = 16.0;
  static const double fontXl = 18.0;
  static const double fontXxl = 22.0;
  static const double fontDisplay = 28.0;
  static const double fontHero = 34.0;

  // أحجام الأيقونات
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // أبعاد الأزرار
  static const double buttonHeight = 52.0;
  static const double buttonHeightSm = 40.0;
  static const double buttonMinWidth = 120.0;

  // ارتفاع AppBar
  static const double appBarHeight = 56.0;

  // ارتفاع BottomNavigationBar
  static const double bottomNavHeight = 64.0;

  // حجم الصورة المصغرة
  static const double thumbnailSm = 60.0;
  static const double thumbnailMd = 100.0;
  static const double thumbnailLg = 160.0;

  // نقاط توقف الاستجابة
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}

/// ثوابت مدد الحركات والانتقالات
abstract class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration splash = Duration(milliseconds: 2000);
  static const Duration debounce = Duration(milliseconds: 500);
  static const Duration throttle = Duration(milliseconds: 1000);
}

/// ثوابت الشبكة والأخطاء
abstract class AppNetworkConstants {
  static const int maxRetries = 3;
  static const int maxPageSize = 20;
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String acceptLanguageHeader = 'Accept-Language';
  static const String arabicLocale = 'ar';
}

/// ثوابت مفاتيح التخزين المحلي
abstract class AppStorageKeys {
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String userToken = 'user_token';
  static const String lastSync = 'last_sync';
  static const String categoriesCache = 'categories_cache';
  static const String itemsCache = 'items_cache';
}
