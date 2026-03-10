/// جذر التطبيق - يهيئ الثيم، اللغة، والتوجيه
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection_container.dart';
import 'core/network/network_info.dart';
import 'core/theme/app_theme.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/content_repository.dart';
import 'domain/usecases/category_usecases.dart';
import 'domain/usecases/content_usecases.dart';
import 'l10n/app_locale.dart';
import 'presentation/bloc/app_settings_cubit.dart';
import 'presentation/bloc/category_bloc.dart';
import 'presentation/bloc/network_cubit.dart';
import 'router/app_router.dart';
import 'l10n/app_localizations.dart';

/// الجذر الرئيسي للتطبيق
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // إعدادات التطبيق (اللغة والثيم)
        BlocProvider<AppSettingsCubit>(
          create: (_) => AppSettingsCubit(),
        ),
        // مراقب الشبكة
        BlocProvider<NetworkCubit>(
          create: (_) => NetworkCubit(networkInfo: sl<NetworkInfo>()),
        ),
        // BLoC التصنيفات
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(
            getCategoryTree: GetCategoryTreeUseCase(
              repository: sl<CategoryRepository>(),
            ),
            getRootCategories: GetRootCategoriesUseCase(
              repository: sl<CategoryRepository>(),
            ),
            getSubCategories: GetSubCategoriesUseCase(
              repository: sl<CategoryRepository>(),
            ),
            getCategoryById: GetCategoryByIdUseCase(
              repository: sl<CategoryRepository>(),
            ),
          ),
        ),
      ],
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, settings) {
          return MaterialApp.router(
            title: 'Flutter Template',
            debugShowCheckedModeBanner: false,

            // ─── الثيم ───
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,

            // ─── اللغة والتدويل ───
            locale: settings.locale,
            supportedLocales: AppLocale.supported,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return AppLocale.defaultLocale;
              for (final supported in supportedLocales) {
                if (supported.languageCode == locale.languageCode) {
                  return supported;
                }
              }
              return AppLocale.defaultLocale;
            },

            // ─── RTL ───
            builder: (context, child) {
              return Directionality(
                textDirection: AppLocale.isRtl(settings.locale)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },

            // ─── التوجيه ───
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
