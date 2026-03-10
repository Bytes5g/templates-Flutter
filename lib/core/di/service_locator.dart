import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../storage/local_storage.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_categories_usecase.dart';
import '../../features/home/domain/usecases/get_items_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

/// حاوية حقن التبعيات المركزية باستخدام GetIt
/// كل خدمة مُسجَّلة مرة واحدة فقط (DRY)
final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // ---- الخدمات الأساسية ----
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // ---- التخزين المحلي ----
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorage(sl<FlutterSecureStorage>()),
  );

  // ---- معلومات الشبكة ----
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // ---- عميل HTTP ----
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ---- مصادر البيانات ----
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(sl<LocalStorage>()),
  );

  // ---- المستودعات ----
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl<HomeRemoteDataSource>(),
      localDataSource: sl<HomeLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // ---- حالات الاستخدام ----
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<HomeRepository>()),
  );
  sl.registerLazySingleton<GetItemsUseCase>(
    () => GetItemsUseCase(sl<HomeRepository>()),
  );

  // ---- BLoC ----
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getItemsUseCase: sl<GetItemsUseCase>(),
    ),
  );
}
