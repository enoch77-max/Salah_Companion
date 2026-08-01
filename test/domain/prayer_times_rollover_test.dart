import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/features/home/domain/prayer_times_calculator.dart';

void main() {
  group('PrayerTimesCalculator Rollover & Active Day Tests', () {
    const calc = PrayerTimesCalculator();
    // Mecca coordinates
    final coords = Coordinates(21.4225, 39.8262);
    final params = CalculationMethodParameters.muslimWorldLeague();

    test('getIslamicCalculationDate at 02:00 AM returns previous calendar date', () {
      // 02:00 AM on July 30, 2026 is before Fajr (~04:15 AM in Mecca)
      final now = DateTime(2026, 7, 30, 2, 0);
      final calcDate = calc.getIslamicCalculationDate(
        now: now,
        coordinates: coords,
        calculationParameters: params,
      );

      expect(calcDate.year, equals(2026));
      expect(calcDate.month, equals(7));
      expect(calcDate.day, equals(29));
    });

    test('getIslamicCalculationDate at 04:56 AM returns current calendar date', () {
      // 04:56 AM on July 30, 2026 is after Fajr (~04:15 AM) and before Sunrise (~05:38 AM)
      final now = DateTime(2026, 7, 30, 4, 56);
      final calcDate = calc.getIslamicCalculationDate(
        now: now,
        coordinates: coords,
        calculationParameters: params,
      );

      expect(calcDate.year, equals(2026));
      expect(calcDate.month, equals(7));
      expect(calcDate.day, equals(30));
    });

    test('04:56 AM prayer status evaluation correctly identifies Fajr active and Dhuhr/Asr/Maghrib/Isha future pending', () {
      final now = DateTime(2026, 7, 30, 4, 56);
      final calcDate = calc.getIslamicCalculationDate(
        now: now,
        coordinates: coords,
        calculationParameters: params,
      );

      final times = calc.calculatePrayerTimes(
        coordinates: coords,
        date: calcDate,
        calculationParameters: params,
      );

      // Verify calculation times
      expect(now.isAfter(times.fajr), isTrue, reason: '4:56 AM should be after Fajr start time');
      expect(now.isBefore(times.sunrise), isTrue, reason: '4:56 AM should be before Sunrise');
      expect(now.isBefore(times.dhuhr), isTrue, reason: '4:56 AM should be before Dhuhr');
      expect(now.isBefore(times.asr), isTrue, reason: '4:56 AM should be before Asr');
      expect(now.isBefore(times.maghrib), isTrue, reason: '4:56 AM should be before Maghrib');
      expect(now.isBefore(times.isha), isTrue, reason: '4:56 AM should be before Isha');

      final remainingToSunrise = times.sunrise.difference(now);
      expect(remainingToSunrise.isNegative, isFalse, reason: 'Remaining time to Sunrise must be positive');
      expect(remainingToSunrise.inMinutes, greaterThan(0));
    });

    test('Crossing midnight preserves Isha period until next day Fajr', () {
      // 11:30 PM on July 29
      final nightTime = DateTime(2026, 7, 29, 23, 30);
      final nightCalcDate = calc.getIslamicCalculationDate(
        now: nightTime,
        coordinates: coords,
        calculationParameters: params,
      );
      expect(nightCalcDate.day, equals(29));

      // 01:30 AM on July 30
      final earlyMorningTime = DateTime(2026, 7, 30, 1, 30);
      final earlyCalcDate = calc.getIslamicCalculationDate(
        now: earlyMorningTime,
        coordinates: coords,
        calculationParameters: params,
      );
      expect(earlyCalcDate.day, equals(29), reason: '01:30 AM belongs to July 29 prayer day');

      final times29 = calc.calculatePrayerTimes(
        coordinates: coords,
        date: nightCalcDate,
        calculationParameters: params,
      );

      expect(earlyMorningTime.isAfter(times29.isha), isTrue);
      expect(earlyMorningTime.isBefore(times29.fajr.add(const Duration(days: 1))), isTrue,
          reason: '01:30 AM is before tomorrow Fajr');
    });

    test('Post-midnight Isha status toggle cycle retains active prayer day until Fajr', () {
      final now2AM = DateTime(2026, 7, 30, 2, 0); // 02:00 AM July 30 (before July 30 Fajr)
      final calcDate2AM = calc.getIslamicCalculationDate(
        now: now2AM,
        coordinates: coords,
        calculationParameters: params,
      );

      // Must belong to July 29 prayer day
      expect(calcDate2AM.day, equals(29));

      final timesJuly29 = calc.calculatePrayerTimes(
        coordinates: coords,
        date: calcDate2AM,
        calculationParameters: params,
      );

      final nextFajr = timesJuly29.fajr.add(const Duration(days: 1));

      // At 02:00 AM, now is after Isha start and before next day Fajr
      expect(now2AM.isAfter(timesJuly29.isha), isTrue);
      expect(now2AM.isBefore(nextFajr), isTrue);

      // Calculation date at 03:00 AM (still before nextFajr) remains July 29
      final now3AM = DateTime(2026, 7, 30, 3, 0);
      final calcDate3AM = calc.getIslamicCalculationDate(
        now: now3AM,
        coordinates: coords,
        calculationParameters: params,
      );
      expect(calcDate3AM.day, equals(29));

      // Once time crosses nextFajr (e.g. 05:00 AM), calculation date transitions to July 30
      final now500AM = DateTime(2026, 7, 30, 5, 0);
      final calcDate500AM = calc.getIslamicCalculationDate(
        now: now500AM,
        coordinates: coords,
        calculationParameters: params,
      );
      expect(calcDate500AM.day, equals(30));
    });
  });
}
