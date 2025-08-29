import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class ComoTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;

  const ComoTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          enabled: enabled,
          readOnly: readOnly,
          focusNode: focusNode,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled 
                ? AppColors.grey50 
                : AppColors.grey100,
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
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingM,
              vertical: AppConstants.paddingM,
            ),
          ),
        ),
      ],
    );
  }
}

class ComoSearchField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onFilterTap;
  final bool showFilter;

  const ComoSearchField({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.showFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: hint ?? 'Search products...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingM,
                  vertical: AppConstants.paddingM,
                ),
              ),
            ),
          ),
          if (showFilter) ...[
            Container(
              height: 40,
              width: 1,
              color: AppColors.border,
            ),
            IconButton(
              onPressed: onFilterTap,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedFilterHorizontal,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
