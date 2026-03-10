/// الذرات - AppLoadingIndicator: مؤشر تحميل موحد
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';

/// ذرة مؤشر التحميل
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = AppDimensions.iconLg,
    this.color,
    this.strokeWidth = 3,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// مؤشر تحميل في وسط الشاشة
class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: AppLoadingIndicator());
  }
}
