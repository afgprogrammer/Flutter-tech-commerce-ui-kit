import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_text_field.dart';
import '../../shared/widgets/product_card.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import '../product/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedPriceRange = 'All';
  String _selectedSortBy = 'Relevance';
  String _selectedBrand = 'All';
  double _selectedRating = 0.0;
  bool _inStockOnly = false;
  bool _onSaleOnly = false;
  final List<String> _selectedFilters = [];
  List<Product> _searchResults = [];
  bool _isLoading = false;

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Sports',
    'Books',
    'Beauty',
    'Toys & Games',
    'Automotive',
  ];

  final List<String> _priceRanges = [
    'All',
    'Under \$25',
    '\$25 - \$50',
    '\$50 - \$100',
    '\$100 - \$200',
    'Over \$200',
  ];

  final List<String> _sortOptions = [
    'Relevance',
    'Price: Low to High',
    'Price: High to Low',
    'Customer Rating',
    'Newest First',
    'Name A-Z',
  ];

  final List<String> _brands = [
    'All',
    'Apple',
    'Samsung',
    'Nike',
    'Sony',
    'Canon',
    'Microsoft',
    'Google',
    'Amazon',
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
  }

  void _loadInitialProducts() {
    setState(() {
      _isLoading = true;
    });
    
    // Load initial products (all products)
    _searchResults = ProductService.getAllProducts();
    
    setState(() {
      _isLoading = false;
    });
  }

  void _performSearch(String query) {
    setState(() {
      _isLoading = true;
    });

    if (query.isEmpty) {
      _searchResults = ProductService.getAllProducts();
    } else {
      _searchResults = ProductService.getAllProducts()
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    _applyCurrentFilters();
    
    setState(() {
      _isLoading = false;
    });
  }

  void _applyCurrentFilters() {
    // Apply category filter
    if (_selectedCategory != 'All') {
      _searchResults = _searchResults
          .where((product) => product.category == _selectedCategory)
          .toList();
    }

    // Apply brand filter
    if (_selectedBrand != 'All') {
      _searchResults = _searchResults
          .where((product) => product.brand == _selectedBrand)
          .toList();
    }

    // Apply rating filter
    if (_selectedRating > 0) {
      _searchResults = _searchResults
          .where((product) => product.rating >= _selectedRating)
          .toList();
    }

    // Apply availability filters
    if (_inStockOnly) {
      _searchResults = _searchResults
          .where((product) => product.isInStock)
          .toList();
    }

    if (_onSaleOnly) {
      _searchResults = _searchResults
          .where((product) => product.isOnSale)
          .toList();
    }

    // Apply price range filter
    if (_selectedPriceRange != 'All') {
      switch (_selectedPriceRange) {
        case 'Under \$25':
          _searchResults = _searchResults.where((p) => p.price < 25).toList();
          break;
        case '\$25 - \$50':
          _searchResults = _searchResults.where((p) => p.price >= 25 && p.price <= 50).toList();
          break;
        case '\$50 - \$100':
          _searchResults = _searchResults.where((p) => p.price >= 50 && p.price <= 100).toList();
          break;
        case '\$100 - \$200':
          _searchResults = _searchResults.where((p) => p.price >= 100 && p.price <= 200).toList();
          break;
        case 'Over \$200':
          _searchResults = _searchResults.where((p) => p.price > 200).toList();
          break;
      }
    }

    // Apply sort
    switch (_selectedSortBy) {
      case 'Price: Low to High':
        _searchResults.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        _searchResults.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Customer Rating':
        _searchResults.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Name A-Z':
        _searchResults.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchSection(),
            _buildFilterChips(),
            _buildResultsHeader(),
            Expanded(
              child: _isLoading 
                ? _buildLoadingState()
                : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft01,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              'Search Products',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: Stack(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedFilterHorizontal,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
                if (_selectedFilters.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
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
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(
        AppConstants.paddingM,
        0,
        AppConstants.paddingM,
        AppConstants.paddingM,
      ),
      child: ComoTextField(
        controller: _searchController,
        hint: 'Search for products...',
        prefixIcon: const HugeIcon(
          icon: HugeIcons.strokeRoundedSearch01,
          color: AppColors.textSecondary,
          size: 20,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  _searchController.clear();
                  _performSearch('');
                },
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCancel01,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              )
            : null,
        onChanged: (value) {
          _performSearch(value);
        },
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
        vertical: AppConstants.paddingS,
      ),
      child: Row(
        children: [
          Text(
            '${_searchResults.length} Products Found',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _showSortBottomSheet,
            child: Row(
              children: [
                Text(
                  'Sort',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingXS),
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowDown01,
                  color: AppColors.primary,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildFilterChips() {
    if (_selectedFilters.isEmpty) return const SizedBox.shrink();

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(
        AppConstants.paddingM,
        0,
        AppConstants.paddingM,
        AppConstants.paddingS,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...(_selectedFilters.map((filter) {
              return Container(
                margin: const EdgeInsets.only(right: AppConstants.paddingS),
                child: Chip(
                  label: Text(
                    filter,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  backgroundColor: AppColors.primary,
                  deleteIcon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    color: AppColors.white,
                    size: 16,
                  ),
                  onDeleted: () {
                    setState(() {
                      _selectedFilters.remove(filter);
                      _clearSpecificFilter(filter);
                    });
                  },
                ),
              );
            })),
            if (_selectedFilters.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedFilters.clear();
                    _selectedCategory = 'All';
                    _selectedPriceRange = 'All';
                    _selectedSortBy = 'Relevance';
                    _performSearch(_searchController.text);
                  });
                },
                child: Text(
                  'Clear All',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _clearSpecificFilter(String filter) {
    if (_categories.contains(filter)) {
      _selectedCategory = 'All';
    } else if (_priceRanges.contains(filter)) {
      _selectedPriceRange = 'All';
    } else if (_brands.contains(filter)) {
      _selectedBrand = 'All';
    } else if (filter.contains('Stars')) {
      _selectedRating = 0.0;
    } else if (filter == 'In Stock') {
      _inStockOnly = false;
    } else if (filter == 'On Sale') {
      _onSaleOnly = false;
    } else if (filter.startsWith('Sort:')) {
      _selectedSortBy = 'Relevance';
    }
    _performSearch(_searchController.text);
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: AppConstants.paddingM,
        mainAxisSpacing: AppConstants.paddingM,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
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
          onFavoriteTap: () {
            // Handle favorite tap
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppConstants.paddingL),
          Text(
            'No products found',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            'Try searching with different keywords\nor adjust your filters',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _selectedFilters.clear();
                _selectedCategory = 'All';
                _selectedPriceRange = 'All';
                _selectedSortBy = 'Relevance';
                _loadInitialProducts();
              });
            },
            child: const Text('Clear Search'),
          ),
        ],
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort By',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingM),
            ..._sortOptions.map((option) {
              return ListTile(
                title: Text(
                  option,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: _selectedSortBy == option 
                        ? AppColors.primary 
                        : AppColors.textPrimary,
                  ),
                ),
                trailing: _selectedSortBy == option
                    ? const HugeIcon(
                        icon: HugeIcons.strokeRoundedTick01,
                        color: AppColors.primary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _selectedSortBy = option;
                  });
                  _applyFilters();
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusXL),
              ),
            ),
            child: Column(
              children: [
                _buildFilterHeader(),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingL),
                    children: [
                      _buildCategoryFilter(),
                      _buildPriceRangeFilter(),
                      _buildBrandFilter(),
                      _buildRatingFilter(),
                      _buildAvailabilityFilter(),
                      _buildSortFilter(),
                      const SizedBox(height: AppConstants.paddingXL),
                    ],
                  ),
                ),
                _buildFilterActions(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Products',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingXS),
                    Text(
                      '${_getActiveFilterCount()} filters applied',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getActiveFilterCount() {
    int count = 0;
    if (_selectedCategory != 'All') count++;
    if (_selectedPriceRange != 'All') count++;
    if (_selectedBrand != 'All') count++;
    if (_selectedRating > 0) count++;
    if (_inStockOnly) count++;
    if (_onSaleOnly) count++;
    if (_selectedSortBy != 'Relevance') count++;
    return count;
  }

  Widget _buildCategoryFilter() {
    return _buildFilterContainer(
      title: 'Category',
      icon: HugeIcons.strokeRoundedGrid,
      child: Wrap(
        spacing: AppConstants.paddingS,
        runSpacing: AppConstants.paddingS,
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingM,
                vertical: AppConstants.paddingS,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.grey100,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey200,
                ),
              ),
              child: Text(
                category,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPriceRangeFilter() {
    return _buildFilterContainer(
      title: 'Price Range',
      icon: HugeIcons.strokeRoundedDollar01,
      child: Column(
        children: _priceRanges.map((range) {
          final isSelected = _selectedPriceRange == range;
          return Container(
            margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPriceRange = range;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.grey50,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.grey200,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.grey400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    Expanded(
                      child: Text(
                        range,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBrandFilter() {
    return _buildFilterContainer(
      title: 'Brand',
      icon: HugeIcons.strokeRoundedTag01,
      child: Wrap(
        spacing: AppConstants.paddingS,
        runSpacing: AppConstants.paddingS,
        children: _brands.map((brand) {
          final isSelected = _selectedBrand == brand;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedBrand = brand;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingM,
                vertical: AppConstants.paddingS,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.secondary : AppColors.grey100,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                border: Border.all(
                  color: isSelected ? AppColors.secondary : AppColors.grey200,
                ),
              ),
              child: Text(
                brand,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRatingFilter() {
    return _buildFilterContainer(
      title: 'Minimum Rating',
      icon: HugeIcons.strokeRoundedStar,
      child: Column(
        children: [1, 2, 3, 4, 5].map((rating) {
          final isSelected = _selectedRating == rating.toDouble();
          return Container(
            margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRating = isSelected ? 0.0 : rating.toDouble();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent.withOpacity(0.1) : AppColors.grey50,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.grey200,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    ...List.generate(rating, (index) => const HugeIcon(
                      icon: HugeIcons.strokeRoundedStar,
                      color: AppColors.accent,
                      size: 16,
                    )),
                    ...List.generate(5 - rating, (index) => const HugeIcon(
                      icon: HugeIcons.strokeRoundedStar,
                      color: AppColors.grey300,
                      size: 16,
                    )),
                    const SizedBox(width: AppConstants.paddingS),
                    Text(
                      '$rating & up',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isSelected ? AppColors.accent : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAvailabilityFilter() {
    return _buildFilterContainer(
      title: 'Availability',
      icon: HugeIcons.strokeRoundedCheckmarkBadge02,
      child: Column(
        children: [
          _buildSwitchTile(
            'In Stock Only',
            _inStockOnly,
            (value) => setState(() => _inStockOnly = value),
          ),
          const SizedBox(height: AppConstants.paddingS),
          _buildSwitchTile(
            'On Sale Only',
            _onSaleOnly,
            (value) => setState(() => _onSaleOnly = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSortFilter() {
    return _buildFilterContainer(
      title: 'Sort By',
      icon: HugeIcons.strokeRoundedSortingAZ01,
      child: Column(
        children: _sortOptions.map((option) {
          final isSelected = _selectedSortBy == option;
          return Container(
            margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSortBy = option;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.grey50,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.grey200,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.grey400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    Expanded(
                      child: Text(
                        option,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterContainer({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            decoration: const BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusM),
              ),
            ),
            child: Row(
              children: [
                HugeIcon(
                  icon: icon,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: BoxDecoration(
        color: value ? AppColors.primary.withOpacity(0.1) : AppColors.grey50,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(
          color: value ? AppColors.primary : AppColors.grey200,
          width: value ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: value ? AppColors.primary : AppColors.textPrimary,
                fontWeight: value ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withOpacity(0.3),
            inactiveThumbColor: AppColors.grey400,
            inactiveTrackColor: AppColors.grey200,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterActions() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'All';
                    _selectedPriceRange = 'All';
                    _selectedBrand = 'All';
                    _selectedRating = 0.0;
                    _inStockOnly = false;
                    _onSaleOnly = false;
                    _selectedSortBy = 'Relevance';
                    _selectedFilters.clear();
                  });
                  _performSearch(_searchController.text);
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedRefresh,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: AppConstants.paddingS),
                    Text(
                      'Clear All',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  _applyFilters();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedTick01,
                      color: AppColors.white,
                      size: 18,
                    ),
                    const SizedBox(width: AppConstants.paddingS),
                    Text(
                      'Apply Filters (${_getActiveFilterCount()})',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
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

  void _applyFilters() {
    _selectedFilters.clear();
    
    if (_selectedCategory != 'All') {
      _selectedFilters.add(_selectedCategory);
    }
    
    if (_selectedPriceRange != 'All') {
      _selectedFilters.add(_selectedPriceRange);
    }

    if (_selectedBrand != 'All') {
      _selectedFilters.add(_selectedBrand);
    }

    if (_selectedRating > 0) {
      _selectedFilters.add('${_selectedRating.toInt()}+ Stars');
    }

    if (_inStockOnly) {
      _selectedFilters.add('In Stock');
    }

    if (_onSaleOnly) {
      _selectedFilters.add('On Sale');
    }
    
    if (_selectedSortBy != 'Relevance') {
      _selectedFilters.add('Sort: $_selectedSortBy');
    }
    
    _performSearch(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
