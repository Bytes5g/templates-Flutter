/// مسارات التوجيه - مُعرَّفة كثوابت لمنع الأخطاء الإملائية
library;

class AppRoutes {
  AppRoutes._();

  // ─── مسارات رئيسية ───
  static const String splash   = '/';
  static const String home     = '/home';
  static const String settings = '/settings';

  // ─── مسارات المصادقة ───
  static const String login    = '/auth/login';
  static const String register = '/auth/register';
  static const String forgot   = '/auth/forgot-password';

  // ─── مسارات المحتوى ───
  static const String categories  = '/categories';
  static const String category    = '/categories/:id';
  static const String itemDetails = '/items/:id';
  static const String search      = '/search';

  // ─── مسارات الملف الشخصي ───
  static const String profile      = '/profile';
  static const String editProfile  = '/profile/edit';

  // ─── مسارات الخطأ ───
  static const String notFound    = '/404';
  static const String maintenance = '/maintenance';
  static const String error       = '/error';

  // ─── بناء مسارات ديناميكية ───
  static String categoryPath(String id)   => '/categories/$id';
  static String itemDetailsPath(String id) => '/items/$id';
}
