import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:salah_companion/l10n/generated/app_localizations.dart';

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
    ];

    final manifestMap = <String, List<Object?>>{
      for (final font in fontList) font: [font],
    };

    final manifestBinaryData =
        const StandardMessageCodec().encodeMessage(manifestMap);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      final String key = const StringCodec().decodeMessage(message) ?? '';
      if (key == 'AssetManifest.bin') {
        return manifestBinaryData;
      }
      return _kFontBytes.buffer.asByteData();
    });
  });

  group('OnboardingScreen Full UX Suite Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders all 5 stages progressively and completes onboarding',
        (WidgetTester tester) async {
      bool finished = false;
      Locale currentLocale = const Locale('en');

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              theme: AppTheme.dark,
              locale: currentLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: OnboardingScreen(
                onFinish: () => finished = true,
                onLocaleChanged: (newLoc) => setState(() => currentLocale = newLoc),
              ),
            );
          },
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // STAGE 0: Language Selection
      expect(find.text('Choose Your Language'), findsOneWidget);
      expect(find.byKey(const ValueKey('onboarding_system_lang_card')), findsOneWidget);
      expect(find.byKey(const ValueKey('onboarding_main_cta')), findsOneWidget);

      // Tap Next to go to STAGE 1: Dedicated Multi-Slide Visual Feature Showcase
      await tester.tap(find.byKey(const ValueKey('onboarding_main_cta')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // STAGE 1: Visual Feature Showcase
      expect(find.byKey(const ValueKey('visual_feature_showcase_step')), findsOneWidget);
      expect(find.byKey(const ValueKey('showcase_prayer_slide')), findsOneWidget);
      expect(find.byKey(const ValueKey('onboarding_back_btn')), findsOneWidget);

      // Test Qibla showcase tab
      await tester.tap(find.byKey(const ValueKey('showcase_tab_1')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('showcase_qibla_slide')), findsOneWidget);

      // Test Tasbih showcase tab
      await tester.tap(find.byKey(const ValueKey('showcase_tab_2')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('showcase_tasbih_slide')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('showcase_tasbih_slide')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('29'), findsOneWidget);

      // Test Reflection showcase tab
      await tester.tap(find.byKey(const ValueKey('showcase_tab_3')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('showcase_reflection_slide')), findsOneWidget);

      // Test Back button navigates back to Stage 0
      await tester.tap(find.byKey(const ValueKey('onboarding_back_btn')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Choose Your Language'), findsOneWidget);

      // Go forward again to Stage 1
      await tester.tap(find.byKey(const ValueKey('onboarding_main_cta')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('visual_feature_showcase_step')), findsOneWidget);

      // Tap Next to go to STAGE 2: Trust & Privacy Manifesto
      await tester.tap(find.byKey(const ValueKey('onboarding_main_cta')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // STAGE 2: Trust Manifesto
      expect(find.byKey(const ValueKey('trust_manifesto_step')), findsOneWidget);
      expect(find.text('Our Sacred Trust to You'), findsOneWidget);

      // Tap Next to go to STAGE 3: Contextual Permission Priming
      await tester.tap(find.byKey(const ValueKey('onboarding_main_cta')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // STAGE 3: Permission Priming
      expect(find.byKey(const ValueKey('permission_priming_step')), findsOneWidget);
      expect(find.text('Seamless Setup'), findsOneWidget);

      // Tap permission buttons
      await tester.tap(find.byKey(const ValueKey('perm_location_btn')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.byKey(const ValueKey('perm_notif_btn')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Tap Next to go to STAGE 4: Spiritual Dedication
      await tester.tap(find.byKey(const ValueKey('onboarding_main_cta')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // STAGE 4: Spiritual Dedication
      expect(find.byKey(const ValueKey('spiritual_dedication_step')), findsOneWidget);
      expect(find.text('Surah An-Nisa (4:103)'), findsOneWidget);
      expect(find.text('Bismillah • Get Started'), findsOneWidget);

      // Tap final CTA to complete onboarding
      await tester.tap(find.byKey(const ValueKey('onboarding_main_cta')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(finished, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('has_completed_onboarding'), isTrue);
    });

    testWidgets('skipping onboarding sets flag and calls onFinish',
        (WidgetTester tester) async {
      bool finished = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingScreen(
            onFinish: () => finished = true,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('onboarding_skip_btn')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('onboarding_skip_btn')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(finished, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('has_completed_onboarding'), isTrue);
    });
  });
}
