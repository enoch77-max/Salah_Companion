import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/localization/language_registry.dart';
import 'package:salah_companion/l10n/generated/app_localizations.dart';

void main() {
  group('AppLocalizations Tests - 19 Muslim World & Global Languages', () {
    test('Supported locales include all 19 target languages', () {
      final languageCodes = AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
      final expectedLanguages = {
        'en', 'ar', 'ur', 'fa', 'tr', 'id', 'ms', 'bn', 'ru', 'kk',
        'uz', 'ky', 'az', 'bs', 'sq', 'sw', 'hi', 'fr', 'de',
      };
      expect(languageCodes, containsAll(expectedLanguages));
      expect(LanguageRegistry.supportedLanguages.length, 19);
    });

    test('LanguageRegistry correctly flags RTL languages', () {
      expect(LanguageRegistry.getLanguage('ar').isRTL, isTrue);
      expect(LanguageRegistry.getLanguage('ur').isRTL, isTrue);
      expect(LanguageRegistry.getLanguage('fa').isRTL, isTrue);
      expect(LanguageRegistry.getLanguage('en').isRTL, isFalse);
      expect(LanguageRegistry.getLanguage('tr').isRTL, isFalse);
      expect(LanguageRegistry.getLanguage('id').isRTL, isFalse);
    });

    test('LanguageRegistry resolves device language and defaults safely', () {
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('ar')).code, 'ar');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('ur')).code, 'ur');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('tr')).code, 'tr');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('id')).code, 'id');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('bn')).code, 'bn');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('ru')).code, 'ru');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('kk')).code, 'kk');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('uz')).code, 'uz');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('ky')).code, 'ky');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('az')).code, 'az');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('bs')).code, 'bs');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('sq')).code, 'sq');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('sw')).code, 'sw');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('hi')).code, 'hi');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('fr')).code, 'fr');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('de')).code, 'de');
      expect(LanguageRegistry.resolveDeviceLanguage(const Locale('xx')).code, 'en');
    });

    testWidgets('Loads English strings correctly', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );

      expect(find.text('Salah Companion'), findsOneWidget);
      expect(localizations.navHome, 'Home');
      expect(localizations.prayerFajr, 'Fajr');
      expect(localizations.onboardingChooseLanguage, 'Choose Your Language');
      expect(localizations.notificationEarlyReminderTitle('Fajr'), 'Early Prayer Reminder — Fajr');
    });

    testWidgets('Loads Arabic strings correctly (Classical Arabic & RTL)', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ar'),
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );

      expect(find.text('رفيق الصلاة'), findsOneWidget);
      expect(localizations.navHome, 'الرئيسية');
      expect(localizations.prayerFajr, 'الفجر');
      expect(localizations.prayerDhuhr, 'الظهر');
      expect(localizations.onboardingChooseLanguage, 'اختر لغتك');
      expect(localizations.notificationPrayerStartBody('الفجر'), 'حان الآن موعد أذان الفجر. حي على الصلاة.');
    });

    testWidgets('Loads Urdu strings correctly (RTL)', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ur'),
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );

      expect(find.text('صلاۃ کمپینین'), findsOneWidget);
      expect(localizations.prayerFajr, 'فجر');
      expect(localizations.onboardingChooseLanguage, 'اپنی زبان منتخب کریں');
    });

    testWidgets('Loads Turkish strings correctly', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('tr'),
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );

      expect(find.text('Salah Companion'), findsOneWidget);
      expect(localizations.prayerFajr, 'İmsak');
      expect(localizations.onboardingChooseLanguage, 'Dilinizi Seçin');
    });

    testWidgets('Loads Indonesian strings correctly', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('id'),
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );

      expect(find.text('Salah Companion'), findsOneWidget);
      expect(localizations.prayerFajr, 'Subuh');
      expect(localizations.onboardingChooseLanguage, 'Pilih Bahasa Anda');
    });

    testWidgets('Loads Bengali strings correctly', (WidgetTester tester) async {
      late AppLocalizations localizations;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('bn'),
          home: Builder(
            builder: (context) {
              localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );

      expect(find.text('সালাহ কম্প্যানিয়ন'), findsOneWidget);
      expect(localizations.prayerFajr, 'ফজর');
      expect(localizations.onboardingChooseLanguage, 'আপনার ভাষা নির্বাচন করুন');
    });
  });
}
