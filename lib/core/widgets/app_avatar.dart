import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_cached_image.dart';

/// Reusable circle avatar with fallback initials and cached image support
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String fallbackName;
  final double radius;
  final bool isOnline;

  const AppAvatar({
    super.key,
    this.imageUrl,
    required this.fallbackName,
    this.radius = 24,
    this.isOnline = false,
  });

  String get _initials {
    final parts = fallbackName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return fallbackName.isNotEmpty ? fallbackName[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;

    Widget avatarContent;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = AppCachedImage(
        imageUrl: imageUrl!,
        width: size,
        height: size,
        borderRadius: BorderRadius.circular(radius),
        errorWidget: _buildInitials(),
      );
    } else {
      avatarContent = _buildInitials();
    }

    if (!isOnline) {
      return RepaintBoundary(child: avatarContent);
    }

    return RepaintBoundary(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatarContent,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.55,
              height: radius * 0.55,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitials() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: radius * 0.75,
          ),
        ),
      ),
    );
  }
}
