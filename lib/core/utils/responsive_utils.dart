import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// أدوات الاستجابة - تحدد التخطيط المناسب حسب حجم الشاشة
class ResponsiveUtils {
  ResponsiveUtils._();

  /// هل الجهاز هاتف محمول؟
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppSizes.mobileBreakpoint;

  /// هل الجهاز جهاز لوحي؟
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppSizes.mobileBreakpoint &&
        width < AppSizes.tabletBreakpoint;
  }

  /// هل الجهاز حاسب مكتبي؟
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSizes.tabletBreakpoint;

  /// إرجاع قيمة بناءً على نوع الجهاز (Mobile-First)
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  /// عدد أعمدة Grid بناءً على حجم الشاشة
  static int gridCrossAxisCount(BuildContext context) => responsive(
        context,
        mobile: 2,
        tablet: 3,
        desktop: 4,
      );

  /// نسبة Aspect Ratio للبطاقات
  static double cardAspectRatio(BuildContext context) => responsive(
        context,
        mobile: 0.75,
        tablet: 0.8,
        desktop: 0.85,
      );

  /// الهامش الأفقي للمحتوى
  static double horizontalPadding(BuildContext context) => responsive(
        context,
        mobile: AppSizes.md,
        tablet: AppSizes.xl,
        desktop: AppSizes.xxxl,
      );
}
