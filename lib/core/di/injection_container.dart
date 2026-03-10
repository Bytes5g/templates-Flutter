/// نظام حقن التبعيات باستخدام get_it
/// يُهيَّأ مرة واحدة ويُستخدم في كل مكان
library;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../storage/cache_service.dart';
import '../storage/offline_queue_service.dart';

export 'package:get_it/get_it.dart';

/// المُسجِّل العام للتبعيات
final GetIt sl = GetIt.instance;

/// تهيئة جميع التبعيات
Future<void> setupDependencies() async {
  // ─── البنية التحتية ───
  _registerInfrastructure();

  // ─── تهيئة الخدمات ───
  await _initializeServices();
}

void _registerInfrastructure() {
  // Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(connectivity: sl<Connectivity>()),
  );

  // Dio
  sl.registerLazySingleton<Dio>(() => DioClient.instance);
}

Future<void> _initializeServices() async {
  await CacheService.initialize();
  await OfflineQueueService.initialize();
}

/// مساعد للوصول السريع إلى التبعيات
T get<T extends Object>() => sl<T>();
