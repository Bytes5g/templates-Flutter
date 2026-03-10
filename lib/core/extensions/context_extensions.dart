import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';

/// امتدادات BuildContext لتسهيل الوصول لثيم وترجمات التطبيق
extension ContextExtensions on BuildContext {
  // -- الثيم والألوان --
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // -- الأبعاد --
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  // -- الاستجابة --
  bool get isMobile => screenWidth < AppSizes.mobileBreakpoint;
  bool get isTablet =>
      screenWidth >= AppSizes.mobileBreakpoint &&
      screenWidth < AppSizes.tabletBreakpoint;
  bool get isDesktop => screenWidth >= AppSizes.tabletBreakpoint;

  // -- RTL --
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}

/// امتدادات الأرقام للاستجابة باستخدام ScreenUtil
extension ResponsiveExtensions on num {
  /// عرض استجابي
  double get w => toDouble().w;

  /// ارتفاع استجابي
  double get h => toDouble().h;

  /// حجم خط استجابي
  double get sp => toDouble().sp;

  /// نصف قطر استجابي
  double get r => toDouble().r;
}
