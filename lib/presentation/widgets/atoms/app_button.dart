/// الذرات - AppButton: زر موحد بأنواع متعددة
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';

/// أنواع الأزرار
enum AppButtonVariant { primary, secondary, outlined, text, danger }

/// ذرة الزر
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.height = AppDimensions.buttonHeightMd,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            width: AppDimensions.iconSm,
            height: AppDimensions.iconSm,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == AppButtonVariant.outlined
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
              ),
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: AppDimensions.iconSm),
                  const SizedBox(width: AppDimensions.spaceSm),
                  Text(label),
                ],
              )
            : Text(label);

    Widget button = switch (variant) {
      AppButtonVariant.primary   => ElevatedButton(onPressed: onPressed, child: child),
      AppButtonVariant.secondary => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: onPressed,
        child: child,
      ),
      AppButtonVariant.outlined  => OutlinedButton(onPressed: onPressed, child: child),
      AppButtonVariant.text      => TextButton(onPressed: onPressed, child: child),
      AppButtonVariant.danger    => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
        onPressed: onPressed,
        child: child,
      ),
    };

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, height: height, child: button);
    } else {
      button = SizedBox(height: height, child: button);
    }

    return button;
  }
}
