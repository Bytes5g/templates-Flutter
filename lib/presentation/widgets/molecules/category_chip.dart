/// الجزيئات - CategoryChip: شريحة التصنيف
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../domain/entities/category_entity.dart';
import '../atoms/app_image.dart';
import '../atoms/app_text.dart';

/// جزيء شريحة التصنيف
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    this.onTap,
    this.isSelected = false,
  });

  final CategoryEntity category;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceMd,
          vertical: AppDimensions.spaceSm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.imageUrl != null) ...[
              AppImage(
                url: category.imageUrl!,
                width: AppDimensions.iconSm,
                height: AppDimensions.iconSm,
                borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
              ),
              const SizedBox(width: AppDimensions.spaceXs),
            ],
            AppText(
              category.name,
              variant: AppTextVariant.labelLarge,
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
            ),
            if (category.itemCount > 0) ...[
              const SizedBox(width: AppDimensions.spaceXs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: AppText(
                  '${category.itemCount}',
                  variant: AppTextVariant.labelMedium,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
