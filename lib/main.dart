/// نقطة دخول التطبيق
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection_container.dart';
import 'core/storage/cache_service.dart';
import 'core/storage/offline_queue_service.dart';
import 'core/utils/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── تحميل متغيرات البيئة ───
  await AppConfig.initialize();

  // ─── تهيئة خدمات التخزين ───
  await CacheService.initialize();
  await OfflineQueueService.initialize();

  // ─── تهيئة حقن التبعيات ───
  await setupDependencies();

  // ─── إعداد اتجاه الشاشة ───
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // ─── تهيئة شريط الحالة ───
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  AppLogger.info('التطبيق: ${AppConfig.appName} v${AppConfig.appVersion}');
  AppLogger.info('البيئة: ${AppConfig.appEnv}');

  runApp(const App());
}
