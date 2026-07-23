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
      expect(AppColors.darkSuccess, equals(const Color(0xFF7DB89A)));
      expect(AppColors.darkSuccessSoft, equals(const Color(0x1A7DB89A)));
      expect(AppColors.darkSuccessGlow, equals(const Color(0x267DB89A)));
      expect(AppColors.darkSuccessText, equals(const Color(0xFFA3D4BC)));
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
      expect(AppColors.lightBackground, equals(const Color(0xFFF5F2EE)));
      expect(AppColors.lightElevatedBackground, equals(const Color(0xFFEDE9E4)));
      expect(AppColors.lightSurface, equals(const Color(0xFFFFFFFF)));
      expect(AppColors.lightSurfaceHover, equals(const Color(0xFFFAF8F5)));
      expect(AppColors.lightPrimary, equals(const Color(0xFFA67C52)));
      expect(AppColors.lightPrimarySoft, equals(const Color(0x1AA67C52)));
      expect(AppColors.lightPrimaryGlow, equals(const Color(0x1FA67C52)));
      expect(AppColors.lightPrimaryText, equals(const Color(0xFF8A633F)));
      expect(AppColors.lightSuccess, equals(const Color(0xFF4A8F6E)));
      expect(AppColors.lightSuccessSoft, equals(const Color(0x144A8F6E)));
      expect(AppColors.lightSuccessGlow, equals(const Color(0x1A4A8F6E)));
      expect(AppColors.lightSuccessText, equals(const Color(0xFF3A7A5C)));
      expect(AppColors.lightMissed, equals(const Color(0xFFA85E4F)));
      expect(AppColors.lightMissedSoft, equals(const Color(0x14A85E4F)));
      expect(AppColors.lightMissedText, equals(const Color(0xFF8C4A3D)));
      expect(AppColors.lightTextPrimary, equals(const Color(0xFF1A1D23)));
      expect(AppColors.lightTextSecondary, equals(const Color(0xFF6B6F76)));
      expect(AppColors.lightTextTertiary, equals(const Color(0xFFA0A5AD)));
      expect(AppColors.lightDivider, equals(const Color(0x0F000000)));
      expect(AppColors.lightDividerStrong, equals(const Color(0x1A000000)));
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
