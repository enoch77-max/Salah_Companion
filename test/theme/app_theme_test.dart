import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salah_companion/app/theme/app_colors.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/app/theme/app_typography.dart';

final Uint8List _kFontBytes = Uint8List.fromList([
  0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;

    final fontList = [
      'packages/google_fonts/fonts/Inter-Bold.ttf',
      'packages/google_fonts/fonts/Inter-SemiBold.ttf',
      'packages/google_fonts/fonts/Inter-Medium.ttf',
      'packages/google_fonts/fonts/Inter-Regular.ttf',
      'packages/google_fonts/fonts/Amiri-Regular.ttf',
      'packages/google_fonts/fonts/Lora-Italic.ttf',
      'packages/google_fonts/fonts/NotoSansArabic-Regular.ttf',
    ];

    final manifestMap = <String, List<Object?>>{
      for (final font in fontList) font: [font],
    };

    final manifestBinaryData = const StandardMessageCodec().encodeMessage(manifestMap);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      if (message == null) return null;
      final key = const StringCodec().decodeMessage(message);
      if (key != null && key.contains('AssetManifest')) {
        return manifestBinaryData;
      }
      return ByteData.sublistView(_kFontBytes);
    });
  });

  group('AppColors', () {
    test('dark mode color tokens match PRD Section 5.3 specifications', () {
      expect(AppColors.darkBackground, equals(const Color(0xFF0D0F14)));
      expect(AppColors.darkElevatedBackground, equals(const Color(0xFF12151C)));
      expect(AppColors.darkSurface, equals(const Color(0xFF181B22)));
      expect(AppColors.darkSurfaceHover, equals(const Color(0xFF1E222C)));
      expect(AppColors.darkPrimary, equals(const Color(0xFFD4A574)));
      expect(AppColors.darkPrimarySoft, equals(const Color(0x1FD4A574)));
      expect(AppColors.darkPrimaryGlow, equals(const Color(0x2ED4A574)));
      expect(AppColors.darkPrimaryText, equals(const Color(0xFFE8C9A0)));
      expect(AppColors.darkSuccess, equals(const Color(0xFF10B981)));
      expect(AppColors.darkSuccessSoft, equals(const Color(0x2410B981)));
      expect(AppColors.darkSuccessGlow, equals(const Color(0x3810B981)));
      expect(AppColors.darkSuccessText, equals(const Color(0xFF34D399)));
      expect(AppColors.darkMissed, equals(const Color(0xFFC97B6B)));
      expect(AppColors.darkMissedSoft, equals(const Color(0x1AC97B6B)));
      expect(AppColors.darkMissedText, equals(const Color(0xFFE0A090)));
      expect(AppColors.darkTextPrimary, equals(const Color(0xFFF0EDE8)));
      expect(AppColors.darkTextSecondary, equals(const Color(0xFF8B9099)));
      expect(AppColors.darkTextTertiary, equals(const Color(0xFF5A5F68)));
      expect(AppColors.darkDivider, equals(const Color(0x0DFFFFFF)));
      expect(AppColors.darkDividerStrong, equals(const Color(0x17FFFFFF)));
      expect(AppColors.darkShadow, equals(const Color(0x80000000)));
    });

    test('light mode color tokens match PRD Section 5.3 specifications', () {
      expect(AppColors.lightBackground, equals(const Color(0xFFF2F2F7)));
      expect(AppColors.lightElevatedBackground, equals(const Color(0xFFFFFFFF)));
      expect(AppColors.lightSurface, equals(const Color(0xFFFFFFFF)));
      expect(AppColors.lightSurfaceHover, equals(const Color(0xFFF8F9FA)));
      expect(AppColors.lightPrimary, equals(const Color(0xFF0284C7)));
      expect(AppColors.lightPrimarySoft, equals(const Color(0x1A0284C7)));
      expect(AppColors.lightPrimaryGlow, equals(const Color(0x290284C7)));
      expect(AppColors.lightPrimaryText, equals(const Color(0xFF0369A1)));
      expect(AppColors.lightSuccess, equals(const Color(0xFF059669)));
      expect(AppColors.lightSuccessSoft, equals(const Color(0x17059669)));
      expect(AppColors.lightSuccessGlow, equals(const Color(0x2B059669)));
      expect(AppColors.lightSuccessText, equals(const Color(0xFF047857)));
      expect(AppColors.lightMissed, equals(const Color(0xFFDC2626)));
      expect(AppColors.lightMissedSoft, equals(const Color(0x1ADC2626)));
      expect(AppColors.lightMissedText, equals(const Color(0xFFB91C1C)));
      expect(AppColors.lightTextPrimary, equals(const Color(0xFF1C1C1E)));
      expect(AppColors.lightTextSecondary, equals(const Color(0xFF6C6C70)));
      expect(AppColors.lightTextTertiary, equals(const Color(0xFF8E8E93)));
      expect(AppColors.lightDivider, equals(const Color(0x14000000)));
      expect(AppColors.lightDividerStrong, equals(const Color(0x26000000)));
      expect(AppColors.lightShadow, equals(const Color(0x0F000000)));
    });

    test('AppCustomColors ThemeExtension supports copyWith and lerp', () {
      const dark = AppCustomColors.dark;
      const light = AppCustomColors.light;

      final copied = dark.copyWith(primary: Colors.red);
      expect(copied.primary, equals(Colors.red));
      expect(copied.background, equals(dark.background));

      final lerped = dark.lerp(light, 0.5);
      expect(lerped.background, equals(Color.lerp(dark.background, light.background, 0.5)));
      expect(lerped.primary, equals(Color.lerp(dark.primary, light.primary, 0.5)));
    });
  });

  group('AppTypography', () {
    test('createTextTheme returns valid Inter text styles', () {
      final textTheme = AppTypography.createTextTheme(
        textPrimary: AppColors.darkTextPrimary,
        textSecondary: AppColors.darkTextSecondary,
        textTertiary: AppColors.darkTextTertiary,
      );

      expect(textTheme.displayLarge?.fontSize, equals(32));
      expect(textTheme.displayLarge?.letterSpacing, equals(-0.64));
      expect(textTheme.bodyMedium?.fontSize, equals(14));
    });

    test('timerStyle includes tabular figures font feature', () {
      final timerStyle = AppTypography.timerStyle();
      expect(timerStyle.fontSize, equals(36));
      expect(timerStyle.fontFeatures, contains(const FontFeature.tabularFigures()));
    });

    test('specialized font styles configure expected properties', () {
      final quranic = AppTypography.quranicStyle();
      expect(quranic.fontSize, equals(24));
      expect(quranic.fontFamily, contains('Amiri'));

      final hadith = AppTypography.hadithStyle();
      expect(hadith.fontSize, equals(20));
      expect(hadith.fontFamily, contains('Amiri'));

      final quote = AppTypography.quoteTranslationStyle();
      expect(quote.fontStyle, equals(FontStyle.italic));
      expect(quote.fontFamily, contains('Lora'));

      final uiArabic = AppTypography.uiArabicStyle();
      expect(uiArabic.fontFamily, contains('NotoSansArabic'));
    });
  });

  group('AppTheme', () {
    test('dark theme is properly configured with custom tokens and ContinuousRectangleBorder squircles', () {
      final darkTheme = AppTheme.dark;

      expect(darkTheme.brightness, equals(Brightness.dark));
      expect(darkTheme.scaffoldBackgroundColor, equals(AppColors.darkBackground));
      expect(darkTheme.colorScheme.primary, equals(AppColors.darkPrimary));

      // Card shape check
      final cardShape = darkTheme.cardTheme.shape as ContinuousRectangleBorder;
      expect(cardShape.borderRadius, equals(BorderRadius.circular(20)));

      // Button shape check
      final filledBtnStyle = darkTheme.filledButtonTheme.style;
      final btnShape = filledBtnStyle?.shape?.resolve({}) as ContinuousRectangleBorder;
      expect(btnShape.borderRadius, equals(BorderRadius.circular(12)));

      // ThemeExtension check
      final ext = darkTheme.extension<AppCustomColors>();
      expect(ext, isNotNull);
      expect(ext?.primarySoft, equals(AppColors.darkPrimarySoft));
      expect(ext?.success, equals(AppColors.darkSuccess));
      expect(ext?.missed, equals(AppColors.darkMissed));
    });

    test('light theme is properly configured with custom tokens and ContinuousRectangleBorder squircles', () {
      final lightTheme = AppTheme.light;

      expect(lightTheme.brightness, equals(Brightness.light));
      expect(lightTheme.scaffoldBackgroundColor, equals(AppColors.lightBackground));
      expect(lightTheme.colorScheme.primary, equals(AppColors.lightPrimary));

      // Card shape check
      final cardShape = lightTheme.cardTheme.shape as ContinuousRectangleBorder;
      expect(cardShape.borderRadius, equals(BorderRadius.circular(20)));

      // Button shape check
      final filledBtnStyle = lightTheme.filledButtonTheme.style;
      final btnShape = filledBtnStyle?.shape?.resolve({}) as ContinuousRectangleBorder;
      expect(btnShape.borderRadius, equals(BorderRadius.circular(12)));

      // ThemeExtension check
      final ext = lightTheme.extension<AppCustomColors>();
      expect(ext, isNotNull);
      expect(ext?.primarySoft, equals(AppColors.lightPrimarySoft));
      expect(ext?.success, equals(AppColors.lightSuccess));
      expect(ext?.missed, equals(AppColors.lightMissed));
    });

    test('softShadow produces diffuse shadow with radius 24 and offset (0, 8)', () {
      final shadowList = AppTheme.softShadow(const Color(0x80000000));
      expect(shadowList.length, equals(1));
      expect(shadowList.first.blurRadius, equals(24));
      expect(shadowList.first.offset, equals(const Offset(0, 8)));
    });
  });
}
