import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_config.dart';
import 'route_names.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/error/presentation/pages/not_found_page.dart';
import '../../features/error/presentation/pages/error_page.dart';

/// موجه التطبيق المركزي - يدعم الروابط العميقة والتوجيه المسمى
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: AppConfig.isDevelopment,

    // ---- معالجة الأخطاء والمسارات غير الموجودة ----
    errorBuilder: (context, state) => NotFoundPage(error: state.error),

    // ---- إعدادات الروابط العميقة ----
    // تهيئة الـ deep links يتم في أملفة Android/iOS
    // scheme: AppConfig.deepLinkScheme
    // host: AppConfig.deepLinkHost

    routes: [
      // ---- صفحة البداية ----
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // ---- الصفحة الرئيسية ----
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          // تفاصيل التصنيف
          GoRoute(
            path: 'categories/:id',
            name: 'category-detail',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return Scaffold(
                appBar: AppBar(title: Text('التصنيف: $id')),
                body: Center(child: Text('تفاصيل التصنيف: $id')),
              );
            },
          ),
          // تفاصيل العنصر
          GoRoute(
            path: 'items/:id',
            name: 'item-detail',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return Scaffold(
                appBar: AppBar(title: Text('العنصر: $id')),
                body: Center(child: Text('تفاصيل العنصر: $id')),
              );
            },
          ),
        ],
      ),

      // ---- الإعدادات ----
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),

      // ---- الروابط العميقة - تعيد التوجيه إلى الصفحة المناسبة ----
      GoRoute(
        path: '/deep/categories/:id',
        name: 'deep-category',
        redirect: (context, state) {
          final id = state.pathParameters['id'];
          return id != null ? '/home/categories/$id' : RouteNames.home;
        },
      ),
      GoRoute(
        path: '/deep/items/:id',
        name: 'deep-item',
        redirect: (context, state) {
          final id = state.pathParameters['id'];
          return id != null ? '/home/items/$id' : RouteNames.home;
        },
      ),

      // ---- صفحة الخطأ ----
      GoRoute(
        path: RouteNames.error,
        name: 'error',
        builder: (context, state) {
          final message = state.extra as String?;
          return ErrorPage(message: message);
        },
      ),

      // ---- صفحة 404 ----
      GoRoute(
        path: RouteNames.notFound,
        name: 'not-found',
        builder: (context, state) => const NotFoundPage(),
      ),
    ],

    // ---- إعادة التوجيه المشروط ----
    redirect: (context, state) {
      // يمكن إضافة منطق المصادقة هنا
      // مثال: إعادة توجيه غير المسجلين إلى صفحة الدخول
      return null;
    },
  );
}
