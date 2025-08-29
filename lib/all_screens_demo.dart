import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_constants.dart';
import '../features/main/main_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/product/product_detail_screen.dart';
import '../features/wishlist/wishlist_screen.dart';
import '../features/order/order_history_screen.dart';
import '../features/order/order_tracking_screen.dart';
import '../features/address/address_management_screen.dart';
import '../features/payment/payment_methods_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/help/help_support_screen.dart';
import '../features/checkout/checkout_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/reviews/reviews_screen.dart';

class AllScreensDemo extends StatelessWidget {
  const AllScreensDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Como UI Kit - All Screens',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedInformationCircle,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: AppConstants.paddingS),
                      Text(
                        'Como E-commerce UI Kit',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'Complete e-commerce UI kit with clean architecture, HugeIcons, and minimal design. All screens are accessible and properly connected.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.paddingL),
            
            _buildSection(
              'Main App Flow',
              [
                _buildScreenTile(
                  'Main Screen',
                  'Bottom navigation with all main screens',
                  HugeIcons.strokeRoundedHome03,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MainScreen())),
                ),
              ],
            ),
            
            _buildSection(
              'Authentication & Onboarding',
              [
                _buildScreenTile(
                  'Onboarding',
                  'App introduction and welcome screens',
                  HugeIcons.strokeRoundedPresentation01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingScreen())),
                ),
                _buildScreenTile(
                  'Login',
                  'User authentication and sign in',
                  HugeIcons.strokeRoundedLogin01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                ),
                _buildScreenTile(
                  'Register',
                  'User registration and account creation',
                  HugeIcons.strokeRoundedUserAdd01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                ),
              ],
            ),
            
            _buildSection(
              'Product & Shopping',
              [
                _buildScreenTile(
                  'Categories',
                  'Browse all product categories',
                  HugeIcons.strokeRoundedGrid,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen())),
                ),
                _buildScreenTile(
                  'Product Detail',
                  'Detailed product information',
                  HugeIcons.strokeRoundedShoppingBag01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductDetailScreen(productId: 'demo_product'))),
                ),
                _buildScreenTile(
                  'Wishlist',
                  'Favorite products management',
                  HugeIcons.strokeRoundedFavourite,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen())),
                ),
                _buildScreenTile(
                  'Checkout',
                  'Complete purchase flow',
                  HugeIcons.strokeRoundedShoppingCart01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                ),
                _buildScreenTile(
                  'Reviews',
                  'Product reviews and ratings',
                  HugeIcons.strokeRoundedStar,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewsScreen(productId: 'demo_product'))),
                ),
              ],
            ),
            
            _buildSection(
              'Account Management',
              [
                _buildScreenTile(
                  'Order History',
                  'Track and manage orders',
                  HugeIcons.strokeRoundedInvoice,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryScreen())),
                ),
                _buildScreenTile(
                  'Order Tracking',
                  'Real-time order tracking',
                  HugeIcons.strokeRoundedLocation01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen(orderId: 'CO123456'))),
                ),
                _buildScreenTile(
                  'Address Management',
                  'Shipping addresses',
                  HugeIcons.strokeRoundedLocation01,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressManagementScreen())),
                ),
                _buildScreenTile(
                  'Payment Methods',
                  'Manage payment options',
                  HugeIcons.strokeRoundedCreditCard,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodsScreen())),
                ),
                _buildScreenTile(
                  'Settings',
                  'App preferences and configuration',
                  HugeIcons.strokeRoundedSettings02,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                ),
              ],
            ),
            
            _buildSection(
              'Communication & Support',
              [
                _buildScreenTile(
                  'Notifications',
                  'App notifications center',
                  HugeIcons.strokeRoundedNotification02,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                ),
                _buildScreenTile(
                  'Help & Support',
                  'Customer support center',
                  HugeIcons.strokeRoundedCustomerSupport,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen())),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.paddingXL),
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                    color: AppColors.success,
                    size: 32,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Text(
                    'All screens are fully functional and connected!',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.success,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'Start with the Main Screen to experience the complete app flow.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.success,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleLarge,
        ),
        const SizedBox(height: AppConstants.paddingM),
        Container(
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
            children: children,
          ),
        ),
        const SizedBox(height: AppConstants.paddingL),
      ],
    );
  }

  Widget _buildScreenTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppConstants.paddingS),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
        ),
        child: HugeIcon(
          icon: icon,
          color: AppColors.primary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const HugeIcon(
        icon: HugeIcons.strokeRoundedArrowRight01,
        color: AppColors.textSecondary,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
