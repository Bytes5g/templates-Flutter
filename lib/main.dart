import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
import 'core/di/service_locator.dart';
import 'core/storage/local_storage.dart';

/// نقطة دخول التطبيق
/// يتم هنا: تهيئة .env، حقن التبعيات، التخزين المحلي
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل ملف .env (Zero Hard-coding)
  await dotenv.load(fileName: '.env');

  // تهيئة حقن التبعيات
  await initServiceLocator();

  // تهيئة التخزين المحلي (Offline-First)
  await sl<LocalStorage>().init();

  // إعداد الاتجاه: RTL أولاً
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // تخصيص شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const App());
}
