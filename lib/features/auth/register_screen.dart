import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';
import '../../shared/widgets/como_text_field.dart';
import 'login_screen.dart';
import '../main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.paddingXL),
              
              // Back Button
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft01,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              // Header
              Text(
                'Create Account',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppConstants.paddingS),
              Text(
                'Sign up to start shopping with Como',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingXL),
              
              // Registration Form
              Text(
                'Full Name',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              ComoTextField(
                controller: _nameController,
                hint: 'Enter your full name',
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                keyboardType: TextInputType.name,
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              Text(
                'Email',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              ComoTextField(
                controller: _emailController,
                hint: 'Enter your email',
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedMail02,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              Text(
                'Password',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              ComoTextField(
                controller: _passwordController,
                hint: 'Create a password',
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLockPassword,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: HugeIcon(
                    icon: _isPasswordVisible 
                        ? HugeIcons.strokeRoundedView 
                        : HugeIcons.strokeRoundedViewOff,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              Text(
                'Confirm Password',
                style: AppTextStyles.titleSmall,
              ),
              const SizedBox(height: AppConstants.paddingS),
              ComoTextField(
                controller: _confirmPasswordController,
                hint: 'Confirm your password',
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLockPassword,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: HugeIcon(
                    icon: _isConfirmPasswordVisible 
                        ? HugeIcons.strokeRoundedView 
                        : HugeIcons.strokeRoundedViewOff,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              // Terms and Conditions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style: AppTextStyles.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              // Sign Up Button
              ComoButton(
                text: 'Create Account',
                onPressed: _acceptTerms ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                  );
                } : null,
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              // Social Sign Up
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                    child: Text(
                      'Or sign up with',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingL),
              
              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton(
                      'Google',
                      HugeIcons.strokeRoundedGoogle,
                      () {},
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    child: _buildSocialButton(
                      'Apple',
                      HugeIcons.strokeRoundedApple,
                      () {},
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingXL),
              
              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppTextStyles.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, IconData icon, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: icon,
            color: AppColors.textPrimary,
            size: 20,
          ),
          const SizedBox(width: AppConstants.paddingS),
          Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
