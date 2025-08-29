import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';
import '../../shared/widgets/como_text_field.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<Map<String, dynamic>> _helpCategories = [
    {
      'title': 'Account & Profile',
      'icon': HugeIcons.strokeRoundedUser,
      'description': 'Manage your account settings',
      'color': AppColors.primary,
    },
    {
      'title': 'Orders & Shipping',
      'icon': HugeIcons.strokeRoundedPackage,
      'description': 'Track orders and shipping info',
      'color': AppColors.info,
    },
    {
      'title': 'Payment & Billing',
      'icon': HugeIcons.strokeRoundedCreditCard,
      'description': 'Payment methods and billing',
      'color': AppColors.success,
    },
    {
      'title': 'Returns & Refunds',
      'icon': HugeIcons.strokeRoundedRefresh,
      'description': 'Return policy and refunds',
      'color': AppColors.warning,
    },
  ];

  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'How can I track my order?',
      'answer': 'You can track your order by going to "My Orders" section in your profile. Click on the order you want to track and you\'ll see the current status and tracking information.',
      'isExpanded': false,
    },
    {
      'question': 'What is your return policy?',
      'answer': 'We offer a 30-day return policy for most items. Items must be in original condition with tags attached. Some restrictions apply for certain categories like electronics and personal care items.',
      'isExpanded': false,
    },
    {
      'question': 'How do I cancel my order?',
      'answer': 'You can cancel your order within 1 hour of placing it. Go to "My Orders", find your order, and click "Cancel Order". If the option is not available, please contact our support team.',
      'isExpanded': false,
    },
    {
      'question': 'Do you offer international shipping?',
      'answer': 'Yes, we ship to over 50 countries worldwide. Shipping costs and delivery times vary by location. You can check availability and costs during checkout.',
      'isExpanded': false,
    },
    {
      'question': 'How can I change my payment method?',
      'answer': 'You can add, edit, or remove payment methods in your account settings under "Payment Methods". Your default payment method will be used for future orders.',
      'isExpanded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickActions(),
            const SizedBox(height: AppConstants.paddingL),
            _buildHelpCategories(),
            const SizedBox(height: AppConstants.paddingL),
            _buildFAQSection(),
            const SizedBox(height: AppConstants.paddingL),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'Help & Support',
        style: AppTextStyles.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: _showSearchDialog,
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Text(
              'Quick Actions',
              style: AppTextStyles.titleMedium,
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildQuickActionTile(
            icon: HugeIcons.strokeRoundedMessage01,
            title: 'Live Chat',
            subtitle: 'Chat with our support team',
            onTap: _startLiveChat,
          ),
          _buildQuickActionTile(
            icon: HugeIcons.strokeRoundedCall,
            title: 'Call Support',
            subtitle: '+1 (800) 123-4567',
            onTap: _callSupport,
          ),
          _buildQuickActionTile(
            icon: HugeIcons.strokeRoundedMail01,
            title: 'Email Support',
            subtitle: 'support@como.com',
            onTap: _emailSupport,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(AppConstants.paddingS),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: HugeIcon(
              icon: icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.bodyMedium,
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
        ),
        if (showDivider)
          const Divider(height: 1, color: AppColors.border),
      ],
    );
  }

  Widget _buildHelpCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse by Category',
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppConstants.paddingM),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: AppConstants.paddingM,
            mainAxisSpacing: AppConstants.paddingM,
          ),
          itemCount: _helpCategories.length,
          itemBuilder: (context, index) {
            final category = _helpCategories[index];
            return _buildCategoryCard(category);
          },
        ),
      ],
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
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: AppConstants.paddingM),
              Text(
                category['title'],
                style: AppTextStyles.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingXS),
              Text(
                category['description'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: AppTextStyles.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _viewAllFAQs,
                  child: Text(
                    'View All',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            children: _faqItems.map<ExpansionPanel>((faq) {
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      faq['question'],
                      style: AppTextStyles.bodyMedium,
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppConstants.paddingM,
                    0,
                    AppConstants.paddingM,
                    AppConstants.paddingM,
                  ),
                  child: Text(
                    faq['answer'],
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                isExpanded: faq['isExpanded'],
              );
            }).toList(),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _faqItems[panelIndex]['isExpanded'] = !isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Still need help?',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Can\'t find what you\'re looking for? Our support team is here to help you.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingL),
            ComoButton(
              text: 'Contact Support',
              onPressed: _showContactForm,
              isFullWidth: true,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Search Help',
          style: AppTextStyles.titleMedium,
        ),
        content: ComoTextField(
          label: 'Search',
          hint: 'What can we help you with?',
          prefixIcon: const HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            color: AppColors.textSecondary,
            size: 20,
          ),
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
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Search',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startLiveChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Live chat will be available soon'),
      ),
    );
  }

  void _callSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Calling support...'),
      ),
    );
  }

  void _emailSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening email app...'),
      ),
    );
  }

  void _openCategory(Map<String, dynamic> category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${category['title']} help'),
      ),
    );
  }

  void _viewAllFAQs() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening all FAQs'),
      ),
    );
  }

  void _showContactForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => _buildContactForm(),
    );
  }

  Widget _buildContactForm() {
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.paddingL,
        right: AppConstants.paddingL,
        top: AppConstants.paddingL,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppConstants.paddingL,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Contact Support',
                  style: AppTextStyles.titleLarge,
                ),
                const Spacer(),
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
              'What can we help you with?',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingL),
            ComoTextField(
              controller: subjectController,
              label: 'Subject',
              hint: 'Brief description of your issue',
              prefixIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedTag01,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            ComoTextField(
              controller: messageController,
              label: 'Message',
              hint: 'Describe your issue in detail...',
              maxLines: 5,
              prefixIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: AppConstants.paddingL),
            ComoButton(
              text: 'Send Message',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Message sent successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              isFullWidth: true,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedSent,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
          ],
        ),
      ),
    );
  }
}
