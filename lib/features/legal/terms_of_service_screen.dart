import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
          'Terms of Service',
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Terms of Service shared!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
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
            // Header
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedFile02,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Como Terms of Service',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Last updated: August 2025',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingXL),
            
            // Introduction
            _buildSection(
              '1. Introduction',
              'Welcome to Como! These Terms of Service ("Terms") govern your use of the Como mobile application and related services (collectively, the "Service") operated by Como Inc. ("us", "we", or "our").\n\nBy accessing or using our Service, you agree to be bound by these Terms. If you disagree with any part of these terms, then you may not access the Service.',
            ),
            
            _buildSection(
              '2. Acceptance of Terms',
              'By creating an account or using our Service, you acknowledge that you have read, understood, and agree to be bound by these Terms and our Privacy Policy. These Terms apply to all visitors, users, and others who access or use the Service.',
            ),
            
            _buildSection(
              '3. User Accounts',
              'When you create an account with us, you must provide information that is accurate, complete, and current at all times. You are responsible for safeguarding the password and for all activities that occur under your account.\n\nYou must not:\n• Use another person\'s account without permission\n• Create false accounts or provide false information\n• Share your account credentials with others\n• Use the Service for any illegal or unauthorized purpose',
            ),
            
            _buildSection(
              '4. Product Information and Orders',
              'We strive to provide accurate product descriptions, pricing, and availability information. However, we do not warrant that product descriptions or other content is accurate, complete, reliable, current, or error-free.\n\nAll orders are subject to acceptance and availability. We reserve the right to refuse or cancel any order at any time for any reason, including but not limited to product availability, errors in product or pricing information, or problems identified by our fraud detection systems.',
            ),
            
            _buildSection(
              '5. Payment and Billing',
              'Payment is due immediately upon placing an order. We accept various payment methods as indicated in the app. By providing payment information, you represent and warrant that you are authorized to use the payment method.\n\nAll prices are subject to change without notice. We reserve the right to modify our pricing at any time.',
            ),
            
            _buildSection(
              '6. Shipping and Returns',
              'Shipping times and costs vary based on your location and the products ordered. We will provide estimated delivery times, but these are not guaranteed.\n\nReturns and exchanges are subject to our Return Policy, which can be found in the app or on our website. Items must be returned in their original condition within the specified time frame.',
            ),
            
            _buildSection(
              '7. User Content',
              'You may post reviews, comments, and other content through the Service. You retain ownership of your content, but you grant us a worldwide, royalty-free license to use, display, and distribute your content in connection with the Service.\n\nYou are responsible for your content and must ensure it does not violate these Terms or applicable laws.',
            ),
            
            _buildSection(
              '8. Prohibited Uses',
              'You may not use our Service:\n• For any unlawful purpose or to solicit others to perform unlawful acts\n• To violate any international, federal, provincial, or state regulations, rules, laws, or local ordinances\n• To infringe upon or violate our intellectual property rights or the intellectual property rights of others\n• To harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate\n• To submit false or misleading information\n• To upload viruses or any other type of malicious code',
            ),
            
            _buildSection(
              '9. Intellectual Property Rights',
              'The Service and its original content, features, and functionality are and will remain the exclusive property of Como Inc. and its licensors. The Service is protected by copyright, trademark, and other laws.',
            ),
            
            _buildSection(
              '10. Disclaimers',
              'The information on this Service is provided on an "as is" basis. To the fullest extent permitted by law, we exclude all representations, warranties, and conditions relating to our Service and the use of this Service.',
            ),
            
            _buildSection(
              '11. Limitation of Liability',
              'In no case shall Como Inc., nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, punitive, special, or consequential damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your use of the Service.',
            ),
            
            _buildSection(
              '12. Termination',
              'We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.\n\nUpon termination, your right to use the Service will cease immediately.',
            ),
            
            _buildSection(
              '13. Changes to Terms',
              'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will try to provide at least 30 days notice prior to any new terms taking effect.',
            ),
            
            _buildSection(
              '14. Contact Information',
              'If you have any questions about these Terms of Service, please contact us:\n\nEmail: support@como.app\nAddress: 123 Commerce St, Business City, BC 12345\nPhone: +1 (555) 123-4567',
            ),
            
            const SizedBox(height: AppConstants.paddingXL),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
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
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                    color: AppColors.success,
                    size: 32,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Text(
                    'Terms Acknowledged',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'By using Como, you agree to these terms and conditions.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
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

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppConstants.paddingM),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.paddingM),
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
          child: Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.paddingL),
      ],
    );
  }
}
