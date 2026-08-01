import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/services/location_service.dart';
import 'package:salah_companion/core/utils/location_formatter.dart';

void main() {
  group('LocationFormatter Utility Tests', () {
    test('formats mixed Arabic city and English country code cleanly in English', () {
      const loc = LocationData(
        latitude: 26.4207,
        longitude: 50.0888,
        city: 'الدمام',
        countryCode: 'SA',
        countryName: 'Saudi Arabia',
      );

      final formatted = LocationFormatter.format(loc, languageCode: 'en');
      expect(formatted, equals('Dammam, Saudi Arabia'));
    });

    test('formats Riyadh, Makkah, and Cairo transliterations in English', () {
      const locRiyadh = LocationData(
        latitude: 24.7136,
        longitude: 46.6753,
        city: 'الرياض',
        countryCode: 'SA',
        countryName: 'Saudi Arabia',
      );
      expect(LocationFormatter.format(locRiyadh, languageCode: 'en'), equals('Riyadh, Saudi Arabia'));

      const locCairo = LocationData(
        latitude: 30.0444,
        longitude: 31.2357,
        city: 'القاهرة',
        countryCode: 'EG',
        countryName: 'Egypt',
      );
      expect(LocationFormatter.format(locCairo, languageCode: 'en'), equals('Cairo, Egypt'));
    });

    test('formats location in Arabic when target language is Arabic', () {
      const loc = LocationData(
        latitude: 26.4207,
        longitude: 50.0888,
        city: 'الدمام',
        countryCode: 'SA',
        countryName: 'Saudi Arabia',
      );

      final formatted = LocationFormatter.format(loc, languageCode: 'ar');
      expect(formatted, equals('الدمام، المملكة العربية السعودية'));
    });

    test('returns pure city when country is missing', () {
      const loc = LocationData(
        latitude: 26.4207,
        longitude: 50.0888,
        city: 'Dammam',
      );

      expect(LocationFormatter.format(loc), equals('Dammam'));
    });

    test('returns Location Set fallback when location data is empty', () {
      const loc = LocationData(
        latitude: 0,
        longitude: 0,
      );

      expect(LocationFormatter.format(loc), equals('Location Set'));
    });
  });
}
