import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  
  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
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
          'Track Order',
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedShare05,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #$orderId',
                        style: AppTextStyles.titleLarge,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingM,
                          vertical: AppConstants.paddingS,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusS),
                        ),
                        child: Text(
                          'In Transit',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar03,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: AppConstants.paddingS),
                      Text(
                        'Ordered on Aug 25, 2025',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedShippingTruck01,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: AppConstants.paddingS),
                      Text(
                        'Expected delivery: Aug 29, 2025',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            // Tracking Progress
            Container(
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
                  Text(
                    'Tracking Progress',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.paddingL),
                  
                  _buildTrackingStep(
                    'Order Confirmed',
                    'Your order has been confirmed',
                    'Aug 25, 10:30 AM',
                    HugeIcons.strokeRoundedCheckmarkCircle01,
                    isCompleted: true,
                    isActive: false,
                  ),
                  
                  _buildTrackingStep(
                    'Order Processed',
                    'Your order is being prepared',
                    'Aug 26, 2:15 PM',
                    HugeIcons.strokeRoundedPackageProcess,
                    isCompleted: true,
                    isActive: false,
                  ),
                  
                  _buildTrackingStep(
                    'Order Shipped',
                    'Your order has been shipped',
                    'Aug 27, 9:45 AM',
                    HugeIcons.strokeRoundedShippingTruck01,
                    isCompleted: true,
                    isActive: false,
                  ),
                  
                  _buildTrackingStep(
                    'In Transit',
                    'Your package is on the way',
                    'Aug 28, 1:20 PM',
                    HugeIcons.strokeRoundedLocation01,
                    isCompleted: false,
                    isActive: true,
                  ),
                  
                  _buildTrackingStep(
                    'Out for Delivery',
                    'Your package is out for delivery',
                    '',
                    HugeIcons.strokeRoundedDeliveryTruck01,
                    isCompleted: false,
                    isActive: false,
                    isLast: false,
                  ),
                  
                  _buildTrackingStep(
                    'Delivered',
                    'Package delivered successfully',
                    '',
                    HugeIcons.strokeRoundedHome03,
                    isCompleted: false,
                    isActive: false,
                    isLast: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            // Delivery Address
            Container(
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
                  Text(
                    'Delivery Address',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedLocation01,
                        color: AppColors.primary,
                        size: 20,
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
                            const SizedBox(height: AppConstants.paddingXS),
                            Text(
                              '123 Main Street, Apt 4B\nNew York, NY 10001\nUnited States',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            // Contact Support Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedCustomerSupport,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.paddingS),
                    Text(
                      'Contact Support',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.primary,
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

  Widget _buildTrackingStep(
    String title,
    String description,
    String time,
    IconData icon, {
    required bool isCompleted,
    required bool isActive,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted || isActive 
                    ? AppColors.primary 
                    : AppColors.background,
                border: isCompleted || isActive 
                    ? null 
                    : Border.all(color: AppColors.border, width: 2),
                shape: BoxShape.circle,
              ),
              child: HugeIcon(
                icon: icon,
                color: isCompleted || isActive 
                    ? AppColors.white 
                    : AppColors.textSecondary,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted 
                    ? AppColors.primary 
                    : AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: AppConstants.paddingM),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: isCompleted || isActive 
                        ? AppColors.textPrimary 
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (time.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.paddingXS),
                  Text(
                    time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (!isLast) const SizedBox(height: AppConstants.paddingM),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
