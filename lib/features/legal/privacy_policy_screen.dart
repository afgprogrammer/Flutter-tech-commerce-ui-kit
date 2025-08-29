import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Privacy Policy shared!'),
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
                    icon: HugeIcons.strokeRoundedSecurityCheck,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Como Privacy Policy',
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
              'Como Inc. ("we", "our", or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and related services.\n\nPlease read this Privacy Policy carefully. If you do not agree with the terms of this Privacy Policy, please do not access the application.',
            ),
            
            _buildSection(
              '2. Information We Collect',
              'We may collect information about you in a variety of ways:\n\n• Personal Information: Name, email address, phone number, shipping address, billing information\n• Account Information: Username, password, preferences, purchase history\n• Device Information: Device type, operating system, unique device identifiers\n• Usage Information: How you interact with our app, pages visited, time spent\n• Location Information: With your permission, we may collect location data\n• Payment Information: Credit card details, billing address (processed securely by third-party payment processors)',
            ),
            
            _buildSection(
              '3. How We Use Your Information',
              'We use the information we collect to:\n\n• Provide, operate, and maintain our services\n• Process transactions and send related information\n• Send you technical notices, updates, and administrative messages\n• Respond to your comments, questions, and customer service requests\n• Monitor and analyze usage and trends to improve your experience\n• Personalize your experience and provide content and features that match your interests\n• Send you promotional communications (with your consent)\n• Detect, investigate, and prevent fraudulent transactions and other illegal activities',
            ),
            
            _buildSection(
              '4. Information Sharing and Disclosure',
              'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except in the following circumstances:\n\n• Service Providers: We may share information with trusted third-party service providers who assist us in operating our app\n• Business Transfers: Information may be transferred if we are involved in a merger, acquisition, or sale of assets\n• Legal Requirements: We may disclose information if required by law or to protect our rights and safety\n• Consent: We may share information with your explicit consent',
            ),
            
            _buildSection(
              '5. Data Security',
              'We implement appropriate technical and organizational security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.\n\nHowever, please note that no method of transmission over the internet or electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your information, we cannot guarantee absolute security.',
            ),
            
            _buildSection(
              '6. Data Retention',
              'We retain your personal information only for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.\n\nWhen we no longer need your personal information, we will securely delete or anonymize it.',
            ),
            
            _buildSection(
              '7. Your Privacy Rights',
              'Depending on your location, you may have the following rights regarding your personal information:\n\n• Access: Request access to your personal information\n• Correction: Request correction of inaccurate or incomplete information\n• Deletion: Request deletion of your personal information\n• Portability: Request a copy of your information in a portable format\n• Objection: Object to processing of your personal information\n• Withdrawal: Withdraw consent where processing is based on consent',
            ),
            
            _buildSection(
              '8. Cookies and Tracking Technologies',
              'We may use cookies, web beacons, and other tracking technologies to collect information about your interactions with our app. These technologies help us:\n\n• Remember your preferences and settings\n• Understand how you use our app\n• Improve our services and user experience\n• Provide personalized content and advertisements\n\nYou can control cookie settings through your device settings.',
            ),
            
            _buildSection(
              '9. Third-Party Services',
              'Our app may contain links to third-party websites or services. We are not responsible for the privacy practices of these third parties. We encourage you to read the privacy policies of any third-party services you visit.',
            ),
            
            _buildSection(
              '10. Children\'s Privacy',
              'Our services are not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.',
            ),
            
            _buildSection(
              '11. International Data Transfers',
              'Your information may be transferred to and processed in countries other than your own. These countries may have different data protection laws. We ensure appropriate safeguards are in place to protect your information during such transfers.',
            ),
            
            _buildSection(
              '12. Changes to This Privacy Policy',
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.\n\nYou are advised to review this Privacy Policy periodically for any changes.',
            ),
            
            _buildSection(
              '13. Contact Us',
              'If you have any questions about this Privacy Policy or our privacy practices, please contact us:\n\nEmail: privacy@como.app\nAddress: 123 Commerce St, Business City, BC 12345\nPhone: +1 (555) 123-4567\n\nData Protection Officer: dpo@como.app',
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
                    icon: HugeIcons.strokeRoundedShield01,
                    color: AppColors.success,
                    size: 32,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Text(
                    'Your Privacy Matters',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'We are committed to protecting your personal information and respecting your privacy choices.',
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
