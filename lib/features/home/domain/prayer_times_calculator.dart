import 'package:adhan_dart/adhan_dart.dart';

/// Localized subclass of [PrayerTimes] that converts all calculations
/// from UTC to the device's local timezone.
class LocalizedPrayerTimes extends PrayerTimes {
  LocalizedPrayerTimes({
    required super.coordinates,
    required super.date,
    required super.calculationParameters,
  });

  @override
  DateTime get fajr => super.fajr.toLocal();

  @override
  DateTime get sunrise => super.sunrise.toLocal();

  @override
  DateTime get dhuhr => super.dhuhr.toLocal();

  @override
  DateTime get asr => super.asr.toLocal();

  @override
  DateTime get maghrib => super.maghrib.toLocal();

  @override
  DateTime get isha => super.isha.toLocal();

  @override
  DateTime timeForPrayer(Prayer prayer) {
    return super.timeForPrayer(prayer).toLocal();
  }
}

/// Calculation engine for daily prayer times and Qibla bearing.
class PrayerTimesCalculator {
  const PrayerTimesCalculator();

  /// Calculates prayer times (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha)
  /// for given coordinates, date, calculation parameters, and optional madhab.
  /// Converts all returned times to local timezone.
  PrayerTimes calculatePrayerTimes({
    required Coordinates coordinates,
    required DateTime date,
    required CalculationParameters calculationParameters,
    Madhab? madhab,
  }) {
    final params = calculationParameters;
    if (madhab != null) {
      params.madhab = madhab;
    }
    final localDate = DateTime.utc(date.year, date.month, date.day, 12, 0, 0);

    return LocalizedPrayerTimes(
      date: localDate,
      coordinates: coordinates,
      calculationParameters: params,
    );
  }

  /// Convenience alias for [calculatePrayerTimes].
  PrayerTimes calculate({
    required Coordinates coordinates,
    required DateTime date,
    required CalculationParameters calculationParameters,
    Madhab? madhab,
  }) {
    return calculatePrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: calculationParameters,
      madhab: madhab,
    );
  }

  /// Calculates the Qibla bearing angle in degrees from North (clockwise)
  /// for the given coordinates using `adhan_dart.Qibla.qibla(coordinates)`.
  double calculateQiblaBearing(Coordinates coordinates) {
    return Qibla.qibla(coordinates);
  }

  /// Convenience alias for [calculateQiblaBearing].
  double calculateQibla(Coordinates coordinates) {
    return calculateQiblaBearing(coordinates);
  }

  /// Determines the active Islamic calculation date for a given timestamp [now].
  ///
  /// If [now] occurs before today's Fajr (e.g. between 12:00 AM midnight and Fajr),
  /// the active prayer day belongs to yesterday (where Isha is active until today's Fajr).
  /// Otherwise, the active prayer day belongs to today.
  DateTime getIslamicCalculationDate({
    required DateTime now,
    required Coordinates coordinates,
    required CalculationParameters calculationParameters,
    Madhab? madhab,
  }) {
    final todayTimes = calculatePrayerTimes(
      coordinates: coordinates,
      date: now,
      calculationParameters: calculationParameters,
      madhab: madhab,
    );

    if (now.isBefore(todayTimes.fajr)) {
      return DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    }
    return DateTime(now.year, now.month, now.day);
  }
}

