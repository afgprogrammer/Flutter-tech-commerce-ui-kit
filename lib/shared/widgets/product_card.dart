import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? originalPrice;
  final double? rating;
  final int? reviewCount;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final String? badge;
  final bool isHorizontal;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
    this.badge,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalCard();
    }
    return _buildVerticalCard();
  }

  Widget _buildVerticalCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with better aspect ratio
            Expanded(
              flex: 3,
              child: _buildImageSection(),
            ),
            // Content section with more space
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product title
                    Text(
                      title,
                      style: AppTextStyles.productTitle.copyWith(
                        fontSize: 14,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8,),
                    // Rating section
                    // if (rating != null) ...[
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 4),
                    //     child: _buildRatingSection(),
                    //   ),
                    // ],
                    // Price section
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildPriceSection(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image section
            SizedBox(
              width: 100,
              child: _buildImageSection(),
            ),
            // Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product title
                    Expanded(
                      flex: 2,
                      child: Text(
                        title,
                        style: AppTextStyles.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Rating section
                    if (rating != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: _buildRatingSection(),
                      ),
                    ],
                    // Price section
                    _buildPriceSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.grey100,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.grey100,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.grey100,
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedImage01,
                  color: AppColors.textSecondary,
                  size: AppConstants.iconL,
                ),
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: AppConstants.paddingS,
            left: AppConstants.paddingS,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingS,
                vertical: AppConstants.paddingXS,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Text(
                badge!,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        Positioned(
          top: AppConstants.paddingS,
          right: AppConstants.paddingS,
          child: GestureDetector(
            onTap: onFavoriteTap,
            child: Container(
              padding: const EdgeInsets.all(AppConstants.paddingS),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavorite ? HugeIcons.strokeRoundedHeartAdd : HugeIcons.strokeRoundedHeartRemove,
                color: isFavorite ? AppColors.secondary : AppColors.textSecondary,
                size: AppConstants.iconS,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        HugeIcon(
          icon: HugeIcons.strokeRoundedStar,
          color: AppColors.accent,
          size: 12,
        ),
        const SizedBox(width: 2),
        Text(
          rating!.toStringAsFixed(1),
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '($reviewCount)',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Current price
        Text(
          price,
          style: AppTextStyles.productPrice.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // Original price with breathing space
        if (originalPrice != null) ...[
          const SizedBox(height: 2),
          Text(
            originalPrice!,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              decoration: TextDecoration.lineThrough,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.grey50,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.grey100,
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedImage01,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.grey100,
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedImage01,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              title,
              style: AppTextStyles.categoryTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
