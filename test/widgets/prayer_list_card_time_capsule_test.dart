import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salah_companion/app/theme/app_colors.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
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
        body: child,
      ),
    );
  }

  group('PrayerListCard Dynamic Start/End Time Styling Tests', () {
    testWidgets('prayed prayer renders both start and end time grayed out', (tester) async {
      const prayedList = [
        PrayerItem(
          name: 'Fajr',
          time: '04:45 AM',
          endTime: '06:05 AM',
          status: PrayerStatus.prayed,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          const PrayerListCard(prayers: prayedList),
        ),
      );
      await tester.pumpAndSettle();

      final startTimeFinder = find.text('04:45 AM');
      final endTimeFinder = find.text('06:05 AM');

      expect(startTimeFinder, findsOneWidget);
      expect(endTimeFinder, findsOneWidget);

      final startTextWidget = tester.widget<Text>(startTimeFinder);
      final endTextWidget = tester.widget<Text>(endTimeFinder);

      expect(startTextWidget.style?.color, equals(AppColors.darkTextTertiary));
      expect(endTextWidget.style?.color, equals(AppColors.darkTextTertiary));
    });

    testWidgets('current active prayer renders start time grayed and end time brighter', (tester) async {
      const currentList = [
        PrayerItem(
          name: 'Dhuhr',
          time: '12:15 PM',
          endTime: '03:30 PM',
          isCurrent: true,
          status: PrayerStatus.pending,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          const PrayerListCard(prayers: currentList),
        ),
      );
      await tester.pumpAndSettle();

      final startTimeFinder = find.text('12:15 PM');
      final endTimeFinder = find.text('03:30 PM');

      expect(startTimeFinder, findsOneWidget);
      expect(endTimeFinder, findsOneWidget);

      final startTextWidget = tester.widget<Text>(startTimeFinder);
      final endTextWidget = tester.widget<Text>(endTimeFinder);

      // Start time is grayed
      expect(startTextWidget.style?.color, equals(AppColors.darkTextSecondary));
      // End time is brighter (critical cutoff time)
      expect(endTextWidget.style?.color, equals(AppColors.darkTextPrimary));
      expect(endTextWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('next upcoming prayer renders start time brighter and end time grayed', (tester) async {
      const nextList = [
        PrayerItem(
          name: 'Asr',
          time: '03:30 PM',
          endTime: '06:20 PM',
          isNext: true,
          isFuture: true,
          status: PrayerStatus.pending,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          const PrayerListCard(prayers: nextList),
        ),
      );
      await tester.pumpAndSettle();

      final startTimeFinder = find.text('03:30 PM');
      final endTimeFinder = find.text('06:20 PM');

      expect(startTimeFinder, findsOneWidget);
      expect(endTimeFinder, findsOneWidget);

      final startTextWidget = tester.widget<Text>(startTimeFinder);
      final endTextWidget = tester.widget<Text>(endTimeFinder);

      // Start time is brighter (next target)
      expect(startTextWidget.style?.color, equals(AppColors.darkTextPrimary.withValues(alpha: 0.92)));
      // End time is gray
      expect(endTextWidget.style?.color, equals(AppColors.darkTextSecondary));
    });

    testWidgets('other future prayer renders both start and end time grayed', (tester) async {
      const otherList = [
        PrayerItem(
          name: 'Isha',
          time: '07:50 PM',
          endTime: '04:45 AM',
          isFuture: true,
          status: PrayerStatus.pending,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          const PrayerListCard(prayers: otherList),
        ),
      );
      await tester.pumpAndSettle();

      final startTimeFinder = find.text('07:50 PM');
      final endTimeFinder = find.text('04:45 AM');

      expect(startTimeFinder, findsOneWidget);
      expect(endTimeFinder, findsOneWidget);

      final startTextWidget = tester.widget<Text>(startTimeFinder);
      final endTextWidget = tester.widget<Text>(endTimeFinder);

      expect(startTextWidget.style?.color, equals(AppColors.darkTextSecondary));
      expect(endTextWidget.style?.color, equals(AppColors.darkTextSecondary));
    });
  });
}
