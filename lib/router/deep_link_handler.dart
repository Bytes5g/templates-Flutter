/// معالج الروابط العميقة وإعادة التوجيه
library;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';
import '../core/utils/app_logger.dart';

/// خدمة معالجة الروابط العميقة
class DeepLinkHandler {
  DeepLinkHandler._();

  static StreamSubscription? _subscription;

  /// تهيئة مستمع الروابط العميقة
  static Future<void> initialize(GoRouter router) async {
    // معالجة الرابط الأولي (عند فتح التطبيق من رابط)
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        AppLogger.info('[DeepLink] رابط أولي: $initialUri');
        _handleUri(router, initialUri);
      }
    } on PlatformException {
      AppLogger.error('[DeepLink] خطأ في قراءة الرابط الأولي');
    }

    // مستمع للروابط أثناء تشغيل التطبيق
    _subscription = uriLinkStream.listen(
      (uri) {
        if (uri != null) {
          AppLogger.info('[DeepLink] رابط وارد: $uri');
          _handleUri(router, uri);
        }
      },
      onError: (e) {
        AppLogger.error('[DeepLink] خطأ في مستمع الروابط', e);
      },
    );
  }

  static void _handleUri(GoRouter router, Uri uri) {
    try {
      // تحويل الرابط الخارجي إلى مسار داخلي
      final internalPath = _mapToInternalPath(uri);
      if (internalPath != null) {
        router.go(internalPath);
      }
    } catch (e) {
      AppLogger.error('[DeepLink] خطأ في معالجة الرابط: $uri', e);
      router.go('/error?message=رابط غير صالح');
    }
  }

  /// تحويل الروابط الخارجية إلى مسارات داخلية
  static String? _mapToInternalPath(Uri uri) {
    final segments = uri.pathSegments;
    if (segments.isEmpty) return '/home';

    return switch (segments[0]) {
      'home'       => '/home',
      'categories' => segments.length > 1
          ? '/categories/${segments[1]}'
          : '/categories',
      'items'      => segments.length > 1
          ? '/items/${segments[1]}'
          : '/home',
      'search'     => '/search?q=${uri.queryParameters['q'] ?? ''}',
      _            => '/404',
    };
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
