import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_text_field.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _categories = [
    {
      'id': '1',
      'name': 'Electronics',
      'icon': HugeIcons.strokeRoundedLaptop,
      'color': AppColors.primary,
      'itemCount': 1234,
      'subcategories': ['Smartphones', 'Laptops', 'Headphones', 'Cameras'],
    },
    {
      'id': '2',
      'name': 'Fashion',
      'icon': HugeIcons.strokeRoundedTShirt,
      'color': AppColors.secondary,
      'itemCount': 2567,
      'subcategories': ['Men\'s Clothing', 'Women\'s Clothing', 'Shoes', 'Accessories'],
    },
    {
      'id': '3',
      'name': 'Home & Garden',
      'icon': HugeIcons.strokeRoundedHome09,
      'color': AppColors.success,
      'itemCount': 987,
      'subcategories': ['Furniture', 'Decor', 'Kitchen', 'Garden'],
    },
    {
      'id': '4',
      'name': 'Sports',
      'icon': HugeIcons.strokeRoundedFootball,
      'color': AppColors.warning,
      'itemCount': 456,
      'subcategories': ['Fitness', 'Outdoor', 'Team Sports', 'Water Sports'],
    },
    {
      'id': '5',
      'name': 'Beauty',
      'icon': HugeIcons.strokeRoundedFavourite,
      'color': AppColors.accent,
      'itemCount': 789,
      'subcategories': ['Skincare', 'Makeup', 'Hair Care', 'Fragrance'],
    },
    {
      'id': '6',
      'name': 'Books',
      'icon': HugeIcons.strokeRoundedBook02,
      'color': AppColors.info,
      'itemCount': 1567,
      'subcategories': ['Fiction', 'Non-Fiction', 'Educational', 'Children\'s Books'],
    },
    {
      'id': '7',
      'name': 'Toys & Games',
      'icon': HugeIcons.strokeRoundedToyTrain,
      'color': AppColors.primary,
      'itemCount': 321,
      'subcategories': ['Action Figures', 'Board Games', 'Educational Toys', 'Puzzles'],
    },
    {
      'id': '8',
      'name': 'Automotive',
      'icon': HugeIcons.strokeRoundedCar01,
      'color': AppColors.secondary,
      'itemCount': 234,
      'subcategories': ['Car Parts', 'Accessories', 'Tools', 'Motorcycles'],
    },
    {
      'id': '9',
      'name': 'Health',
      'icon': HugeIcons.strokeRoundedStethoscope,
      'color': AppColors.success,
      'itemCount': 567,
      'subcategories': ['Supplements', 'Medical Devices', 'Personal Care', 'Fitness'],
    },
    {
      'id': '10',
      'name': 'Baby & Kids',
      'icon': HugeIcons.strokeRoundedBaby01,
      'color': AppColors.warning,
      'itemCount': 445,
      'subcategories': ['Baby Gear', 'Feeding', 'Clothing', 'Toys'],
    },
    {
      'id': '11',
      'name': 'Pet Supplies',
      'icon': HugeIcons.strokeRoundedFavourite,
      'color': AppColors.accent,
      'itemCount': 289,
      'subcategories': ['Dog Supplies', 'Cat Supplies', 'Bird Supplies', 'Fish Supplies'],
    },
    {
      'id': '12',
      'name': 'Music',
      'icon': HugeIcons.strokeRoundedMusicNote01,
      'color': AppColors.info,
      'itemCount': 678,
      'subcategories': ['Instruments', 'Audio Equipment', 'Sheet Music', 'Accessories'],
    },
  ];

  List<Map<String, dynamic>> get _filteredCategories {
    if (_searchQuery.isEmpty) {
      return _categories;
    }
    return _categories.where((category) {
      return category['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          category['subcategories'].any((sub) => 
              sub.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchSection(),
          Expanded(
            child: _buildCategoriesGrid(),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'Categories',
        style: AppTextStyles.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: _showGridViewOptions,
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedGrid,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: ComoTextField(
        controller: _searchController,
        label: 'Search Categories',
        hint: 'Search for categories...',
        prefixIcon: const HugeIcon(
          icon: HugeIcons.strokeRoundedSearch01,
          color: AppColors.textSecondary,
          size: 20,
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    final filteredCategories = _filteredCategories;

    if (filteredCategories.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: AppConstants.paddingM,
        mainAxisSpacing: AppConstants.paddingM,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return _buildCategoryCard(category);
      },
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
              icon: HugeIcons.strokeRoundedSearch01,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'No categories found',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Try searching with different keywords',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return InkWell(
      onTap: () => _openCategory(category),
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: category['color'].withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.radiusM),
                ),
              ),
              child: Center(
                child: HugeIcon(
                  icon: category['icon'],
                  color: category['color'],
                  size: 48,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['name'],
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.paddingXS),
                    Text(
                      '${category['itemCount']} items',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subcategories:',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppConstants.paddingXS),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: category['subcategories']
                                    .take(3)
                                    .map<Widget>((sub) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: category['color'].withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              AppConstants.radiusXS,
                                            ),
                                          ),
                                          child: Text(
                                            sub,
                                            style: AppTextStyles.labelSmall.copyWith(
                                              color: category['color'],
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                          if (category['subcategories'].length > 3)
                            Text(
                              '+${category['subcategories'].length - 3} more',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                        ],
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

  void _openCategory(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => _buildCategoryDetailsSheet(category),
    );
  }

  Widget _buildCategoryDetailsSheet(Map<String, dynamic> category) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: HugeIcon(
                  icon: category['icon'],
                  color: category['color'],
                  size: 32,
                ),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['name'],
                      style: AppTextStyles.titleLarge,
                    ),
                    const SizedBox(height: AppConstants.paddingXS),
                    Text(
                      '${category['itemCount']} items available',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCancel01,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingL),
          Text(
            'Subcategories',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.paddingM),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: AppConstants.paddingS,
                mainAxisSpacing: AppConstants.paddingS,
              ),
              itemCount: category['subcategories'].length,
              itemBuilder: (context, index) {
                final subcategory = category['subcategories'][index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Opening $subcategory'),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.paddingS),
                    decoration: BoxDecoration(
                      color: category['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusS),
                      border: Border.all(
                        color: category['color'].withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        subcategory,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: category['color'],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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

  void _showGridViewOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
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
            Text(
              'Display Options',
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: AppConstants.paddingL),
            ListTile(
              leading: const HugeIcon(
                icon: HugeIcons.strokeRoundedGrid,
                color: AppColors.primary,
                size: 24,
              ),
              title: const Text('Grid View'),
              subtitle: const Text('2 columns'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                color: AppColors.primary,
                size: 20,
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const HugeIcon(
                icon: HugeIcons.strokeRoundedMenu01,
                color: AppColors.textSecondary,
                size: 24,
              ),
              title: const Text('List View'),
              subtitle: const Text('1 column'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
