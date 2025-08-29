import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
          'Change Password',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Form(
          key: _formKey,
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
                child: Row(
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedInformationCircle,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    Expanded(
                      child: Text(
                        'Create a strong password with at least 8 characters, including uppercase, lowercase, numbers, and special characters.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingXL),
              
              // Current Password
              Text(
                'Current Password',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: !_showCurrentPassword,
                decoration: InputDecoration(
                  hintText: 'Enter your current password',
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
                    icon: HugeIcons.strokeRoundedLockPassword,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _showCurrentPassword = !_showCurrentPassword),
                    icon: HugeIcon(
                      icon: _showCurrentPassword 
                          ? HugeIcons.strokeRoundedView 
                          : HugeIcons.strokeRoundedViewOff,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              // New Password
              Text(
                'New Password',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              TextFormField(
                controller: _newPasswordController,
                obscureText: !_showNewPassword,
                decoration: InputDecoration(
                  hintText: 'Enter your new password',
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
                    icon: HugeIcons.strokeRoundedLockPassword,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _showNewPassword = !_showNewPassword),
                    icon: HugeIcon(
                      icon: _showNewPassword 
                          ? HugeIcons.strokeRoundedView 
                          : HugeIcons.strokeRoundedViewOff,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]').hasMatch(value)) {
                    return 'Password must include uppercase, lowercase, number, and special character';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              // Confirm Password
              Text(
                'Confirm New Password',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirm your new password',
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
                    icon: HugeIcons.strokeRoundedLockPassword,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                    icon: HugeIcon(
                      icon: _showConfirmPassword 
                          ? HugeIcons.strokeRoundedView 
                          : HugeIcons.strokeRoundedViewOff,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppConstants.paddingXL),
              
              // Change Password Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
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
                          'Change Password',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password changed successfully!'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }
}
