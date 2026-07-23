import 'package:flutter_test/flutter_test.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:drift/drift.dart' hide isNotNull;

void main() {
  test('Smoke test for adhan_dart', () {
    final coordinates = Coordinates(21.4225, 39.8262); // Makkah
    final date = DateTime(2026, 7, 24);
    final params = CalculationMethodParameters.muslimWorldLeague();
    final prayerTimes = PrayerTimes(
      date: date,
      coordinates: coordinates,
      calculationParameters: params,
    );

    expect(prayerTimes.fajr, isNotNull);
    expect(prayerTimes.dhuhr, isNotNull);
    expect(prayerTimes.asr, isNotNull);
    expect(prayerTimes.maghrib, isNotNull);
    expect(prayerTimes.isha, isNotNull);
  });

  test('Smoke test for hijri_calendar', () {
    final hijri = HijriCalendarConfig.now();
    expect(hijri.hYear, greaterThan(1400));
    expect(hijri.hMonth, greaterThanOrEqualTo(1));
    expect(hijri.hDay, greaterThanOrEqualTo(1));
  });

  test('Smoke test for geolocator', () async {
    const locationAccuracy = LocationAccuracy.high;
    expect(locationAccuracy, equals(LocationAccuracy.high));
  });

  test('Smoke test for drift', () {
    const value = Value('test');
    expect(value.present, isTrue);
    expect(value.value, equals('test'));
  });
}
