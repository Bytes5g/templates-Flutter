/// صفحة 404
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/constants/ui_constants.dart';
import '../../widgets/atoms/app_button.dart';
import '../../widgets/atoms/app_text.dart';
import '../../widgets/templates/app_scaffold.dart';

/// صفحة غير موجود (404)
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showOfflineBanner: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceXl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '404',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              const AppText(
                'الصفحة غير موجودة',
                variant: AppTextVariant.headlineLarge,
                align: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              AppText(
                'الرابط الذي أدخلته غير موجود أو تم تغييره.',
                variant: AppTextVariant.bodyMedium,
                align: TextAlign.center,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: AppDimensions.spaceXxl),
              AppButton(
                label: 'العودة للرئيسية',
                onPressed: () => context.go(AppRoutes.home),
                icon: Icons.home_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
