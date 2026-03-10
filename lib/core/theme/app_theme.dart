/// ثيم التطبيق - كل الألوان والأحجام مُعرَّفة هنا
library;

import 'package:flutter/material.dart';
import '../constants/ui_constants.dart';

/// ثيم التطبيق الرئيسي مع دعم RTL
class AppTheme {
  AppTheme._();

  // ─── ألوان العلامة التجارية ───
  static const Color _primaryColor    = Color(0xFF1B4F72);
  static const Color _secondaryColor  = Color(0xFF2E86C1);
  static const Color _accentColor     = Color(0xFFF39C12);
  static const Color _errorColor      = Color(0xFFE74C3C);
  static const Color _successColor    = Color(0xFF27AE60);
  static const Color _warningColor    = Color(0xFFF39C12);
  static const Color _surfaceColor    = Color(0xFFF8F9FA);
  static const Color _cardColor       = Color(0xFFFFFFFF);
  static const Color _textPrimary     = Color(0xFF2C3E50);
  static const Color _textSecondary   = Color(0xFF7F8C8D);
  static const Color _dividerColor    = Color(0xFFECF0F1);

  /// ثيم الوضع الفاتح
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      primary: _primaryColor,
      secondary: _secondaryColor,
      tertiary: _accentColor,
      error: _errorColor,
      surface: _surfaceColor,
    ),
    scaffoldBackgroundColor: _surfaceColor,
    cardTheme: CardThemeData(
      color: _cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.primary,
        fontSize: AppDimensions.fontXl,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(AppDimensions.buttonHeightMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        textStyle: TextStyle(
          fontFamily: AppFonts.primary,
          fontSize: AppDimensions.fontLg,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _primaryColor, width: 2),
        minimumSize: const Size.fromHeight(AppDimensions.buttonHeightMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        textStyle: TextStyle(
          fontFamily: AppFonts.primary,
          fontSize: AppDimensions.fontLg,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
        textStyle: TextStyle(
          fontFamily: AppFonts.primary,
          fontSize: AppDimensions.fontMd,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        borderSide: const BorderSide(color: _dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        borderSide: const BorderSide(color: _dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        borderSide: const BorderSide(color: _primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        borderSide: const BorderSide(color: _errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMd,
        vertical: AppDimensions.spaceMd,
      ),
      labelStyle: TextStyle(
        fontFamily: AppFonts.primary,
        color: _textSecondary,
        fontSize: AppDimensions.fontMd,
      ),
      hintStyle: TextStyle(
        fontFamily: AppFonts.primary,
        color: _textSecondary,
        fontSize: AppDimensions.fontMd,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _dividerColor,
      thickness: 1,
    ),
    textTheme: _buildTextTheme(brightness: Brightness.light),
    extensions: [_AppColors.light],
  );

  /// ثيم الوضع الداكن
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.primary,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
      primary: const Color(0xFF5DADE2),
      secondary: _secondaryColor,
      tertiary: _accentColor,
      error: _errorColor,
      surface: const Color(0xFF1A1A2E),
    ),
    scaffoldBackgroundColor: const Color(0xFF16213E),
    textTheme: _buildTextTheme(brightness: Brightness.dark),
    extensions: [_AppColors.dark],
  );

  static TextTheme _buildTextTheme({required Brightness brightness}) {
    final color = brightness == Brightness.light ? _textPrimary : Colors.white;
    final secondary = brightness == Brightness.light ? _textSecondary : Colors.white70;
    return TextTheme(
      displayLarge:  TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontDisplay, fontWeight: FontWeight.bold, color: color),
      displayMedium: TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontXxl, fontWeight: FontWeight.bold, color: color),
      displaySmall:  TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontXl, fontWeight: FontWeight.w600, color: color),
      headlineLarge: TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontXl, fontWeight: FontWeight.bold, color: color),
      headlineMedium:TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontLg, fontWeight: FontWeight.w600, color: color),
      headlineSmall: TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontMd, fontWeight: FontWeight.w600, color: color),
      bodyLarge:     TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontLg, color: color),
      bodyMedium:    TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontMd, color: color),
      bodySmall:     TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontSm, color: secondary),
      labelLarge:    TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontMd, fontWeight: FontWeight.w600, color: color),
      labelMedium:   TextStyle(fontFamily: AppFonts.primary, fontSize: AppDimensions.fontSm, fontWeight: FontWeight.w500, color: secondary),
    );
  }
}

/// امتداد ألوان مخصصة للتطبيق
class _AppColors extends ThemeExtension<_AppColors> {
  const _AppColors({
    required this.success,
    required this.warning,
    required this.textSecondary,
  });

  final Color success;
  final Color warning;
  final Color textSecondary;

  static const _AppColors light = _AppColors(
    success: Color(0xFF27AE60),
    warning: Color(0xFFF39C12),
    textSecondary: Color(0xFF7F8C8D),
  );

  static const _AppColors dark = _AppColors(
    success: Color(0xFF2ECC71),
    warning: Color(0xFFF1C40F),
    textSecondary: Color(0xFFBDC3C7),
  );

  @override
  _AppColors copyWith({Color? success, Color? warning, Color? textSecondary}) =>
      _AppColors(
        success: success ?? this.success,
        warning: warning ?? this.warning,
        textSecondary: textSecondary ?? this.textSecondary,
      );

  @override
  _AppColors lerp(_AppColors? other, double t) {
    if (other == null) return this;
    return _AppColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}
