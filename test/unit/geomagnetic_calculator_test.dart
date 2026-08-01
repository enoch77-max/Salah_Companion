import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/utils/geomagnetic_calculator.dart';

void main() {
  group('GeomagneticCalculator WMM2025 Tests', () {
    test('computes positive East declination for London (~ +2.8°)', () {
      final declination = GeomagneticCalculator.calculateDeclination(
        latitude: 51.5074,
        longitude: -0.1278,
        date: DateTime(2025, 6, 1),
      );
      expect(declination, greaterThan(1.5));
      expect(declination, lessThan(4.0));
    });

    test('computes negative West declination for New York (~ -12.1°)', () {
      final declination = GeomagneticCalculator.calculateDeclination(
        latitude: 40.7128,
        longitude: -74.0060,
        date: DateTime(2025, 6, 1),
      );
      expect(declination, lessThan(-10.0));
      expect(declination, greaterThan(-15.0));
    });

    test('computes positive East declination for Riyadh (~ +3.6°)', () {
      final declination = GeomagneticCalculator.calculateDeclination(
        latitude: 24.7136,
        longitude: 46.6753,
        date: DateTime(2025, 6, 1),
      );
      expect(declination, greaterThan(2.0));
      expect(declination, lessThan(5.0));
    });

    test('computes negative West declination for Tokyo (~ -4.6°)', () {
      final declination = GeomagneticCalculator.calculateDeclination(
        latitude: 35.6762,
        longitude: 139.6503,
        date: DateTime(2025, 6, 1),
      );
      expect(declination, lessThan(-3.0));
      expect(declination, greaterThan(-7.0));
    });

    test('computes negative West declination for Johannesburg (~ -18.5°)', () {
      final declination = GeomagneticCalculator.calculateDeclination(
        latitude: -26.2041,
        longitude: 28.0473,
        date: DateTime(2025, 6, 1),
      );
      expect(declination, lessThan(-15.0));
      expect(declination, greaterThan(-22.0));
    });
  });
}
