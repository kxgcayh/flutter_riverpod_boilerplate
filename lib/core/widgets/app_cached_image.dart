import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Reusable cached network image optimized with placeholder shimmer and error fallback
class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? errorWidget;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) => Container(
        width: width,
        height: height,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurfaceVariant
            : AppColors.lightSurfaceVariant,
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
          errorWidget ??
          Container(
            width: width,
            height: height,
            color: AppColors.error.withValues(alpha: 0.1),
            child: const Icon(
              Icons.broken_image_rounded,
              color: AppColors.error,
              size: 24,
            ),
          ),
    );

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return RepaintBoundary(
      child: imageWidget,
    );
  }
}
