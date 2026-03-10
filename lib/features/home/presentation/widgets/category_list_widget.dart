import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../widgets/atoms/app_image.dart';
import '../../../../widgets/atoms/app_text.dart';
import '../../domain/entities/category.dart';

/// عارض قائمة التصنيفات الأفقية
class CategoryListWidget extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final ValueChanged<Category> onCategoryTap;

  const CategoryListWidget({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.thumbnailMd + AppSizes.xl,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        // التحميل الكسول للقوائم الطويلة
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSizes.sm),
        itemBuilder: (context, index) => _CategoryChip(
          category: categories[index],
          isSelected: selectedCategory?.id == categories[index].id,
          onTap: () => onCategoryTap(categories[index]),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : AppColors.grey300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.imageUrl != null) ...[
              AppImage(
                url: category.imageUrl,
                width: AppSizes.iconMd,
                height: AppSizes.iconMd,
                shape: AppImageShape.circle,
              ),
              const SizedBox(width: AppSizes.xs),
            ],
            AppText(
              category.name,
              variant: AppTextVariant.bodyMedium,
              color: isSelected
                  ? AppColors.textOnPrimary
                  : null,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            if (category.itemCount > 0) ...[
              const SizedBox(width: AppSizes.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.xs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.textOnPrimary.withOpacity(0.2)
                      : AppColors.grey200,
                  borderRadius:
                      BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: AppText(
                  '${category.itemCount}',
                  variant: AppTextVariant.labelSmall,
                  color: isSelected
                      ? AppColors.textOnPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
