import 'package:flutter/material.dart';

/// Design system color tokens from PRD Section 5.3.
abstract final class AppColors {
  // Dark mode color tokens
  static const Color darkBackground = Color(0xFF0D0F14);
  static const Color darkElevatedBackground = Color(0xFF12151C);
  static const Color darkSurface = Color(0xFF181B22);
  static const Color darkSurfaceHover = Color(0xFF1E222C);
  static const Color darkPrimary = Color(0xFFD4A574);
  static const Color darkPrimarySoft = Color(0x1FD4A574);
  static const Color darkPrimaryGlow = Color(0x2ED4A574);
  static const Color darkPrimaryText = Color(0xFFE8C9A0);
  static const Color darkSuccess = Color(0xFF7DB89A);
  static const Color darkSuccessSoft = Color(0x1A7DB89A);
  static const Color darkSuccessGlow = Color(0x267DB89A);
  static const Color darkSuccessText = Color(0xFFA3D4BC);
  static const Color darkMissed = Color(0xFFC97B6B);
  static const Color darkMissedSoft = Color(0x1AC97B6B);
  static const Color darkMissedText = Color(0xFFE0A090);
  static const Color darkTextPrimary = Color(0xFFF0EDE8);
  static const Color darkTextSecondary = Color(0xFF8B9099);
  static const Color darkTextTertiary = Color(0xFF5A5F68);
  static const Color darkDivider = Color(0x0DFFFFFF);
  static const Color darkDividerStrong = Color(0x17FFFFFF);
  static const Color darkShadow = Color(0x80000000);

  // Light mode color tokens
  static const Color lightBackground = Color(0xFFF5F2EE);
  static const Color lightElevatedBackground = Color(0xFFEDE9E4);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHover = Color(0xFFFAF8F5);
  static const Color lightPrimary = Color(0xFFA67C52);
  static const Color lightPrimarySoft = Color(0x1AA67C52);
  static const Color lightPrimaryGlow = Color(0x1FA67C52);
  static const Color lightPrimaryText = Color(0xFF8A633F);
  static const Color lightSuccess = Color(0xFF4A8F6E);
  static const Color lightSuccessSoft = Color(0x144A8F6E);
  static const Color lightSuccessGlow = Color(0x1A4A8F6E);
  static const Color lightSuccessText = Color(0xFF3A7A5C);
  static const Color lightMissed = Color(0xFFA85E4F);
  static const Color lightMissedSoft = Color(0x14A85E4F);
  static const Color lightMissedText = Color(0xFF8C4A3D);
  static const Color lightTextPrimary = Color(0xFF1A1D23);
  static const Color lightTextSecondary = Color(0xFF6B6F76);
  static const Color lightTextTertiary = Color(0xFFA0A5AD);
  static const Color lightDivider = Color(0x0F000000);
  static const Color lightDividerStrong = Color(0x1A000000);
  static const Color lightShadow = Color(0x0F000000);
}

/// [ThemeExtension] to provide custom semantic color tokens across the app.
@immutable
class AppCustomColors extends ThemeExtension<AppCustomColors> {
  final Color background;
  final Color elevatedBackground;
  final Color surface;
  final Color surfaceHover;
  final Color primary;
  final Color primarySoft;
  final Color primaryGlow;
  final Color primaryText;
  final Color success;
  final Color successSoft;
  final Color successGlow;
  final Color successText;
  final Color missed;
  final Color missedSoft;
  final Color missedText;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color divider;
  final Color dividerStrong;
  final Color shadow;

  const AppCustomColors({
    required this.background,
    required this.elevatedBackground,
    required this.surface,
    required this.surfaceHover,
    required this.primary,
    required this.primarySoft,
    required this.primaryGlow,
    required this.primaryText,
    required this.success,
    required this.successSoft,
    required this.successGlow,
    required this.successText,
    required this.missed,
    required this.missedSoft,
    required this.missedText,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.divider,
    required this.dividerStrong,
    required this.shadow,
  });

  static const dark = AppCustomColors(
    background: AppColors.darkBackground,
    elevatedBackground: AppColors.darkElevatedBackground,
    surface: AppColors.darkSurface,
    surfaceHover: AppColors.darkSurfaceHover,
    primary: AppColors.darkPrimary,
    primarySoft: AppColors.darkPrimarySoft,
    primaryGlow: AppColors.darkPrimaryGlow,
    primaryText: AppColors.darkPrimaryText,
    success: AppColors.darkSuccess,
    successSoft: AppColors.darkSuccessSoft,
    successGlow: AppColors.darkSuccessGlow,
    successText: AppColors.darkSuccessText,
    missed: AppColors.darkMissed,
    missedSoft: AppColors.darkMissedSoft,
    missedText: AppColors.darkMissedText,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    divider: AppColors.darkDivider,
    dividerStrong: AppColors.darkDividerStrong,
    shadow: AppColors.darkShadow,
  );

  static const light = AppCustomColors(
    background: AppColors.lightBackground,
    elevatedBackground: AppColors.lightElevatedBackground,
    surface: AppColors.lightSurface,
    surfaceHover: AppColors.lightSurfaceHover,
    primary: AppColors.lightPrimary,
    primarySoft: AppColors.lightPrimarySoft,
    primaryGlow: AppColors.lightPrimaryGlow,
    primaryText: AppColors.lightPrimaryText,
    success: AppColors.lightSuccess,
    successSoft: AppColors.lightSuccessSoft,
    successGlow: AppColors.lightSuccessGlow,
    successText: AppColors.lightSuccessText,
    missed: AppColors.lightMissed,
    missedSoft: AppColors.lightMissedSoft,
    missedText: AppColors.lightMissedText,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    divider: AppColors.lightDivider,
    dividerStrong: AppColors.lightDividerStrong,
    shadow: AppColors.lightShadow,
  );

  @override
  AppCustomColors copyWith({
    Color? background,
    Color? elevatedBackground,
    Color? surface,
    Color? surfaceHover,
    Color? primary,
    Color? primarySoft,
    Color? primaryGlow,
    Color? primaryText,
    Color? success,
    Color? successSoft,
    Color? successGlow,
    Color? successText,
    Color? missed,
    Color? missedSoft,
    Color? missedText,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? divider,
    Color? dividerStrong,
    Color? shadow,
  }) {
    return AppCustomColors(
      background: background ?? this.background,
      elevatedBackground: elevatedBackground ?? this.elevatedBackground,
      surface: surface ?? this.surface,
      surfaceHover: surfaceHover ?? this.surfaceHover,
      primary: primary ?? this.primary,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryGlow: primaryGlow ?? this.primaryGlow,
      primaryText: primaryText ?? this.primaryText,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      successGlow: successGlow ?? this.successGlow,
      successText: successText ?? this.successText,
      missed: missed ?? this.missed,
      missedSoft: missedSoft ?? this.missedSoft,
      missedText: missedText ?? this.missedText,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      divider: divider ?? this.divider,
      dividerStrong: dividerStrong ?? this.dividerStrong,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppCustomColors lerp(ThemeExtension<AppCustomColors>? other, double t) {
    if (other is! AppCustomColors) return this;
    return AppCustomColors(
      background: Color.lerp(background, other.background, t)!,
      elevatedBackground: Color.lerp(elevatedBackground, other.elevatedBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHover: Color.lerp(surfaceHover, other.surfaceHover, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      success: Color.lerp(success, other.success, t)!,
      successSoft: Color.lerp(successSoft, other.successSoft, t)!,
      successGlow: Color.lerp(successGlow, other.successGlow, t)!,
      successText: Color.lerp(successText, other.successText, t)!,
      missed: Color.lerp(missed, other.missed, t)!,
      missedSoft: Color.lerp(missedSoft, other.missedSoft, t)!,
      missedText: Color.lerp(missedText, other.missedText, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      dividerStrong: Color.lerp(dividerStrong, other.dividerStrong, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}
