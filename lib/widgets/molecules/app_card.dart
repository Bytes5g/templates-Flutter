import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../atoms/app_text.dart';
import '../atoms/app_image.dart';

/// جزيء البطاقة - يجمع صورة وعنوان ووصف (Molecule Widget)
class AppCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? badge;
  final EdgeInsets? padding;

  const AppCard({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.onTap,
    this.trailing,
    this.badge,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null)
                  AppImage(
                    url: imageUrl,
                    height: AppSizes.thumbnailLg,
                    width: double.infinity,
                    shape: AppImageShape.rectangle,
                  ),
                Padding(
                  padding: padding ??
                      const EdgeInsets.all(AppSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title,
                        variant: AppTextVariant.titleMedium,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSizes.xs),
                        AppText(
                          subtitle!,
                          variant: AppTextVariant.bodySmall,
                          color: AppColors.textSecondary,
                          maxLines: 2,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (badge != null)
              Positioned(
                top: AppSizes.sm,
                left: AppSizes.sm,
                child: badge!,
              ),
            if (trailing != null)
              Positioned(
                top: AppSizes.sm,
                right: AppSizes.sm,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
