import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool _isTwoFactorEnabled = false;
  String _selectedMethod = 'SMS';
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
          'Two-Factor Authentication',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.paddingM),
            
            // Description
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
                        icon: HugeIcons.strokeRoundedSecurityCheck,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: AppConstants.paddingM),
                      Text(
                        'Enhanced Security',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'Two-factor authentication adds an extra layer of security to your account. When enabled, you\'ll need to provide a verification code in addition to your password.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingXL),
            
            // Enable/Disable 2FA
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppConstants.paddingS),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusS),
                        ),
                        child: const HugeIcon(
                          icon: HugeIcons.strokeRoundedShield01,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Two-Factor Authentication',
                              style: AppTextStyles.titleSmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Add an extra layer of security',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _isTwoFactorEnabled,
                        onChanged: (value) => setState(() => _isTwoFactorEnabled = value),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            if (_isTwoFactorEnabled) ...[
              const SizedBox(height: AppConstants.paddingL),
              
              Text(
                'Authentication Method',
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: AppConstants.paddingM),
              
              // Method Selection
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
                  children: [
                    _buildMethodTile(
                      'SMS',
                      'Receive codes via text message',
                      HugeIcons.strokeRoundedMessage01,
                      _selectedMethod == 'SMS',
                      () => setState(() => _selectedMethod = 'SMS'),
                    ),
                    const Divider(height: 1),
                    _buildMethodTile(
                      'Authenticator App',
                      'Use Google Authenticator or similar app',
                      HugeIcons.strokeRoundedMobileProtection,
                      _selectedMethod == 'Authenticator App',
                      () => setState(() => _selectedMethod = 'Authenticator App'),
                    ),
                    const Divider(height: 1),
                    _buildMethodTile(
                      'Email',
                      'Receive codes via email',
                      HugeIcons.strokeRoundedMail02,
                      _selectedMethod == 'Email',
                      () => setState(() => _selectedMethod = 'Email'),
                    ),
                  ],
                ),
              ),
              
              if (_selectedMethod == 'SMS') ...[
                const SizedBox(height: AppConstants.paddingL),
                
                Text(
                  'Phone Number',
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: AppConstants.paddingS),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '+1 (555) 123-4567',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    prefixIcon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedCall,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
              ],
              
              if (_selectedMethod == 'Authenticator App') ...[
                const SizedBox(height: AppConstants.paddingL),
                
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingM),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Setup Instructions',
                        style: AppTextStyles.titleSmall,
                      ),
                      const SizedBox(height: AppConstants.paddingM),
                      
                      // QR Code placeholder
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(AppConstants.radiusM),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedQrCode01,
                              color: AppColors.textSecondary,
                              size: 48,
                            ),
                            const SizedBox(height: AppConstants.paddingS),
                            Text(
                              'QR Code',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: AppConstants.paddingM),
                      
                      Text(
                        '1. Download an authenticator app\n'
                        '2. Scan the QR code above\n'
                        '3. Enter the 6-digit code to verify',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: AppConstants.paddingXL),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveTwoFactorSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : Text(
                          'Save Settings',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMethodTile(
    String title,
    String subtitle,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppConstants.paddingS),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.textSecondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
        ),
        child: HugeIcon(
          icon: icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleSmall.copyWith(
          color: isSelected ? AppColors.primary : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: isSelected
          ? const HugeIcon(
              icon: HugeIcons.strokeRoundedCheckmarkCircle01,
              color: AppColors.primary,
              size: 20,
            )
          : null,
      onTap: onTap,
    );
  }

  void _saveTwoFactorSettings() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isTwoFactorEnabled 
              ? 'Two-factor authentication enabled!'
              : 'Two-factor authentication disabled!'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }
}
