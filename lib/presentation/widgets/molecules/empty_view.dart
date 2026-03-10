/// الجزيئات - EmptyView: عرض الحالة الفارغة
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../atoms/app_button.dart';
import '../atoms/app_text.dart';

/// جزيء الحالة الفارغة
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.action,
    this.actionLabel,
  });

  final String? title;
  final String? description;
  final IconData? icon;
  final VoidCallback? action;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            AppText(
              title ?? 'لا يوجد محتوى',
              variant: AppTextVariant.headlineMedium,
              align: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            if (description != null) ...[
              const SizedBox(height: AppDimensions.spaceSm),
              AppText(
                description!,
                variant: AppTextVariant.bodyMedium,
                align: TextAlign.center,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
            if (action != null && actionLabel != null) ...[
              const SizedBox(height: AppDimensions.spaceLg),
              AppButton(
                label: actionLabel!,
                onPressed: action,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
