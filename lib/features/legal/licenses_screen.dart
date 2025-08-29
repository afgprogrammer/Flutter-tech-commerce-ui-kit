import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

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
          'Open Source Licenses',
          style: AppTextStyles.titleLarge,
        ),
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
                    icon: HugeIcons.strokeRoundedLicenseMaintenance,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Open Source Software',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Como uses open source software',
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
            
            // Licenses List
            _buildLicenseSection('Flutter Framework', [
              _buildLicense(
                'Flutter',
                'BSD 3-Clause License',
                'Google Inc.',
                'A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
              ),
              _buildLicense(
                'Dart',
                'BSD 3-Clause License', 
                'Google Inc.',
                'A client-optimized language for fast apps on any platform.',
              ),
            ]),
            
            _buildLicenseSection('UI & Icons', [
              _buildLicense(
                'HugeIcons',
                'MIT License',
                'HugeIcons',
                'A comprehensive icon library with thousands of beautiful icons.',
              ),
              _buildLicense(
                'Google Fonts',
                'SIL Open Font License',
                'Google Inc.',
                'A library of free licensed fonts for Flutter applications.',
              ),
            ]),
            
            _buildLicenseSection('Utility Packages', [
              _buildLicense(
                'path_provider',
                'BSD 3-Clause License',
                'Flutter Team',
                'A Flutter plugin for finding commonly used locations on the filesystem.',
              ),
              _buildLicense(
                'shared_preferences',
                'BSD 3-Clause License',
                'Flutter Team',
                'A Flutter plugin for reading and writing simple key-value pairs.',
              ),
              _buildLicense(
                'http',
                'BSD 3-Clause License',
                'Dart Team',
                'A composable, Future-based library for making HTTP requests.',
              ),
            ]),
            
            _buildLicenseSection('Development Tools', [
              _buildLicense(
                'flutter_lints',
                'BSD 3-Clause License',
                'Flutter Team',
                'Recommended lints for Flutter apps, packages, and plugins.',
              ),
              _buildLicense(
                'build_runner',
                'BSD 3-Clause License',
                'Dart Team',
                'A build system for Dart code generation and modular compilation.',
              ),
            ]),
            
            const SizedBox(height: AppConstants.paddingXL),
            
            // Attribution
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
                    icon: HugeIcons.strokeRoundedFavourite,
                    color: AppColors.error,
                    size: 32,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Text(
                    'Thank You',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingS),
                  Text(
                    'We are grateful to the open source community for making these amazing tools available. Como is built on the shoulders of giants.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening Flutter license page...'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingL,
                        vertical: AppConstants.paddingM,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      ),
                    ),
                    icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedLinkSquare02,
                      color: AppColors.white,
                      size: 16,
                    ),
                    label: Text(
                      'View Flutter Licenses',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseSection(String title, List<Widget> licenses) {
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
            children: _intersperse(
              licenses,
              const Divider(height: 1, color: AppColors.border),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.paddingL),
      ],
    );
  }

  Widget _buildLicense(String name, String license, String author, String description) {
    return ExpansionTile(
      leading: Container(
        padding: const EdgeInsets.all(AppConstants.paddingS),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
        ),
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedCode,
          color: AppColors.primary,
          size: 16,
        ),
      ),
      title: Text(
        name,
        style: AppTextStyles.titleSmall,
      ),
      subtitle: Text(
        '$license • $author',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.paddingL,
            0,
            AppConstants.paddingL,
            AppConstants.paddingM,
          ),
          child: Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _intersperse(List<Widget> children, Widget separator) {
    if (children.isEmpty) return children;
    
    final List<Widget> result = [];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}
