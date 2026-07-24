import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/home/presentation/screens/home_screen.dart';
import 'package:salah_companion/features/home/presentation/widgets/daily_reflection_card.dart';
import 'package:salah_companion/features/home/presentation/widgets/hijri_strip.dart';
import 'package:salah_companion/features/home/presentation/widgets/prayer_countdown_hero.dart';
import 'package:salah_companion/features/home/presentation/widgets/prayer_list_card.dart';

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

  Widget buildTestableWidget(Widget child, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.dark,
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('PrayerCountdownHero Widget Tests', () {
    testWidgets('renders prayer name and remaining time with tabular figures', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const PrayerCountdownHero(
            nextPrayerName: 'Fajr',
            remainingDuration: Duration(hours: 1, minutes: 24, seconds: 5),
            progress: 0.8,
            animate: false,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('UPCOMING PRAYER'), findsOneWidget);
      expect(find.byKey(const ValueKey('hero_timer_text')), findsOneWidget);

      final timerTextWidget = tester.widget<Text>(find.byKey(const ValueKey('hero_timer_text')));
      expect(timerTextWidget.data, '01:24:05');
      expect(timerTextWidget.style?.fontFeatures, contains(const FontFeature.tabularFigures()));
    });
  });

  group('PrayerListCard Widget Tests', () {
    testWidgets('renders 5 daily prayers and Sunrise', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const PrayerListCard(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('Sunrise'), findsOneWidget);
      expect(find.text('Dhuhr'), findsOneWidget);
      expect(find.text('Asr'), findsOneWidget);
      expect(find.text('Maghrib'), findsOneWidget);
      expect(find.text('Isha'), findsOneWidget);
    });

    testWidgets('toggles status on prayer item tap', (tester) async {
      int? updatedIndex;
      PrayerStatus? updatedStatus;

      await tester.pumpWidget(
        buildTestableWidget(
          PrayerListCard(
            onStatusChanged: (index, status) {
              updatedIndex = index;
              updatedStatus = status;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap toggle button for Dhuhr (index 2 in default list: Fajr(0), Sunrise(1), Dhuhr(2))
      final dhuhrToggle = find.byKey(const ValueKey('toggle_button_Dhuhr'));
      expect(dhuhrToggle, findsOneWidget);

      await tester.tap(dhuhrToggle);
      await tester.pumpAndSettle();

      expect(updatedIndex, equals(2));
      expect(updatedStatus, equals(PrayerStatus.prayed));
    });
  });

  group('HijriStrip Widget Tests', () {
    testWidgets('renders Hijri date and location subtitle', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          HijriStrip(
            dateTime: DateTime(2026, 7, 24),
            locationName: 'Riyadh, Saudi Arabia',
            isTimezoneMismatched: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('hijri_date_text')), findsOneWidget);
      expect(find.byKey(const ValueKey('location_name_text')), findsOneWidget);
      expect(find.text('Riyadh, Saudi Arabia'), findsOneWidget);
      expect(find.byKey(const ValueKey('timezone_mismatch_banner')), findsNothing);
    });

    testWidgets('displays timezone mismatch banner when isTimezoneMismatched is true', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          HijriStrip(
            dateTime: DateTime(2026, 7, 24),
            locationName: 'Dubai, UAE',
            isTimezoneMismatched: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('timezone_mismatch_banner')), findsOneWidget);
      expect(find.text('Using GPS location — device timezone differs'), findsOneWidget);
    });
  });

  group('HomeScreen Full Integration Tests', () {
    testWidgets('renders all home dashboard components and bottom navigation bar', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const HomeScreen(
            nextPrayerName: 'Asr',
            remainingDuration: Duration(hours: 2, minutes: 15, seconds: 0),
            isTimezoneMismatched: true,
            animateHero: false,
          ),
        ),
      );
      await tester.pump();

      // Check sub-widgets present
      expect(find.byType(HijriStrip), findsOneWidget);
      expect(find.byType(PrayerCountdownHero), findsOneWidget);
      expect(find.byType(PrayerListCard), findsOneWidget);
      expect(find.byType(DailyReflectionCard), findsOneWidget);

      // Check bottom nav items
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Qibla'), findsOneWidget);
      expect(find.text('Tracker'), findsOneWidget);
      expect(find.text('Reflection'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Next prayer name "Asr" appears in both Hero and PrayerListCard
      expect(find.text('Asr'), findsNWidgets(2));
      expect(find.text('02:15:00'), findsOneWidget);

      // Tap on nav item (e.g. Qibla nav item at index 1)
      await tester.tap(find.byKey(const ValueKey('nav_item_1')));
      await tester.pump();
    });
  });
}
