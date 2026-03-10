import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/atoms/app_button.dart';
import '../../../../widgets/atoms/app_text.dart';

/// صفحة الخطأ العام
class ErrorPage extends StatelessWidget {
  final String? message;

  const ErrorPage({super.key, this.message});

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
                Icon(
                  Icons.error_outline_rounded,
                  size: AppSizes.iconXl * 2,
                  color: AppColors.error.withOpacity(0.7),
                ),
                const SizedBox(height: AppSizes.xl),
                const AppText(
                  'حدث خطأ',
                  variant: AppTextVariant.headlineMedium,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.sm),
                AppText(
                  message ?? 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
