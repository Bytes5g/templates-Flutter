/// ثوابت التصميم - جميعها قابلة للتوسع عبر الثيم
library;

/// أبعاد وحجوم - كلها مُعرَّفة هنا ولا تُكتب مباشرة في الكود
class AppDimensions {
  AppDimensions._();

  // ─── المسافات ───
  static const double spaceXs   =  4.0;
  static const double spaceSm   =  8.0;
  static const double spaceMd   = 16.0;
  static const double spaceLg   = 24.0;
  static const double spaceXl   = 32.0;
  static const double spaceXxl  = 48.0;
  static const double spaceXxxl = 64.0;

  // ─── أنصاف الأقطار ───
  static const double radiusXs  =  4.0;
  static const double radiusSm  =  8.0;
  static const double radiusMd  = 12.0;
  static const double radiusLg  = 16.0;
  static const double radiusXl  = 24.0;
  static const double radiusFull = 9999.0;

  // ─── حجوم الأيقونات ───
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // ─── ارتفاعات الأزرار ───
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;

  // ─── ارتفاع شريط التطبيق ───
  static const double appBarHeight = 56.0;

  // ─── الحد الأقصى لعرض المحتوى ───
  static const double maxContentWidth = 1200.0;

  // ─── نقاط التوقف للاستجابة ───
  static const double breakpointMobile  = 600.0;
  static const double breakpointTablet  = 900.0;
  static const double breakpointDesktop = 1200.0;

  // ─── حجوم الخطوط ───
  static const double fontXs  = 10.0;
  static const double fontSm  = 12.0;
  static const double fontMd  = 14.0;
  static const double fontLg  = 16.0;
  static const double fontXl  = 20.0;
  static const double fontXxl = 24.0;
  static const double fontDisplay = 32.0;

  // ─── ارتفاعات البطاقات ───
  static const double cardMinHeight    = 120.0;
  static const double cardImageHeight  = 200.0;
  static const double heroBannerHeight = 300.0;
}

/// أسماء مجموعات الخطوط
class AppFonts {
  AppFonts._();

  static const String primary = 'Cairo';
}
