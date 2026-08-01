import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salah_companion/core/services/widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WidgetService Unit Tests', () {
    late WidgetService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('determines next prayer chronologically', () {
      service = WidgetService(isAndroid: false);

      final now = DateTime(2026, 7, 30, 10, 0); // 10:00 AM
      final prayerTimes = {
        'Fajr': DateTime(2026, 7, 30, 4, 30),
        'Dhuhr': DateTime(2026, 7, 30, 12, 15),
        'Asr': DateTime(2026, 7, 30, 15, 45),
        'Maghrib': DateTime(2026, 7, 30, 18, 45),
        'Isha': DateTime(2026, 7, 30, 20, 15),
      };

      final nextPrayer = service.determineNextPrayer(prayerTimes, now: now);
      expect(nextPrayer.name, equals('Dhuhr'));
      expect(nextPrayer.time, equals(DateTime(2026, 7, 30, 12, 15)));
    });

    test('rolls over to next day Fajr when all current day prayers have passed', () {
      service = WidgetService(isAndroid: false);

      final now = DateTime(2026, 7, 30, 22, 0); // 10:00 PM (after Isha)
      final prayerTimes = {
        'Fajr': DateTime(2026, 7, 30, 4, 30),
        'Dhuhr': DateTime(2026, 7, 30, 12, 15),
        'Asr': DateTime(2026, 7, 30, 15, 45),
        'Maghrib': DateTime(2026, 7, 30, 18, 45),
        'Isha': DateTime(2026, 7, 30, 20, 15),
      };
      final nextDayFajr = DateTime(2026, 7, 31, 4, 31);

      final nextPrayer = service.determineNextPrayer(prayerTimes, now: now, nextDayFajr: nextDayFajr);
      expect(nextPrayer.name, equals('Fajr'));
      expect(nextPrayer.time, equals(nextDayFajr));
    });

    test('formats prayer times correctly for 12-hour display', () {
      service = WidgetService(isAndroid: false);

      final morningTime = DateTime(2026, 7, 30, 4, 15);
      final noonTime = DateTime(2026, 7, 30, 12, 5);
      final eveningTime = DateTime(2026, 7, 30, 20, 45);

      expect(service.formatPrayerTime(morningTime), equals('04:15 AM'));
      expect(service.formatPrayerTime(noonTime), equals('12:05 PM'));
      expect(service.formatPrayerTime(eveningTime), equals('08:45 PM'));

      expect(service.formatShortPrayerTime(morningTime), equals('04:15'));
      expect(service.formatShortPrayerTime(noonTime), equals('12:05'));
    });

    test('persists full widget payload into SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      service = WidgetService(prefs: prefs, isAndroid: false);

      final prayerTimes = {
        'Fajr': DateTime(2026, 7, 30, 4, 30),
        'Dhuhr': DateTime(2026, 7, 30, 12, 15),
        'Asr': DateTime(2026, 7, 30, 15, 45),
        'Maghrib': DateTime(2026, 7, 30, 18, 45),
        'Isha': DateTime(2026, 7, 30, 20, 15),
      };

      await service.updateWidgetData(
        nextPrayerName: 'Dhuhr',
        nextPrayerTime: DateTime(2026, 7, 30, 12, 15),
        city: 'Riyadh',
        hijriDate: '16 Safar 1448 AH',
        allPrayerTimes: prayerTimes,
        duaTitle: 'DAILY REMEMBRANCE',
        duaArabic: 'سُبْحَانَ اللَّهِ',
        duaTranslation: 'Glory be to Allah',
      );

      expect(prefs.getString(WidgetService.keyNextPrayerName), equals('Dhuhr'));
      expect(prefs.getString(WidgetService.keyNextPrayerTime), equals('12:15 PM'));
      expect(prefs.getString(WidgetService.keyCity), equals('Riyadh'));
      expect(prefs.getString(WidgetService.keyHijriDate), equals('16 Safar 1448 AH'));
      expect(prefs.getString(WidgetService.keyFajrTime), equals('04:30'));
      expect(prefs.getString(WidgetService.keyDhuhrTime), equals('12:15'));
      expect(prefs.getString(WidgetService.keyDuaTitle), equals('DAILY REMEMBRANCE'));
      expect(prefs.getString(WidgetService.keyDuaArabic), equals('سُبْحَانَ اللَّهِ'));
    });

    test('tracks widget pinned state per widget type', () async {
      SharedPreferences.setMockInitialValues({'widget_pinned_small_salah': true});
      final prefs = await SharedPreferences.getInstance();
      service = WidgetService(prefs: prefs, isAndroid: false);

      expect(await service.isWidgetPinned('small_salah'), isTrue);
      expect(await service.isWidgetPinned('full_schedule'), isFalse);
    });
  });
}
