import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/core/localization/language_registry.dart';
import 'package:salah_companion/features/calendar/presentation/screens/hijri_calendar_screen.dart';
import 'package:salah_companion/features/duas/presentation/screens/duas_screen.dart';
import 'package:salah_companion/features/home/presentation/screens/home_screen.dart';
import 'package:salah_companion/features/learn_salah/presentation/screens/learn_salah_hub_screen.dart';
import 'package:salah_companion/features/learn_salah/presentation/screens/salah_step_by_step_screen.dart';
import 'package:salah_companion/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:salah_companion/features/settings/presentation/screens/settings_screen.dart';
import 'package:salah_companion/features/tasbih/presentation/screens/tasbih_screen.dart';
import 'package:salah_companion/features/tracker/presentation/screens/tracker_screen.dart';
import 'package:salah_companion/l10n/generated/app_localizations.dart';

Widget buildTestApp(Widget child, Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.light,
    home: child,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({
      'selected_language_code': 'en',
      'calculation_method_index': 0,
      'asr_fiqh_index': 0,
      'pre_adhan_reminder_enabled': true,
      'has_completed_onboarding': true,
      'selected_adhan_voice': 'Makkah',
    });
  });

  final languagesToTest = LanguageRegistry.supportedLanguages;

  group('Multi-Locale Layout & Overflow Stress Tests Across All 19 Languages', () {
    for (final appLang in languagesToTest) {
      final locale = appLang.locale;

      testWidgets('HomeScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const HomeScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('SettingsScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const SettingsScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('OnboardingScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const OnboardingScreen(isReplay: true), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('LearnSalahHubScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const LearnSalahHubScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('SalahStepByStepScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const SalahStepByStepScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('DuasScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const DuasScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('TrackerScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const TrackerScreen(initialLogs: []), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('TasbihScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const TasbihScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });

      testWidgets('HijriCalendarScreen in \${appLang.englishName} (\${appLang.code})', (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.75;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(buildTestApp(const HijriCalendarScreen(), locale));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        final exc = tester.takeException();
        expect(exc, isNull);
      });
    }
  });
}
