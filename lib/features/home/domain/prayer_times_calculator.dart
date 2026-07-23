import 'package:adhan_dart/adhan_dart.dart';

/// Calculation engine for daily prayer times and Qibla bearing.
class PrayerTimesCalculator {
  const PrayerTimesCalculator();

  /// Calculates prayer times (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha)
  /// for given coordinates, date, calculation parameters, and optional madhab.
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
    return PrayerTimes(
      date: date,
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
}
