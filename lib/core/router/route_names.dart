/// أسماء المسارات المُعرَّفة مركزياً لمنع التضارب (DRY)
abstract class RouteNames {
  // مسار البداية
  static const String splash = '/';

  // مسارات رئيسية
  static const String home = '/home';
  static const String settings = '/settings';
  static const String profile = '/profile';

  // مسارات التصنيفات والعناصر
  static const String categories = '/categories';
  static const String categoryDetail = '/categories/:id';
  static const String itemDetail = '/items/:id';

  // مسارات الأخطاء
  static const String notFound = '/404';
  static const String error = '/error';

  // مسارات الروابط العميقة
  static const String deepLinkPrefix = '/deep';
}

/// بناة مسارات الروابط العميقة
abstract class RouteBuilders {
  static String categoryDetail(String id) => '/categories/$id';
  static String itemDetail(String id) => '/items/$id';
}
