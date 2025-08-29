import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';

class ReviewsScreen extends StatefulWidget {
  final String productId;
  
  const ReviewsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String _selectedFilter = 'All';
  
  final List<String> _filters = ['All', '5 Stars', '4 Stars', '3 Stars', '2 Stars', '1 Star'];
  
  final List<Review> _reviews = [
    Review(
      id: '1',
      userName: 'Sarah Johnson',
      userAvatar: 'SJ',
      rating: 5,
      date: 'Aug 25, 2025',
      title: 'Excellent quality!',
      content: 'This product exceeded my expectations. The quality is amazing and it arrived quickly. Highly recommend!',
      isVerifiedPurchase: true,
      helpfulCount: 12,
    ),
    Review(
      id: '2',
      userName: 'Mike Chen',
      userAvatar: 'MC',
      rating: 4,
      date: 'Aug 23, 2025',
      title: 'Good value for money',
      content: 'Really happy with this purchase. Good quality and fast shipping. Only minor issue was the packaging could be better.',
      isVerifiedPurchase: true,
      helpfulCount: 8,
    ),
    Review(
      id: '3',
      userName: 'Emma Wilson',
      userAvatar: 'EW',
      rating: 5,
      date: 'Aug 20, 2025',
      title: 'Love it!',
      content: 'Perfect product! Exactly what I was looking for. Great customer service too.',
      isVerifiedPurchase: true,
      helpfulCount: 15,
    ),
    Review(
      id: '4',
      userName: 'David Brown',
      userAvatar: 'DB',
      rating: 3,
      date: 'Aug 18, 2025',
      title: 'Average product',
      content: 'It\'s okay, but not as good as I expected. The quality is decent but could be better for the price.',
      isVerifiedPurchase: false,
      helpfulCount: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredReviews = _getFilteredReviews();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
        title: Text(
          'Reviews',
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showWriteReviewBottomSheet();
            },
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedEdit02,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Rating Summary
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(AppConstants.paddingL),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4.5',
                          style: AppTextStyles.headlineLarge,
                        ),
                        const SizedBox(height: AppConstants.paddingS),
                        Row(
                          children: List.generate(5, (index) {
                            return HugeIcon(
                              icon: index < 4 
                                  ? HugeIcons.strokeRoundedStar 
                                  : HugeIcons.strokeRoundedStar,
                              color: index < 4 ? AppColors.warning : AppColors.border,
                              size: 16,
                            );
                          }),
                        ),
                        const SizedBox(height: AppConstants.paddingS),
                        Text(
                          '${_reviews.length} reviews',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppConstants.paddingXL),
                    Expanded(
                      child: Column(
                        children: [
                          _buildRatingBar('5', 0.7, 28),
                          _buildRatingBar('4', 0.5, 15),
                          _buildRatingBar('3', 0.2, 5),
                          _buildRatingBar('2', 0.1, 2),
                          _buildRatingBar('1', 0.05, 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Tabs
          Container(
            height: 50,
            color: AppColors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                
                return Padding(
                  padding: const EdgeInsets.only(right: AppConstants.paddingM),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: AppColors.background,
                    selectedColor: AppColors.primary,
                    labelStyle: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                );
              },
            ),
          ),
          
          const Divider(height: 1),
          
          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingL),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return _buildReviewCard(review);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showWriteReviewBottomSheet();
        },
        backgroundColor: AppColors.primary,
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedEdit02,
          color: AppColors.white,
          size: 20,
        ),
        label: Text(
          'Write Review',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(String stars, double percentage, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            stars,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(width: AppConstants.paddingS),
          const HugeIcon(
            icon: HugeIcons.strokeRoundedStar,
            color: AppColors.warning,
            size: 12,
          ),
          const SizedBox(width: AppConstants.paddingS),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.background,
              valueColor: const AlwaysStoppedAnimation(AppColors.warning),
            ),
          ),
          const SizedBox(width: AppConstants.paddingS),
          Text(
            count.toString(),
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingL),
      padding: const EdgeInsets.all(AppConstants.paddingL),
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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: Text(
                  review.userAvatar,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.userName,
                          style: AppTextStyles.titleSmall,
                        ),
                        if (review.isVerifiedPurchase) ...[
                          const SizedBox(width: AppConstants.paddingS),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.paddingS,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Verified',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.success,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return HugeIcon(
                              icon: HugeIcons.strokeRoundedStar,
                              color: index < review.rating 
                                  ? AppColors.warning 
                                  : AppColors.border,
                              size: 14,
                            );
                          }),
                        ),
                        const SizedBox(width: AppConstants.paddingS),
                        Text(
                          review.date,
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
          
          const SizedBox(height: AppConstants.paddingM),
          
          Text(
            review.title,
            style: AppTextStyles.titleSmall,
          ),
          
          const SizedBox(height: AppConstants.paddingS),
          
          Text(
            review.content,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.4,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingM),
          
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedThumbsUp,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
                label: Text(
                  'Helpful (${review.helpfulCount})',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Report',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Review> _getFilteredReviews() {
    if (_selectedFilter == 'All') return _reviews;
    
    final rating = int.tryParse(_selectedFilter.split(' ')[0]);
    if (rating != null) {
      return _reviews.where((review) => review.rating == rating).toList();
    }
    
    return _reviews;
  }

  void _showWriteReviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstants.radiusL)),
      ),
      builder: (context) => const WriteReviewBottomSheet(),
    );
  }
}

class WriteReviewBottomSheet extends StatefulWidget {
  const WriteReviewBottomSheet({super.key});

  @override
  State<WriteReviewBottomSheet> createState() => _WriteReviewBottomSheetState();
}

class _WriteReviewBottomSheetState extends State<WriteReviewBottomSheet> {
  int _rating = 0;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Write a Review',
                  style: AppTextStyles.titleLarge,
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
              'Rating',
              style: AppTextStyles.titleSmall,
            ),
            const SizedBox(height: AppConstants.paddingS),
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppConstants.paddingS),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedStar,
                      color: index < _rating ? AppColors.warning : AppColors.border,
                      size: 32,
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            Text(
              'Title',
              style: AppTextStyles.titleSmall,
            ),
            const SizedBox(height: AppConstants.paddingS),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Summarize your review',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            Text(
              'Review',
              style: AppTextStyles.titleSmall,
            ),
            const SizedBox(height: AppConstants.paddingS),
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your experience with this product',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            ComoButton(
              text: 'Submit Review',
              onPressed: _rating > 0 ? () {
                Navigator.pop(context);
                // Submit review logic
              } : null,
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final int rating;
  final String date;
  final String title;
  final String content;
  final bool isVerifiedPurchase;
  final int helpfulCount;

  Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.date,
    required this.title,
    required this.content,
    required this.isVerifiedPurchase,
    required this.helpfulCount,
  });
}
