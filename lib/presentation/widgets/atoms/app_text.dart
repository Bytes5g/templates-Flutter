/// الذرات - AppText: نص موحد مع دعم RTL
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';

/// أنواع النص المعيارية
enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
}

/// ذرة النص - نقطة دخول موحدة لجميع النصوص في التطبيق
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.decoration,
  });

  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle(context);
    return Text(
      text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: TextDirection.rtl,
    );
  }

  TextStyle? _resolveStyle(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final base = switch (variant) {
      AppTextVariant.displayLarge  => theme.displayLarge,
      AppTextVariant.displayMedium => theme.displayMedium,
      AppTextVariant.displaySmall  => theme.displaySmall,
      AppTextVariant.headlineLarge => theme.headlineLarge,
      AppTextVariant.headlineMedium=> theme.headlineMedium,
      AppTextVariant.headlineSmall => theme.headlineSmall,
      AppTextVariant.bodyLarge     => theme.bodyLarge,
      AppTextVariant.bodyMedium    => theme.bodyMedium,
      AppTextVariant.bodySmall     => theme.bodySmall,
      AppTextVariant.labelLarge    => theme.labelLarge,
      AppTextVariant.labelMedium   => theme.labelMedium,
    };
    return base?.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: decoration,
    );
  }
}
