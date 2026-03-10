import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/atoms/app_button.dart';
import '../../../../widgets/atoms/app_text.dart';

/// صفحة 404 - المحتوى غير موجود
class NotFoundPage extends StatelessWidget {
  final Exception? error;

  const NotFoundPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // رقم 404
                const AppText(
                  '404',
                  variant: AppTextVariant.hero,
                  color: AppColors.grey300,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: AppSizes.lg),
                Icon(
                  Icons.search_off_rounded,
                  size: AppSizes.iconXl * 1.5,
                  color: AppColors.grey400,
                ),
                const SizedBox(height: AppSizes.lg),
                const AppText(
                  'الصفحة غير موجودة',
                  variant: AppTextVariant.headlineMedium,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.sm),
                const AppText(
                  'يبدو أن الرابط الذي تبحث عنه غير موجود أو تم نقله.',
                  variant: AppTextVariant.bodyLarge,
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.xxl),
                AppButton(
                  label: 'العودة للرئيسية',
                  onPressed: () => context.go(RouteNames.home),
                  icon: Icons.home_rounded,
                  isFullWidth: true,
                ),
                const SizedBox(height: AppSizes.md),
                AppButton(
                  label: 'رجوع',
                  variant: AppButtonVariant.outlined,
                  onPressed: () => context.pop(),
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
