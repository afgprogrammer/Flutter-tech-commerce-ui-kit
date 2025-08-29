import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  String _selectedSize = 'M';
  String _selectedColor = 'Black';
  int _quantity = 1;

  final List<String> _productImages = [
    'https://picsum.photos/400/400?random=1',
    'https://picsum.photos/400/400?random=2',
    'https://picsum.photos/400/400?random=3',
    'https://picsum.photos/400/400?random=4',
  ];

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<Map<String, dynamic>> _colors = [
    {'name': 'Black', 'color': Colors.black},
    {'name': 'White', 'color': Colors.white},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Red', 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCarousel(),
                _buildProductInfo(),
                _buildSizeSelector(),
                _buildColorSelector(),
                _buildQuantitySelector(),
                _buildDescription(),
                _buildReviews(),
                _buildRecommendations(),
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedArrowLeft01,
          color: AppColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Handle share
          },
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedShare01,
            color: AppColors.textPrimary,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          icon: HugeIcon(
            icon: _isFavorite 
                ? HugeIcons.solidRoundedFavourite 
                : HugeIcons.strokeRoundedFavourite,
            color: _isFavorite ? AppColors.secondary : AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: AppConstants.paddingS),
      ],
    );
  }

  Widget _buildImageCarousel() {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: _productImages.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  child: Image.network(
                    _productImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 300,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _productImages.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == entry.key
                      ? AppColors.primary
                      : AppColors.grey300,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppConstants.paddingL),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Wireless Headphones',
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: AppConstants.paddingS),
          Row(
            children: [
              Text(
                '\$99.99',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppConstants.paddingS),
              Text(
                '\$129.99',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingS,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Text(
                  '23% OFF',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedStar,
                color: AppColors.accent,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '4.8',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppConstants.paddingS),
              Text(
                '(2,341 reviews)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                'In Stock',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppConstants.paddingS),
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.paddingM),
          Wrap(
            spacing: AppConstants.paddingS,
            children: _sizes.map((size) {
              final isSelected = size == _selectedSize;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSize = size;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.grey50,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isSelected ? AppColors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppConstants.paddingS),
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.paddingM),
          Wrap(
            spacing: AppConstants.paddingM,
            children: _colors.map((colorData) {
              final isSelected = colorData['name'] == _selectedColor;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = colorData['name'];
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorData['color'],
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: isSelected
                      ? const Center(
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedTick01,
                            color: AppColors.white,
                            size: 20,
                          ),
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppConstants.paddingS),
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          Text(
            'Quantity',
            style: AppTextStyles.titleMedium,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: _quantity > 1 ? () {
                    setState(() {
                      _quantity--;
                    });
                  } : null,
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedRemove01,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(
                    _quantity.toString(),
                    style: AppTextStyles.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedAdd01,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppConstants.paddingS),
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            'Premium wireless headphones with active noise cancellation, 30-hour battery life, and superior sound quality. Perfect for music lovers and professionals.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            'Features:',
            style: AppTextStyles.titleSmall,
          ),
          const SizedBox(height: AppConstants.paddingS),
          ...['Active Noise Cancellation', '30-hour battery life', 'Premium sound quality', 'Comfortable fit'].map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedTick01,
                    color: AppColors.success,
                    size: 16,
                  ),
                  const SizedBox(width: AppConstants.paddingS),
                  Text(
                    feature,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppConstants.paddingS),
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Reviews (2,341)',
                style: AppTextStyles.titleMedium,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Handle view all reviews
                },
                child: Text(
                  'View All',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingM),
          _buildReviewItem(),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://picsum.photos/40/40?random=10'),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: AppTextStyles.titleSmall,
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) => HugeIcon(
                          icon: HugeIcons.strokeRoundedStar,
                          color: index < 5 ? AppColors.accent : AppColors.grey300,
                          size: 12,
                        )),
                        const SizedBox(width: AppConstants.paddingS),
                        Text(
                          '2 days ago',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            'Amazing sound quality and great battery life. Highly recommended!',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppConstants.paddingS),
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You might also like',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.paddingM),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: AppConstants.paddingM),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppConstants.radiusM),
                          ),
                          child: Image.network(
                            'https://picsum.photos/150/120?random=${index + 20}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppConstants.paddingS),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product ${index + 1}',
                              style: AppTextStyles.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '\$${(index + 1) * 25}.99',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ComoButton.outlined(
                text: 'Add to Cart',
                onPressed: () {
                  // Handle add to cart
                },
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedShoppingCart01,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: ComoButton(
                text: 'Buy Now',
                onPressed: () {
                  // Handle buy now
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
