/// محرك التوجيه المتقدم مع دعم الروابط العميقة
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/route_constants.dart';
import '../presentation/pages/error/not_found_page.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/splash/splash_page.dart';
import 'deep_link_handler.dart';

/// محرك التوجيه المركزي
class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    // ─── إعادة التوجيه العام ───
    redirect: _globalRedirect,

    // ─── معالجة الأخطاء ───
    errorBuilder: (context, state) => ErrorPage(
      errorMessage: state.error?.message,
    ),

    // ─── المسارات ───
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.categories,
        name: 'categories',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'category-detail',
            builder: (_, state) => HomePage(
              categoryId: state.pathParameters['id'],
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.itemDetails.replaceFirst(':id', ':id'),
        name: 'item-details',
        builder: (_, state) => HomePage(
          contentId: state.pathParameters['id'],
        ),
      ),
      GoRoute(
        path: AppRoutes.search,
        name: 'search',
        builder: (_, state) => HomePage(
          searchQuery: state.uri.queryParameters['q'],
        ),
      ),
      GoRoute(
        path: AppRoutes.notFound,
        name: 'not-found',
        builder: (_, __) => const NotFoundPage(),
      ),
      GoRoute(
        path: AppRoutes.error,
        name: 'error',
        builder: (_, state) => ErrorPage(
          errorMessage: state.uri.queryParameters['message'],
        ),
      ),
    ],
  );

  static String? _globalRedirect(BuildContext context, GoRouterState state) {
    // هنا يمكن إضافة منطق إعادة التوجيه (مثل التحقق من المصادقة)
    return null;
  }
}
