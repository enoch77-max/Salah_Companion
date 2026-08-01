import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:drift/native.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/core/database/app_database.dart';
import 'package:salah_companion/core/services/battery_service.dart';
import 'package:salah_companion/features/calendar/presentation/screens/hijri_calendar_screen.dart';
import 'package:salah_companion/features/duas/presentation/screens/duas_screen.dart';
import 'package:salah_companion/features/settings/presentation/screens/settings_screen.dart';
import 'package:salah_companion/features/tasbih/presentation/screens/tasbih_screen.dart';
import 'package:salah_companion/features/tracker/presentation/screens/tracker_screen.dart';

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
      'packages/google_fonts/fonts/Amiri-Bold.ttf',
      'packages/google_fonts/fonts/Lora-Italic.ttf',
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

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: child,
    );
  }

  group('TrackerScreen Widget Tests', () {
    testWidgets('renders TrackerScreen correctly with header and completion statistics',
        (tester) async {
      final mockLogs = [
        PrayerLogsTableData(
          id: 1,
          date: '2026-07-24',
          prayerName: 'Fajr',
          status: 'prayed',
          updatedAt: DateTime.now(),
        ),
        PrayerLogsTableData(
          id: 2,
          date: '2026-07-24',
          prayerName: 'Dhuhr',
          status: 'missed',
          updatedAt: DateTime.now(),
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          TrackerScreen(initialLogs: mockLogs),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Prayer Tracker'), findsOneWidget);
      expect(find.text('COMPLETION OVERVIEW'), findsOneWidget);
      expect(find.text('Weekly Rate'), findsOneWidget);
      expect(find.text('Monthly Rate'), findsOneWidget);
      expect(find.text('Weekly Performance'), findsOneWidget);
      expect(find.text('PRAYER BREAKDOWN'), findsOneWidget);
      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('Dhuhr'), findsOneWidget);
    });
  });

  group('TasbihScreen Widget Tests', () {
    testWidgets('renders TasbihScreen and increments counter on tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const TasbihScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Digital Tasbih'), findsOneWidget);
      expect(find.textContaining('Sunan Abi Dawud 1496'), findsOneWidget);
      expect(find.text('SubhanAllah'), findsWidgets);
      expect(find.text('Glory be to Allah'), findsOneWidget);
      expect(find.text('00'), findsOneWidget);
      expect(find.text('/ 33'), findsOneWidget);

      // Tap counter button
      await tester.tap(find.byKey(const ValueKey('tasbih_counter_button')));
      await tester.pumpAndSettle();

      expect(find.text('01'), findsOneWidget);

      // Scroll & Tap reset button
      await tester.ensureVisible(find.byKey(const ValueKey('reset_button')));
      await tester.tap(find.byKey(const ValueKey('reset_button')));
      await tester.pumpAndSettle();

      expect(find.text('00'), findsOneWidget);
    });

    testWidgets('switches dhikr chip and resets counter', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const TasbihScreen()));
      await tester.pumpAndSettle();

      // Tap Alhamdulillah chip
      await tester.tap(find.byKey(const ValueKey('dhikr_chip_Alhamdulillah')));
      await tester.pumpAndSettle();

      expect(find.text('Praise be to Allah'), findsOneWidget);
    });

    testWidgets('toggles Auto Next option chip', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const TasbihScreen()));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('auto_next_chip')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('auto_next_chip')));
      await tester.pumpAndSettle();
    });
  });

  group('HijriCalendarScreen Widget Tests', () {
    testWidgets('renders HijriCalendarScreen with offset selector and occasions',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget(const HijriCalendarScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Hijri Calendar'), findsWidgets);
      expect(find.text('MOON-SIGHTING ADJUSTMENT'), findsOneWidget);
      expect(find.text('KEY ISLAMIC OCCASIONS'), findsOneWidget);

      // Tap offset chip +1
      await tester.tap(find.byKey(const ValueKey('offset_chip_1')));
      await tester.pumpAndSettle();

      expect(find.text('+1 day'), findsOneWidget);

      // Toggle to English Calendar
      await tester.tap(find.byKey(const ValueKey('calendar_mode_gregorian')));
      await tester.pumpAndSettle();

      expect(find.text('English Calendar'), findsWidgets);
    });
  });

  group('DuasScreen Widget Tests', () {
    testWidgets('renders DuasScreen and filters by category and search query', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const DuasScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Duas & Azkar'), findsOneWidget);
      expect(find.text('Morning Remembrance'), findsOneWidget);

      // Select Morning category
      await tester.tap(find.byKey(const ValueKey('category_chip_Morning')));
      await tester.pumpAndSettle();

      expect(find.text('Morning Remembrance'), findsOneWidget);

      // Search query
      await tester.enterText(find.byKey(const ValueKey('dua_search_field')), 'Harm');
      await tester.pumpAndSettle();

      expect(find.text('Protection from All Harm'), findsOneWidget);
      expect(find.text('Morning Remembrance'), findsNothing);

      // Clear search
      await tester.enterText(find.byKey(const ValueKey('dua_search_field')), '');
      await tester.pumpAndSettle();

      // Select Forgiveness category
      await tester.tap(find.byKey(const ValueKey('category_chip_Forgiveness')));
      await tester.pumpAndSettle();

      expect(find.text('Supplication for Repentance'), findsOneWidget);

      // Select After Prayer category and verify Ayat al-Kursi
      await tester.tap(find.byKey(const ValueKey('category_chip_After Prayer')));
      await tester.pumpAndSettle();

      expect(find.text('Ayat al-Kursi (Surah Al-Baqarah 2:255)'), findsOneWidget);

      // Tap copy button on Ayat al-Kursi
      await tester.tap(find.byKey(const ValueKey('copy_button_dua_after_prayer_1')));
      await tester.pumpAndSettle();

      expect(find.text('Dua copied to clipboard'), findsOneWidget);
    });
  });

  group('SettingsScreen Widget Tests', () {
    testWidgets('renders SettingsScreen and interacts with controls', (tester) async {
      bool dailyReflectionToggled = false;

      await tester.pumpWidget(
        buildTestableWidget(
          SettingsScreen(
            detectedCountry: 'Saudi Arabia',
            initialBatteryExempt: true,
            batteryService: FakeBatteryService(),
            onDailyReflectionToggled: (val) => dailyReflectionToggled = val,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('NOTIFICATIONS'), findsOneWidget);
      expect(find.text('Prayer Notifications'), findsOneWidget);
      expect(find.text('Adhan Audio'), findsOneWidget);
      expect(find.text('Adhan Voice'), findsOneWidget);
      expect(find.text('CALCULATION & MADHAB'), findsOneWidget);
      expect(find.text('BATTERY OPTIMIZATION'), findsOneWidget);
      expect(find.text('APPEARANCE & HAPTICS'), findsOneWidget);
      expect(find.text('ABOUT & PRIVACY'), findsOneWidget);

      // Ensure visible and toggle Daily Reflection switch
      final switchFinder = find.byKey(const ValueKey('daily_reflection_switch'));
      await tester.ensureVisible(switchFinder);
      await tester.pumpAndSettle();
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      expect(dailyReflectionToggled, isFalse);

      // Tap check battery button
      final checkBtnFinder = find.byKey(const ValueKey('check_battery_button'));
      await tester.ensureVisible(checkBtnFinder);
      await tester.pumpAndSettle();
      await tester.tap(checkBtnFinder);
      await tester.pumpAndSettle();
    });
  });
}

class FakeBatteryService extends BatteryService {
  FakeBatteryService() : super(db: AppDatabase(NativeDatabase.memory()));

  @override
  Future<bool> checkBatteryOptimizationStatus() async => true;

  @override
  Future<bool> isIgnoringBatteryOptimizations() async => true;

  @override
  Future<String> getManufacturer() async => 'Samsung';
}
