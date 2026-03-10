import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

/// أنواع النصوص المتاحة في النظام
enum AppTextVariant {
  hero,
  display,
  headlineLarge,
  headlineMedium,
  titleLarge,
  titleMedium,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelSmall,
  caption,
}

/// ذرة النص - الوحدة الأساسية لعرض النصوص (Atomic Widget)
/// تضمن الاتساق في الثيم وعدم تكرار الأنماط (DRY)
class AppText extends StatelessWidget {
  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final bool? softWrap;
  final double? letterSpacing;

  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.softWrap,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle(context);
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      softWrap: softWrap,
    );
  }

  TextStyle _resolveStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final base = switch (variant) {
      AppTextVariant.hero => TextStyle(
          fontSize: AppSizes.fontHero,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      AppTextVariant.display => textTheme.displaySmall,
      AppTextVariant.headlineLarge => textTheme.headlineLarge,
      AppTextVariant.headlineMedium => textTheme.headlineMedium,
      AppTextVariant.titleLarge => textTheme.titleLarge,
      AppTextVariant.titleMedium => textTheme.titleMedium,
      AppTextVariant.bodyLarge => textTheme.bodyLarge,
      AppTextVariant.bodyMedium => textTheme.bodyMedium,
      AppTextVariant.bodySmall => textTheme.bodySmall,
      AppTextVariant.labelLarge => textTheme.labelLarge,
      AppTextVariant.labelSmall => textTheme.labelSmall,
      AppTextVariant.caption => textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          fontSize: AppSizes.fontXs,
        ),
    };

    return (base ?? const TextStyle()).copyWith(
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontFamily: 'Cairo',
    );
  }
}
