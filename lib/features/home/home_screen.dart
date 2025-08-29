import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/product_card.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import '../categories/categories_screen.dart';
import '../product/product_detail_screen.dart';
import '../notifications/notifications_screen.dart';
import '../cart/cart_screen.dart';
import '../search/search_screen.dart';
import '../wishlist/wishlist_screen.dart';
import '../order/order_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentPromoIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppColors.primary,
            child: CustomScrollView(
              slivers: [
                _buildCustomAppBar(),
                SliverToBoxAdapter(child: _buildModernHeader()),
                SliverToBoxAdapter(child: _buildSearchSection()),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    child: _buildPromoSection())),
                SliverToBoxAdapter(child: _buildQuickActions()),
                SliverToBoxAdapter(child: _buildCategoriesSection()),
                SliverToBoxAdapter(child: _buildFlashSaleSection()),
                SliverToBoxAdapter(child: _buildFeaturedSection()),
                SliverToBoxAdapter(child: _buildTopRatedSection()),
                SliverToBoxAdapter(child: _buildRecentlyViewedSection()),
                SliverToBoxAdapter(child: _buildRecommendedSection()),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppConstants.paddingXL * 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        // Refresh data - in a real app, this would reload products
      });
    }
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: false,
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
    );
  }

  Widget _buildModernHeader() {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with greeting and icons
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreeting(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingXS),
                        Text(
                          'What are you looking for?',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildModernNotificationIcon(),
                  const SizedBox(width: AppConstants.paddingS),
                  _buildModernCartIcon(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernNotificationIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
          },
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          child: Stack(
            children: [
              const Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification02,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernCartIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          child: Stack(
            children: [
              const Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedShoppingCart01,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning! 🌅';
    if (hour < 17) return 'Good Afternoon! ☀️';
    return 'Good Evening! 🌙';
  }

  Widget _buildSearchSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppConstants.paddingM, 
        0, 
        AppConstants.paddingM, 
        AppConstants.paddingM
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingM + 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: Text(
                  'Search for products...',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const HugeIcon(
                icon: HugeIcons.strokeRoundedFilterHorizontal,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: _promoItems.length,
            itemBuilder: (context, index, realIndex) {
              final item = _promoItems[index];
              return _buildPromoCard(item);
            },
            options: CarouselOptions(
              // height: 180,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPromoIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _promoItems.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPromoIndex == entry.key
                      ? AppColors.primary
                      : AppColors.grey300,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard(Map<String, dynamic> item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingS),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item['colors'] as List<Color>,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['title'] as String,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingS),
                Text(
                  item['subtitle'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingM),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to categories with filter based on promo
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: item['colors'][0] as Color,
                      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingS),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      ),
                    ),
                    child: Text(
                      'Shop Now',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            children: [
              Expanded(child: _buildActionCard(
                icon: HugeIcons.strokeRoundedFlash,
                title: 'Flash Sale',
                subtitle: 'Up to 70% off',
                color: AppColors.accent,
                onTap: () {
                  // Navigate to search with flash sale filter
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
              )),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(child: _buildActionCard(
                icon: HugeIcons.strokeRoundedGift,
                title: 'Daily Deals',
                subtitle: 'Best offers',
                color: AppColors.secondary,
                onTap: () {
                  // Navigate to categories with deals filter
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                  );
                },
              )),
            ],
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            children: [
              Expanded(child: _buildActionCard(
                icon: HugeIcons.strokeRoundedFavourite,
                title: 'Wishlist',
                subtitle: 'Saved items',
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WishlistScreen()),
                  );
                },
              )),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(child: _buildActionCard(
                icon: HugeIcons.strokeRoundedTruck,
                title: 'Track Order',
                subtitle: 'Order status',
                color: AppColors.primaryDark,
                onTap: () {
                  // Navigate to order history
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
                  );
                },
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HugeIcon(
              icon: icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              title,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = ProductService.getCategories();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedGrid,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Shop by Category',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriesScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: AppConstants.paddingM),
                  child: _buildCategoryCard(category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              child: Image.network(
                category.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.grey100,
                    child: const Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedImage01,
                        color: AppColors.textSecondary,
                        size: 32,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            category.name,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleSection() {
    final flashSaleProducts = ProductService.getOnSaleProducts().take(6).toList();
    
    if (flashSaleProducts.isEmpty) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedFlash,
                  color: AppColors.accent,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Flash Sale',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingM,
                    vertical: AppConstants.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedClock02,
                        color: AppColors.white,
                        size: 16,
                      ),
                      const SizedBox(width: AppConstants.paddingXS),
                      Text(
                        '02:45:30',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
              itemCount: flashSaleProducts.length,
              itemBuilder: (context, index) {
                final product = flashSaleProducts[index];
                return Container(
                  width: 180,
                  margin: const EdgeInsets.only(right: AppConstants.paddingM),
                  child: ProductCard(
                    imageUrl: product.mainImage,
                    title: product.name,
                    price: '\$${product.price.toStringAsFixed(0)}',
                    originalPrice: product.hasDiscount ? '\$${product.originalPrice.toStringAsFixed(0)}' : null,
                    rating: product.rating,
                    reviewCount: product.reviewCount,
                    badge: product.isOnSale ? '${product.discount}% OFF' : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: product.id,
                          ),
                        ),
                      );
                    },
                    onFavoriteTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    final featuredProducts = ProductService.getFeaturedProducts();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedStar,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Featured Products',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Navigate to search with featured filter
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
              itemCount: featuredProducts.length,
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return Container(
                  width: 180,
                  margin: const EdgeInsets.only(right: AppConstants.paddingM),
                  child: ProductCard(
                    imageUrl: product.mainImage,
                    title: product.name,
                    price: '\$${product.price.toStringAsFixed(0)}',
                    originalPrice: product.hasDiscount ? '\$${product.originalPrice.toStringAsFixed(0)}' : null,
                    rating: product.rating,
                    reviewCount: product.reviewCount,
                    badge: product.isOnSale ? '${product.discount}% OFF' : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: product.id,
                          ),
                        ),
                      );
                    },
                    onFavoriteTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRatedSection() {
    final topRatedProducts = ProductService.getAllProducts()
        .where((p) => p.rating >= 4.5)
        .take(4)
        .toList();
    
    if (topRatedProducts.isEmpty) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedStar,
                  color: AppColors.accent,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Top Rated Products',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Navigate to search with top rated filter
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppConstants.paddingM,
                mainAxisSpacing: AppConstants.paddingM,
              ),
              itemCount: topRatedProducts.length,
              itemBuilder: (context, index) {
                final product = topRatedProducts[index];
                return ProductCard(
                  imageUrl: product.mainImage,
                  title: product.name,
                  price: '\$${product.price.toStringAsFixed(0)}',
                  originalPrice: product.hasDiscount ? '\$${product.originalPrice.toStringAsFixed(0)}' : null,
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  badge: 'Top Rated',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                  onFavoriteTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedSection() {
    // Mock recently viewed products - in a real app, this would come from local storage/cache
    final recentProducts = ProductService.getAllProducts().take(5).toList();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedClock02,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Recently Viewed',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Show confirmation dialog for clearing recently viewed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Clear History'),
                          content: const Text('Are you sure you want to clear your viewing history?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // In a real app, this would clear the history
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('History cleared')),
                                );
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Clear History',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
              itemCount: recentProducts.length,
              itemBuilder: (context, index) {
                final product = recentProducts[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: AppConstants.paddingM),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: product.id,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppConstants.radiusM),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppConstants.radiusM),
                            child: Image.network(
                              product.mainImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.grey100,
                                  child: const Center(
                                    child: HugeIcon(
                                      icon: HugeIcons.strokeRoundedImage01,
                                      color: AppColors.textSecondary,
                                      size: 24,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingS),
                        Text(
                          product.name,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(0)}',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    final recommendedProducts = ProductService.getFeaturedProducts().take(6).toList();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedThumbsUp,
                  color: AppColors.secondary,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Recommended for You',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppConstants.paddingM,
                mainAxisSpacing: AppConstants.paddingM,
              ),
              itemCount: recommendedProducts.length,
              itemBuilder: (context, index) {
                final product = recommendedProducts[index];
                return ProductCard(
                  imageUrl: product.mainImage,
                  title: product.name,
                  price: '\$${product.price.toStringAsFixed(0)}',
                  originalPrice: product.hasDiscount ? '\$${product.originalPrice.toStringAsFixed(0)}' : null,
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  badge: product.isOnSale ? '${product.discount}% OFF' : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                  onFavoriteTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

// Promo banner data
final List<Map<String, dynamic>> _promoItems = [
  {
    'title': 'Summer Mega Sale',
    'subtitle': 'Up to 80% off on fashion items',
    'colors': [AppColors.primary, AppColors.primaryDark],
  },
  {
    'title': 'Tech Deals',
    'subtitle': 'Latest gadgets at amazing prices',
    'colors': [AppColors.secondary, AppColors.secondaryDark],
  },
  {
    'title': 'Free Shipping',
    'subtitle': 'On orders over \$50 worldwide',
    'colors': [AppColors.accent, AppColors.accentDark],
  },
];
