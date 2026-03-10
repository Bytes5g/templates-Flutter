/// الذرات - AppImage: صورة محسّنة مع كاش وتحميل تدريجي
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/ui_constants.dart';

/// أنواع الصور
enum AppImageFit { cover, contain, fill, scaleDown }

/// ذرة الصورة المحسّنة
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = AppImageFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final AppImageFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  /// بناء URL محسّن مع حجم الصورة
  String _buildOptimizedUrl(String rawUrl) {
    if (rawUrl.startsWith('http://') || rawUrl.startsWith('https://')) {
      return rawUrl;
    }
    return '${AppConfig.imageCdnUrl}/$rawUrl?'
        'w=${AppConfig.imageMaxWidth}'
        '&q=${AppConfig.imageQuality}'
        '&fmt=webp';
  }

  BoxFit get _boxFit => switch (fit) {
    AppImageFit.cover     => BoxFit.cover,
    AppImageFit.contain   => BoxFit.contain,
    AppImageFit.fill      => BoxFit.fill,
    AppImageFit.scaleDown => BoxFit.scaleDown,
  };

  @override
  Widget build(BuildContext context) {
    final optimizedUrl = _buildOptimizedUrl(url);
    Widget image = CachedNetworkImage(
      imageUrl: optimizedUrl,
      width: width,
      height: height,
      fit: _boxFit,
      placeholder: (_, __) => placeholder ?? _buildShimmer(),
      errorWidget: (_, __, ___) =>
          errorWidget ?? _buildErrorWidget(context),
      fadeInDuration: const Duration(milliseconds: 300),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _buildShimmer() => Shimmer.fromColors(
    baseColor: const Color(0xFFE0E0E0),
    highlightColor: const Color(0xFFF5F5F5),
    child: Container(
      width: width,
      height: height,
      color: Colors.white,
    ),
  );

  Widget _buildErrorWidget(BuildContext context) => Container(
    width: width,
    height: height,
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    child: Icon(
      Icons.broken_image_outlined,
      size: AppDimensions.iconLg,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    ),
  );
}
