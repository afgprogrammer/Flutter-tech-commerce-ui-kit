import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/widgets/como_button.dart';
import '../product/product_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'id': '1',
      'imageUrl': 'https://picsum.photos/300/300?random=1',
      'title': 'Wireless Bluetooth Headphones',
      'price': '\$99.99',
      'originalPrice': '\$129.99',
      'rating': 4.5,
      'reviewCount': 128,
      'isFavorite': true,
    },
    {
      'id': '2',
      'imageUrl': 'https://picsum.photos/300/300?random=2',
      'title': 'Smart Watch Series 8',
      'price': '\$299.99',
      'originalPrice': null,
      'rating': 4.8,
      'reviewCount': 856,
      'isFavorite': true,
    },
    {
      'id': '3',
      'imageUrl': 'https://picsum.photos/300/300?random=3',
      'title': 'Gaming Mechanical Keyboard',
      'price': '\$129.99',
      'originalPrice': '\$159.99',
      'rating': 4.3,
      'reviewCount': 567,
      'isFavorite': true,
    },
    {
      'id': '4',
      'imageUrl': 'https://picsum.photos/300/300?random=4',
      'title': 'USB-C Fast Charging Cable',
      'price': '\$19.99',
      'originalPrice': '\$29.99',
      'rating': 4.1,
      'reviewCount': 2345,
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _wishlistItems.isEmpty 
          ? _buildEmptyState() 
          : _buildWishlistContent(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'Wishlist',
        style: AppTextStyles.titleLarge,
      ),
      actions: [
        if (_wishlistItems.isNotEmpty)
          TextButton(
            onPressed: _showClearAllDialog,
            child: Text(
              'Clear All',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        const SizedBox(width: AppConstants.paddingS),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HugeIcon(
              icon: HugeIcons.strokeRoundedFavourite,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'Your wishlist is empty',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Add items you love to your wishlist.\nReview them anytime and easily move them to your bag.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingXL),
            ComoButton(
              text: 'Start Shopping',
              onPressed: () {
                Navigator.pop(context);
              },
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistContent() {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Row(
            children: [
              Text(
                '${_wishlistItems.length} items',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _toggleViewMode,
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedGrid,
                  size: 18,
                  color: AppColors.primary,
                ),
                label: Text(
                  'Grid View',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: AppConstants.paddingM,
              mainAxisSpacing: AppConstants.paddingM,
            ),
            itemCount: _wishlistItems.length,
            itemBuilder: (context, index) {
              final item = _wishlistItems[index];
              return Stack(
                children: [
                  ProductCard(
                    imageUrl: item['imageUrl'],
                    title: item['title'],
                    price: item['price'],
                    originalPrice: item['originalPrice'],
                    rating: item['rating'],
                    reviewCount: item['reviewCount'],
                    isFavorite: item['isFavorite'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: item['id'],
                          ),
                        ),
                      );
                    },
                    onFavoriteTap: () {
                      _removeFromWishlist(index);
                    },
                  ),
                  Positioned(
                    top: AppConstants.paddingS,
                    right: AppConstants.paddingS,
                    child: GestureDetector(
                      onTap: () => _removeFromWishlist(index),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete02,
                          color: AppColors.secondary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: SafeArea(
            child: ComoButton(
              text: 'Move All to Cart',
              onPressed: _wishlistItems.isEmpty ? null : _moveAllToCart,
              isFullWidth: true,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedShoppingCart01,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _removeFromWishlist(int index) {
    setState(() {
      _wishlistItems.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed from wishlist'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Handle undo
          },
        ),
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Wishlist',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Are you sure you want to remove all items from your wishlist?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _wishlistItems.clear();
              });
            },
            child: Text(
              'Clear All',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleViewMode() {
    // Toggle between grid and list view
    // Implementation would switch between different layouts
  }

  void _moveAllToCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Move to Cart',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Move all ${_wishlistItems.length} items to your cart?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle move to cart
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All items moved to cart'),
                ),
              );
            },
            child: Text(
              'Move All',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
