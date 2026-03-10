import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../atoms/app_text.dart';
import '../atoms/app_button.dart';

/// جزيء عرض الخطأ - يجمع رسالة الخطأ مع زر إعادة المحاولة (Molecule Widget)
class AppErrorWidget extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData icon;

  const AppErrorWidget({
    super.key,
    this.title = 'حدث خطأ',
    this.message,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.iconXl * 1.5,
              color: AppColors.error.withOpacity(0.7),
            ),
            const SizedBox(height: AppSizes.lg),
            AppText(
              title,
              variant: AppTextVariant.titleLarge,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSizes.sm),
              AppText(
                message!,
                variant: AppTextVariant.bodyMedium,
                color: AppColors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: AppSizes.xl),
              AppButton(
                label: 'إعادة المحاولة',
                onPressed: onRetry,
                icon: Icons.refresh_rounded,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// جزيء قائمة فارغة
class AppEmptyWidget extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback? onAction;
  final String? actionLabel;
  final IconData icon;

  const AppEmptyWidget({
    super.key,
    this.title = 'لا توجد بيانات',
    this.message,
    this.onAction,
    this.actionLabel,
    this.icon = Icons.inbox_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.iconXl * 1.5,
              color: AppColors.grey400,
            ),
            const SizedBox(height: AppSizes.lg),
            AppText(
              title,
              variant: AppTextVariant.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSizes.sm),
              AppText(
                message!,
                variant: AppTextVariant.bodyMedium,
                color: AppColors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: AppSizes.xl),
              AppButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
