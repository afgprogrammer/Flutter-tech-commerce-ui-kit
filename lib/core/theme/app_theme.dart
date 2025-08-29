import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarThemeDark,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationThemeDark,
      cardTheme: _cardThemeDark,
      bottomNavigationBarTheme: _bottomNavigationBarThemeDark,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      chipTheme: _chipThemeDark,
      dividerTheme: _dividerThemeDark,
      scaffoldBackgroundColor: AppColors.grey900,
      fontFamily: AppTextStyles.fontFamily,
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textOnSecondary,
    tertiary: AppColors.accent,
    onTertiary: AppColors.black,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.surfaceVariant,
    outline: AppColors.border,
    outlineVariant: AppColors.borderDark,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.black,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textOnSecondary,
    tertiary: AppColors.accent,
    onTertiary: AppColors.black,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.grey800,
    onSurface: AppColors.white,
    surfaceContainerHighest: AppColors.grey700,
    outline: AppColors.grey600,
    outlineVariant: AppColors.grey700,
  );

  static TextTheme get _textTheme => TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
  );

  static AppBarTheme get _appBarTheme => AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    scrolledUnderElevation: AppConstants.elevationS,
    surfaceTintColor: AppColors.white,
    titleTextStyle: AppTextStyles.titleLarge.copyWith(
      color: AppColors.textPrimary,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  static AppBarTheme get _appBarThemeDark => AppBarTheme(
    backgroundColor: AppColors.grey800,
    foregroundColor: AppColors.white,
    elevation: 0,
    scrolledUnderElevation: AppConstants.elevationS,
    surfaceTintColor: AppColors.grey800,
    titleTextStyle: AppTextStyles.titleLarge.copyWith(
      color: AppColors.white,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size(0, AppConstants.buttonHeightM),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          textStyle: AppTextStyles.buttonText,
          elevation: AppConstants.elevationS,
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppConstants.buttonHeightM),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          side: const BorderSide(color: AppColors.border, width: 1),
          textStyle: AppTextStyles.buttonText,
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppConstants.buttonHeightM),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          textStyle: AppTextStyles.buttonText,
        ),
      );

  static InputDecorationTheme get _inputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey50,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingM,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      );

  static InputDecorationTheme get _inputDecorationThemeDark =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey700,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.grey600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.grey600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingM,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.grey400,
        ),
      );

  static CardThemeData get _cardTheme => CardThemeData(
        elevation: AppConstants.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        color: AppColors.surface,
        surfaceTintColor: AppColors.surface,
      );

  static CardThemeData get _cardThemeDark => CardThemeData(
        elevation: AppConstants.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        color: AppColors.grey800,
        surfaceTintColor: AppColors.grey800,
      );

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: AppConstants.elevationM,
      );

  static BottomNavigationBarThemeData get _bottomNavigationBarThemeDark =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.grey800,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.grey400,
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: AppConstants.elevationM,
      );

  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textOnSecondary,
        elevation: AppConstants.elevationM,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
      );

  static ChipThemeData get _chipTheme => ChipThemeData(
        backgroundColor: AppColors.grey100,
        selectedColor: AppColors.primary,
        labelStyle: AppTextStyles.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        ),
      );

  static ChipThemeData get _chipThemeDark => ChipThemeData(
        backgroundColor: AppColors.grey700,
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.white),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        ),
      );

  static DividerThemeData get _dividerTheme => const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      );

  static DividerThemeData get _dividerThemeDark => const DividerThemeData(
        color: AppColors.grey600,
        thickness: 1,
        space: 1,
      );
}
