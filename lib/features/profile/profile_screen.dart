import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';
import '../order/order_history_screen.dart';
import '../wishlist/wishlist_screen.dart';
import '../address/address_management_screen.dart';
import '../payment/payment_methods_screen.dart';
import '../notifications/notifications_screen.dart';
import '../help/help_support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildProfileStats(),
              _buildMenuSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppConstants.radiusL),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile',
                style: AppTextStyles.titleLarge,
              ),
              IconButton(
                onPressed: () {
                  // Handle settings
                },
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSettings01,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingL),
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.grey200,
            backgroundImage: NetworkImage(AppConstants.placeholderUserImage),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            'John Doe',
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingXS),
          Text(
            'john.doe@email.com',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            children: [
              Expanded(
                child: ComoButton.outlined(
                  text: 'Edit Profile',
                  onPressed: () {
                    // Handle edit profile
                  },
                ),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: ComoButton(
                  text: 'Premium',
                  backgroundColor: AppColors.accent,
                  textColor: AppColors.black,
                  onPressed: () {
                    // Handle premium
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingM),
      padding: const EdgeInsets.all(AppConstants.paddingM),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
                    _buildStatItem('Orders', '12', HugeIcons.strokeRoundedShoppingBag01),
          const SizedBox(width: AppConstants.paddingL),
          _buildStatItem('Wishlist', '24', HugeIcons.strokeRoundedFavourite),
          const SizedBox(width: AppConstants.paddingL),
          _buildStatItem('Reviews', '8', HugeIcons.strokeRoundedStar),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        HugeIcon(
          icon: icon,
          color: AppColors.primary,
          size: AppConstants.iconL,
        ),
        const SizedBox(height: AppConstants.paddingS),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
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
        children: [
          _buildMenuItem(
            'My Orders',
            'View your order history',
            HugeIcons.strokeRoundedInvoice,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryScreen(),
                ),
              );
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'Wishlist',
            'Your saved items',
            HugeIcons.strokeRoundedFavourite,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistScreen(),
                ),
              );
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'Addresses',
            'Manage delivery addresses',
            HugeIcons.strokeRoundedLocation01,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddressManagementScreen(),
                ),
              );
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'Payment Methods',
            'Manage payment options',
            HugeIcons.strokeRoundedCreditCard,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentMethodsScreen(),
                ),
              );
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'Notifications',
            'App notifications settings',
            HugeIcons.strokeRoundedNotification02,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'Help & Support',
            'Get help and contact us',
            HugeIcons.strokeRoundedCustomerSupport,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpSupportScreen(),
                ),
              );
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'About',
            'App info and legal',
            HugeIcons.strokeRoundedInformationCircle,
            () {
              // Handle about
            },
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            'Sign Out',
            'Sign out of your account',
            HugeIcons.strokeRoundedLogout01,
            () {
              // Handle sign out
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: HugeIcon(
        icon: icon,
        color: isDestructive ? AppColors.error : AppColors.primary,
      ),
      title: Text(
        title,
        style: AppTextStyles.titleMedium.copyWith(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: HugeIcon(
        icon: HugeIcons.strokeRoundedArrowRight01,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildMenuDivider() {
    return const Divider(
      height: 1,
      indent: 72,
    );
  }
}
