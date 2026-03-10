import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';

// تُولَّد تلقائياً عبر `flutter gen-l10n`
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// جذر التطبيق - يهيئ الثيم والتوجيه والتدويل
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil: تهيئة الاستجابة الكاملة
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 14 Pro كمرجع
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          // ---- الثيم ----
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,

          // ---- التوجيه ----
          routerConfig: AppRouter.router,

          // ---- التدويل والـ RTL ----
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ar'),

          // ---- إخفاء شريط Debug ----
          debugShowCheckedModeBanner: false,

          title: 'تطبيقي',
        );
      },
    );
  }
}
