import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  bool _darkMode = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';

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
          'Settings',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.paddingM),
            
            _buildSection(
              'Notifications',
              [
                _buildSwitchTile(
                  'Push Notifications',
                  'Receive push notifications on your device',
                  HugeIcons.strokeRoundedNotification02,
                  _pushNotifications,
                  (value) => setState(() => _pushNotifications = value),
                ),
                _buildSwitchTile(
                  'Email Notifications',
                  'Receive notifications via email',
                  HugeIcons.strokeRoundedMail02,
                  _emailNotifications,
                  (value) => setState(() => _emailNotifications = value),
                ),
                _buildSwitchTile(
                  'SMS Notifications',
                  'Receive notifications via SMS',
                  HugeIcons.strokeRoundedMessage01,
                  _smsNotifications,
                  (value) => setState(() => _smsNotifications = value),
                ),
              ],
            ),
            
            _buildSection(
              'Appearance',
              [
                _buildSwitchTile(
                  'Dark Mode',
                  'Use dark theme throughout the app',
                  HugeIcons.strokeRoundedMoon02,
                  _darkMode,
                  (value) => setState(() => _darkMode = value),
                ),
              ],
            ),
            
            _buildSection(
              'Preferences',
              [
                _buildDropdownTile(
                  'Language',
                  'Choose your preferred language',
                  HugeIcons.strokeRoundedTranslate,
                  _selectedLanguage,
                  ['English', 'Spanish', 'French', 'German', 'Italian'],
                  (value) => setState(() => _selectedLanguage = value!),
                ),
                _buildDropdownTile(
                  'Currency',
                  'Select your preferred currency',
                  HugeIcons.strokeRoundedDollarCircle,
                  _selectedCurrency,
                  ['USD', 'EUR', 'GBP', 'JPY', 'CAD'],
                  (value) => setState(() => _selectedCurrency = value!),
                ),
              ],
            ),
            
            _buildSection(
              'Account',
              [
                _buildActionTile(
                  'Change Password',
                  'Update your account password',
                  HugeIcons.strokeRoundedLockPassword,
                  () {},
                ),
                _buildActionTile(
                  'Two-Factor Authentication',
                  'Add an extra layer of security',
                  HugeIcons.strokeRoundedSecurityCheck,
                  () {},
                ),
                _buildActionTile(
                  'Delete Account',
                  'Permanently delete your account',
                  HugeIcons.strokeRoundedDelete02,
                  () {},
                  isDestructive: true,
                ),
              ],
            ),
            
            _buildSection(
              'Legal',
              [
                _buildActionTile(
                  'Terms of Service',
                  'Read our terms and conditions',
                  HugeIcons.strokeRoundedFile02,
                  () {},
                ),
                _buildActionTile(
                  'Privacy Policy',
                  'Learn about our privacy practices',
                  HugeIcons.strokeRoundedSecurityCheck,
                  () {},
                ),
                _buildActionTile(
                  'Licenses',
                  'View open source licenses',
                  HugeIcons.strokeRoundedLicenseMaintenance,
                  () {},
                ),
              ],
            ),
            
            _buildSection(
              'App',
              [
                _buildInfoTile(
                  'Version',
                  'App version 1.0.0',
                  HugeIcons.strokeRoundedInformationCircle,
                ),
                _buildActionTile(
                  'Rate App',
                  'Rate Como on the App Store',
                  HugeIcons.strokeRoundedStar,
                  () {},
                ),
                _buildActionTile(
                  'Share App',
                  'Share Como with friends',
                  HugeIcons.strokeRoundedShare05,
                  () {},
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.paddingXL),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingL),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showLogoutDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedLogout01,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: AppConstants.paddingS),
                      Text(
                        'Logout',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingL),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.paddingL,
            AppConstants.paddingM,
            AppConstants.paddingL,
            AppConstants.paddingS,
          ),
          child: Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingL),
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

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
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
          size: 20,
        ),
      ),
      title: Text(title, style: AppTextStyles.titleSmall),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    IconData icon,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
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
          size: 20,
        ),
      ),
      title: Text(title, style: AppTextStyles.titleSmall),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: const SizedBox(),
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppConstants.paddingS),
        decoration: BoxDecoration(
          color: isDestructive 
              ? AppColors.error.withOpacity(0.1)
              : AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
        ),
        child: HugeIcon(
          icon: icon,
          color: isDestructive ? AppColors.error : AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleSmall.copyWith(
          color: isDestructive ? AppColors.error : null,
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
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(String title, String subtitle, IconData icon) {
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
          size: 20,
        ),
      ),
      title: Text(title, style: AppTextStyles.titleSmall),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: AppTextStyles.titleLarge),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout
            },
            child: Text(
              'Logout',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
