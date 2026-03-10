/// الجزيئات - ContentCard: بطاقة محتوى قابلة لإعادة الاستخدام
library;

import 'package:flutter/material.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../domain/entities/content_entity.dart';
import '../atoms/app_image.dart';
import '../atoms/app_text.dart';

/// جزيء بطاقة المحتوى
class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.content,
    this.onTap,
    this.showCategory = false,
  });

  final ContentEntity content;
  final VoidCallback? onTap;
  final bool showCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الصورة
            if (content.thumbnailUrl != null || content.imageUrl != null)
              AppImage(
                url: content.thumbnailUrl ?? content.imageUrl!,
                height: AppDimensions.cardImageHeight,
                fit: AppImageFit.cover,
              ),

            // المحتوى النصي
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  AppText(
                    content.title,
                    variant: AppTextVariant.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  if (content.description != null) ...[
                    const SizedBox(height: AppDimensions.spaceXs),
                    AppText(
                      content.description!,
                      variant: AppTextVariant.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: AppDimensions.spaceSm),

                  // التاريخ والإحصائيات
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: AppDimensions.iconXs,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: AppDimensions.spaceXs),
                      AppText(
                        _formatDate(content.createdAt),
                        variant: AppTextVariant.labelMedium,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const Spacer(),
                      if (content.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceSm,
                            vertical: AppDimensions.spaceXs,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                          ),
                          child: AppText(
                            'مميز',
                            variant: AppTextVariant.labelMedium,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
