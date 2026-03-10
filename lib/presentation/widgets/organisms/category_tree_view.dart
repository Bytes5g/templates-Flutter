/// الكائنات - CategoryTreeView: شجرة التصنيفات
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../domain/entities/category_entity.dart';
import '../atoms/app_image.dart';
import '../atoms/app_text.dart';

/// كائن شجرة التصنيفات
class CategoryTreeView extends StatelessWidget {
  const CategoryTreeView({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.selectedCategoryId,
    this.expandAll = false,
  });

  final List<CategoryEntity> categories;
  final void Function(CategoryEntity)? onCategoryTap;
  final String? selectedCategoryId;
  final bool expandAll;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      padding: const EdgeInsets.all(AppDimensions.spaceSm),
      itemBuilder: (context, index) => _CategoryTreeItem(
        category: categories[index],
        onTap: onCategoryTap,
        selectedId: selectedCategoryId,
        initiallyExpanded: expandAll,
        depth: 0,
      ),
    );
  }
}

class _CategoryTreeItem extends StatelessWidget {
  const _CategoryTreeItem({
    required this.category,
    this.onTap,
    this.selectedId,
    this.initiallyExpanded = false,
    required this.depth,
  });

  final CategoryEntity category;
  final void Function(CategoryEntity)? onTap;
  final String? selectedId;
  final bool initiallyExpanded;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final isSelected = category.id == selectedId;
    final indent     = depth * AppDimensions.spaceMd;

    if (category.hasChildren) {
      return Padding(
        padding: EdgeInsets.only(right: indent),
        child: ExpansionTile(
          leading: _buildLeading(context, isSelected),
          title: AppText(
            category.name,
            variant: AppTextVariant.bodyMedium,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          trailing: Chip(
            label: AppText(
              '${category.itemCount}',
              variant: AppTextVariant.labelMedium,
            ),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          initiallyExpanded: initiallyExpanded,
          onExpansionChanged: (_) => onTap?.call(category),
          children: category.children.map((child) => _CategoryTreeItem(
            category: child,
            onTap: onTap,
            selectedId: selectedId,
            initiallyExpanded: initiallyExpanded,
            depth: depth + 1,
          )).toList(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: indent),
      child: ListTile(
        leading: _buildLeading(context, isSelected),
        title: AppText(
          category.name,
          variant: AppTextVariant.bodyMedium,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
        trailing: category.itemCount > 0
            ? Chip(
                label: AppText(
                  '${category.itemCount}',
                  variant: AppTextVariant.labelMedium,
                ),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              )
            : null,
        selected: isSelected,
        onTap: () => onTap?.call(category),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context, bool isSelected) {
    if (category.imageUrl != null) {
      return AppImage(
        url: category.imageUrl!,
        width: AppDimensions.iconMd,
        height: AppDimensions.iconMd,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      );
    }
    return Icon(
      category.hasChildren ? Icons.folder_rounded : Icons.label_rounded,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.outline,
      size: AppDimensions.iconMd,
    );
  }
}
