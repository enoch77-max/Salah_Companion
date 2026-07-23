import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design system typography using GoogleFonts (Inter, Amiri, Lora, Noto Sans Arabic)
/// adhering to Apple Design optical sizing, tracking, and leading principles.
abstract final class AppTypography {
  /// Builds a [TextTheme] for UI chrome using Inter with size-specific letterSpacing and line heights.
  static TextTheme createTextTheme({
    required Color textPrimary,
    required Color textSecondary,
    required Color textTertiary,
  }) {
    return TextTheme(
      // Display styles (large sizes use tight negative tracking per Apple Typography guidelines)
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.64,
        height: 1.15,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.42,
        height: 1.2,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.24,
        height: 1.25,
        color: textPrimary,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.15,
        height: 1.3,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.3,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.35,
        color: textPrimary,
      ),

      // Title styles
      titleLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.35,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.4,
        color: textPrimary,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.4,
        color: textSecondary,
      ),

      // Body styles
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.5,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.5,
        color: textPrimary,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.4,
        color: textSecondary,
      ),

      // Label styles (small text uses positive tracking for legibility)
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.4,
        color: textPrimary,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        color: textSecondary,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        height: 1.4,
        color: textTertiary,
      ),
    );
  }

  /// Style for timers and countdowns using Inter with tabular figures for aligned numbers.
  static TextStyle timerStyle({
    Color? color,
    double fontSize = 36,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: -0.5,
      height: 1.1,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  /// Style for Quranic Arabic text using Amiri.
  static TextStyle quranicStyle({
    Color? color,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.amiri(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.8,
      color: color,
    );
  }

  /// Style for Hadith text using Amiri.
  static TextStyle hadithStyle({
    Color? color,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.amiri(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.7,
      color: color,
    );
  }

  /// Style for quote translations using Lora italic.
  static TextStyle quoteTranslationStyle({
    Color? color,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.lora(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: FontStyle.italic,
      height: 1.5,
      color: color,
    );
  }

  /// Style for general UI Arabic text using Noto Sans Arabic.
  static TextStyle uiArabicStyle({
    Color? color,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.notoSansArabic(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.4,
      color: color,
    );
  }
}
