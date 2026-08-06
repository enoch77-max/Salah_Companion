import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Apple Design Theme System for Salah Companion app.
/// Mapped to exact tokens from PRD Section 5 & /apple-design.
abstract final class AppTheme {
  /// Card corner squircle radius (20pt ContinuousRectangleBorder).
  static final cardShape = ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );

  /// Button and chip squircle radius (12pt ContinuousRectangleBorder).
  static final controlShape = ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );

  /// Soft diffuse shadow per PRD Section 5 & Apple Design.
  static List<BoxShadow> softShadow(Color shadowColor) {
    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
    ];
  }

  /// Dark Mode [ThemeData] (cached instance for instant sub-millisecond theme switching).
  static final ThemeData dark = _buildDarkTheme();

  /// Light Mode [ThemeData] (cached instance for instant sub-millisecond theme switching).
  static final ThemeData light = _buildLightTheme();

  static ThemeData _buildDarkTheme() {
    const customColors = AppCustomColors.dark;
    final textTheme = AppTypography.createTextTheme(
      textPrimary: customColors.textPrimary,
      textSecondary: customColors.textSecondary,
      textTertiary: customColors.textTertiary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: customColors.background,
      canvasColor: customColors.background,
      cardColor: customColors.surface,
      dividerColor: customColors.divider,
      shadowColor: customColors.shadow,
      textTheme: textTheme,
      colorScheme: ColorScheme.dark(
        primary: customColors.primary,
        onPrimary: customColors.background,
        primaryContainer: customColors.primarySoft,
        onPrimaryContainer: customColors.primaryText,
        secondary: customColors.primaryText,
        onSecondary: customColors.background,
        surface: customColors.surface,
        onSurface: customColors.textPrimary,
        error: customColors.missed,
        onError: customColors.background,
        outline: customColors.dividerStrong,
        shadow: customColors.shadow,
      ),
      cardTheme: CardThemeData(
        color: customColors.surface,
        elevation: 0,
        shape: cardShape,
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: customColors.primary,
          foregroundColor: customColors.background,
          elevation: 0,
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: customColors.primary,
          foregroundColor: customColors.background,
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: customColors.textPrimary,
          side: BorderSide(color: customColors.dividerStrong),
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: customColors.primary,
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: textTheme.labelLarge,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: customColors.surface,
        disabledColor: customColors.surfaceHover,
        selectedColor: customColors.primarySoft,
        secondarySelectedColor: customColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: controlShape,
        labelStyle: textTheme.labelMedium,
        side: BorderSide(color: customColors.divider),
      ),
      dividerTheme: DividerThemeData(
        color: customColors.divider,
        thickness: 1,
        space: 1,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: customColors.primary,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return customColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return customColors.primary;
          }
          return customColors.textTertiary.withValues(alpha: 0.3);
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      extensions: const [
        customColors,
      ],
    );
  }

  static ThemeData _buildLightTheme() {
    const customColors = AppCustomColors.light;
    final textTheme = AppTypography.createTextTheme(
      textPrimary: customColors.textPrimary,
      textSecondary: customColors.textSecondary,
      textTertiary: customColors.textTertiary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: customColors.background,
      canvasColor: customColors.background,
      cardColor: customColors.surface,
      dividerColor: customColors.divider,
      shadowColor: customColors.shadow,
      textTheme: textTheme,
      colorScheme: ColorScheme.light(
        primary: customColors.primary,
        onPrimary: Colors.white,
        primaryContainer: customColors.primarySoft,
        onPrimaryContainer: customColors.primaryText,
        secondary: customColors.primaryText,
        onSecondary: Colors.white,
        surface: customColors.surface,
        onSurface: customColors.textPrimary,
        error: customColors.missed,
        onError: Colors.white,
        outline: customColors.dividerStrong,
        shadow: customColors.shadow,
      ),
      cardTheme: CardThemeData(
        color: customColors.surface,
        elevation: 0,
        shape: cardShape,
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: customColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: customColors.primary,
          foregroundColor: Colors.white,
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: customColors.textPrimary,
          side: BorderSide(color: customColors.dividerStrong),
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: customColors.primary,
          shape: controlShape,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: textTheme.labelLarge,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: customColors.surface,
        disabledColor: customColors.surfaceHover,
        selectedColor: customColors.primarySoft,
        secondarySelectedColor: customColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: controlShape,
        labelStyle: textTheme.labelMedium,
        side: BorderSide(color: customColors.divider),
      ),
      dividerTheme: DividerThemeData(
        color: customColors.divider,
        thickness: 1,
        space: 1,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: customColors.primary,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return customColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return customColors.primary;
          }
          return customColors.textTertiary.withValues(alpha: 0.3);
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      extensions: const [
        customColors,
      ],
    );
  }
}

/// Extension on [BuildContext] for ergonomic access to custom app colors.
extension AppThemeContext on BuildContext {
  /// Access custom color tokens from theme extension.
  AppCustomColors get appColors {
    return Theme.of(this).extension<AppCustomColors>() ?? AppCustomColors.dark;
  }
}
