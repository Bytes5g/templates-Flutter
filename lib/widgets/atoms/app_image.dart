import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/config/app_config.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

/// أشكال الصورة
enum AppImageShape { rectangle, circle, rounded }

/// ذرة الصورة - تتضمن تحميلاً كسولاً وتخزيناً مؤقتاً ذكياً (Atomic Widget)
/// تدعم WebP وتعرض placeholder أثناء التحميل
class AppImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final AppImageShape shape;
  final double borderRadius;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppImage({
    super.key,
    this.url,
    this.width,
    this.height,
    this.shape = AppImageShape.rectangle,
    this.borderRadius = AppSizes.radiusMd,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = _buildImage(context);

    return ClipRRect(
      borderRadius: _buildBorderRadius(),
      child: SizedBox(
        width: width,
        height: height,
        child: imageWidget,
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final effectiveUrl = url?.isNotEmpty == true ? url! : null;
    if (effectiveUrl == null) {
      return _buildPlaceholder(context);
    }

    // إذا كانت صورة محلية
    if (effectiveUrl.startsWith('assets/')) {
      return Image.asset(
        effectiveUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildErrorWidget(context),
      );
    }

    // صورة شبكية مع تخزين مؤقت
    return CachedNetworkImage(
      imageUrl: effectiveUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ?? _buildLoadingPlaceholder(context),
      errorWidget: (context, url, error) =>
          errorWidget ?? _buildErrorWidget(context),
      // تعطيل التحميل تلقائياً حتى تظهر الصورة في النطاق المرئي
      fadeInDuration: AppDurations.fast,
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: AppColors.grey200,
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          color: AppColors.grey500,
          size: AppSizes.iconLg,
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder(BuildContext context) {
    return Container(
      color: AppColors.grey200,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: AppColors.grey200,
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: AppColors.grey400,
          size: AppSizes.iconLg,
        ),
      ),
    );
  }

  BorderRadius _buildBorderRadius() {
    return switch (shape) {
      AppImageShape.circle => BorderRadius.circular(AppSizes.radiusFull),
      AppImageShape.rounded => BorderRadius.circular(borderRadius),
      AppImageShape.rectangle => BorderRadius.zero,
    };
  }
}
