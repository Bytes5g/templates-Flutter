/// مساعدات الاستجابة للشاشات المختلفة
library;

import 'package:flutter/material.dart';
import '../constants/ui_constants.dart';

/// الفئة المساعدة لتحديد حجم الشاشة الحالي
class ScreenHelper {
  const ScreenHelper._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppDimensions.breakpointMobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppDimensions.breakpointMobile &&
        width < AppDimensions.breakpointTablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.breakpointDesktop;

  /// عدد أعمدة الشبكة بحسب حجم الشاشة
  static int gridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 3;
    return 2;
  }

  /// نسبة عرض/ارتفاع البطاقات بحسب الشاشة
  static double cardAspectRatio(BuildContext context) {
    if (isDesktop(context)) return 0.75;
    if (isTablet(context)) return 0.8;
    return 0.85;
  }

  /// الهامش الأفقي بحسب الشاشة
  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return AppDimensions.spaceXxl;
    if (isTablet(context)) return AppDimensions.spaceLg;
    return AppDimensions.spaceMd;
  }
}
