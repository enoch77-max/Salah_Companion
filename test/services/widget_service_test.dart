import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salah_companion/core/services/widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  group('WidgetService - Time Formatting', () {
    final service = WidgetService();

    test('formats morning AM time correctly', () {
      final time = DateTime(2026, 7, 24, 6, 45);
      expect(service.formatPrayerTime(time), equals('06:45 AM'));
    });

    test('formats evening PM time correctly', () {
      final time = DateTime(2026, 7, 24, 18, 45);
      expect(service.formatPrayerTime(time), equals('06:45 PM'));
    });

    test('formats noon time correctly', () {
      final time = DateTime(2026, 7, 24, 12, 0);
      expect(service.formatPrayerTime(time), equals('12:00 PM'));
    });

    test('formats midnight time correctly', () {
      final time = DateTime(2026, 7, 24, 0, 15);
      expect(service.formatPrayerTime(time), equals('12:15 AM'));
    });
  });

  group('WidgetService - Next Prayer Determination', () {
    final service = WidgetService();

    final prayerTimes = <String, DateTime>{
      'Fajr': DateTime(2026, 7, 24, 5, 0),
      'Sunrise': DateTime(2026, 7, 24, 6, 30),
      'Dhuhr': DateTime(2026, 7, 24, 12, 30),
      'Asr': DateTime(2026, 7, 24, 15, 45),
      'Maghrib': DateTime(2026, 7, 24, 18, 45),
      'Isha': DateTime(2026, 7, 24, 20, 15),
    };

    test('determines Dhuhr as next prayer when now is 10:00 AM', () {
      final now = DateTime(2026, 7, 24, 10, 0);
      final result = service.determineNextPrayer(prayerTimes, now: now);

      expect(result.name, equals('Dhuhr'));
      expect(result.time, equals(prayerTimes['Dhuhr']));
    });

    test('determines Maghrib as next prayer when now is 17:00', () {
      final now = DateTime(2026, 7, 24, 17, 0);
      final result = service.determineNextPrayer(prayerTimes, now: now);

      expect(result.name, equals('Maghrib'));
      expect(result.time, equals(prayerTimes['Maghrib']));
    });

    test('determines next day Fajr when now is after Isha (22:00)', () {
      final now = DateTime(2026, 7, 24, 22, 0);
      final result = service.determineNextPrayer(prayerTimes, now: now);

      expect(result.name, equals('Fajr'));
      expect(result.time, equals(DateTime(2026, 7, 25, 5, 0)));
    });

    test('uses explicit nextDayFajr when provided', () {
      final now = DateTime(2026, 7, 24, 22, 0);
      final nextDayFajr = DateTime(2026, 7, 25, 4, 58);
      final result = service.determineNextPrayer(
        prayerTimes,
        now: now,
        nextDayFajr: nextDayFajr,
      );

      expect(result.name, equals('Fajr'));
      expect(result.time, equals(nextDayFajr));
    });
  });

  group('WidgetService - Preference Updates & Payload', () {
    test('updateWidgetData writes payload to SharedPreferences', () async {
      final service = WidgetService(
        prefs: prefs,
        isAndroid: false,
      );

      final nextPrayerTime = DateTime(2026, 7, 24, 18, 45);
      await service.updateWidgetData(
        nextPrayerName: 'Maghrib',
        nextPrayerTime: nextPrayerTime,
        city: 'Cairo',
      );

      expect(prefs.getString(WidgetService.keyNextPrayerName), equals('Maghrib'));
      expect(prefs.getString(WidgetService.keyNextPrayerTime), equals('06:45 PM'));
      expect(prefs.getString(WidgetService.keyCity), equals('Cairo'));
    });

    test('updateFromPrayerTimes calculates and updates preferences end-to-end', () async {
      final service = WidgetService(
        prefs: prefs,
        isAndroid: false,
      );

      final prayerTimes = <String, DateTime>{
        'Fajr': DateTime(2026, 7, 24, 5, 0),
        'Dhuhr': DateTime(2026, 7, 24, 12, 30),
        'Maghrib': DateTime(2026, 7, 24, 18, 45),
      };

      final now = DateTime(2026, 7, 24, 15, 0);

      await service.updateFromPrayerTimes(
        prayerTimes: prayerTimes,
        now: now,
        city: 'Alexandria',
      );

      expect(prefs.getString(WidgetService.keyNextPrayerName), equals('Maghrib'));
      expect(prefs.getString(WidgetService.keyNextPrayerTime), equals('06:45 PM'));
      expect(prefs.getString(WidgetService.keyCity), equals('Alexandria'));
    });

    test('notifyNativeWidget invokes method channel safely when configured', () async {
      bool channelCalled = false;

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('com.salahcompanion/widget'),
        (MethodCall methodCall) async {
          if (methodCall.method == 'updateWidget') {
            channelCalled = true;
            return true;
          }
          return null;
        },
      );

      final service = WidgetService(
        prefs: prefs,
        isAndroid: true,
      );

      await service.updateWidgetData(
        nextPrayerName: 'Fajr',
        nextPrayerTime: DateTime(2026, 7, 25, 5, 0),
        city: 'Mecca',
      );

      expect(channelCalled, isTrue);

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('com.salahcompanion/widget'),
        null,
      );
    });
  });
}
