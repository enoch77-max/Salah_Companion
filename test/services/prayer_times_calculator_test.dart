import 'package:flutter_test/flutter_test.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salah_companion/core/utils/calculation_method_mapper.dart';
import 'package:salah_companion/core/services/location_service.dart';
import 'package:salah_companion/core/services/timezone_service.dart';
import 'package:salah_companion/features/home/domain/prayer_times_calculator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Step 1: Country Auto-Detection Mapping Tests', () {
    test('Maps EG to Egyptian method', () {
      final params = CalculationMethodMapper.getMethodForCountry('EG');
      expect(params.method, equals(CalculationMethod.egyptian));
    });

    test('Maps SA to UmmAlQura method', () {
      final params = CalculationMethodMapper.getMethodForCountry('SA');
      expect(params.method, equals(CalculationMethod.ummAlQura));
    });

    test('Maps US and CA to NorthAmerica method', () {
      final paramsUS = CalculationMethodMapper.getMethodForCountry('US');
      expect(paramsUS.method, equals(CalculationMethod.northAmerica));

      final paramsCA = CalculationMethodMapper.getMethodForCountry('CA');
      expect(paramsCA.method, equals(CalculationMethod.northAmerica));
    });

    test('Maps PK, IN, BD to Karachi method', () {
      final paramsPK = CalculationMethodMapper.getMethodForCountry('PK');
      expect(paramsPK.method, equals(CalculationMethod.karachi));

      final paramsIN = CalculationMethodMapper.getMethodForCountry('IN');
      expect(paramsIN.method, equals(CalculationMethod.karachi));

      final paramsBD = CalculationMethodMapper.getMethodForCountry('BD');
      expect(paramsBD.method, equals(CalculationMethod.karachi));
    });

    test('Maps AE to Dubai method', () {
      final params = CalculationMethodMapper.getMethodForCountry('AE');
      expect(params.method, equals(CalculationMethod.dubai));
    });

    test('Maps TR to Turkiye method', () {
      final params = CalculationMethodMapper.getMethodForCountry('TR');
      expect(params.method, equals(CalculationMethod.turkiye));
    });

    test('Maps QA to Qatar method', () {
      final params = CalculationMethodMapper.getMethodForCountry('QA');
      expect(params.method, equals(CalculationMethod.qatar));
    });

    test('Maps KW to Kuwait method', () {
      final params = CalculationMethodMapper.getMethodForCountry('KW');
      expect(params.method, equals(CalculationMethod.kuwait));
    });

    test('Maps SG to Singapore method', () {
      final params = CalculationMethodMapper.getMethodForCountry('SG');
      expect(params.method, equals(CalculationMethod.singapore));
    });

    test('Maps FR to France method', () {
      final params = CalculationMethodMapper.getMethodForCountry('FR');
      expect(params.method, equals(CalculationMethod.france));
    });

    test('Handles lowercase inputs correctly', () {
      final params = CalculationMethodMapper.getMethodForCountry('eg');
      expect(params.method, equals(CalculationMethod.egyptian));
    });

    test('Falls back to MuslimWorldLeague for unknown/null country code', () {
      final paramsNull = CalculationMethodMapper.getMethodForCountry(null);
      expect(paramsNull.method, equals(CalculationMethod.muslimWorldLeague));

      final paramsEmpty = CalculationMethodMapper.getMethodForCountry('');
      expect(paramsEmpty.method, equals(CalculationMethod.muslimWorldLeague));

      final paramsUnknown = CalculationMethodMapper.getMethodForCountry('XX');
      expect(paramsUnknown.method, equals(CalculationMethod.muslimWorldLeague));
    });
  });

  group('Step 2: LocationService & Caching Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Caches and retrieves location data accurately', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = LocationService(prefs);

      const location = LocationData(
        latitude: 21.4225,
        longitude: 39.8262,
        city: 'Makkah',
        countryCode: 'SA',
        countryName: 'Saudi Arabia',
      );

      await service.cacheLocation(location);

      final cached = await service.getCachedLocation();
      expect(cached, isNotNull);
      expect(cached!.latitude, equals(21.4225));
      expect(cached.longitude, equals(39.8262));
      expect(cached.city, equals('Makkah'));
      expect(cached.countryCode, equals('SA'));
      expect(cached.countryName, equals('Saudi Arabia'));
    });

    test('Returns null when no location is cached', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = LocationService(prefs);

      final cached = await service.getCachedLocation();
      expect(cached, isNull);
    });

    test('getCurrentLocation fallback to cached when geocoding fails or offline', () async {
      final prefs = await SharedPreferences.getInstance();
      final service = LocationService(prefs);

      const initialCache = LocationData(
        latitude: 30.0444,
        longitude: 31.2357,
        city: 'Cairo',
        countryCode: 'EG',
        countryName: 'Egypt',
      );
      await service.cacheLocation(initialCache);

      // Using mock fetcher to simulate position acquisition with failing geocoding
      final result = await service.getCurrentLocation(
        positionFetcher: () async => Position(
          longitude: 31.2357,
          latitude: 30.0444,
          timestamp: DateTime.now(),
          accuracy: 5.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        ),
        placemarkFetcher: (lat, lng) async => throw Exception('Network offline'),
      );

      expect(result.latitude, equals(30.0444));
      expect(result.longitude, equals(31.2357));
      expect(result.city, equals('Cairo'));
      expect(result.countryCode, equals('EG'));
    });
  });

  group('Step 3: Timezone Mismatch Detection Tests', () {
    test('Returns null when device timezone matches location timezone', () {
      final now = DateTime.now();
      // Device timezone offset matched with location offset
      final warning = TimezoneService.getMismatchWarning(
        deviceTime: now,
        locationOffset: now.timeZoneOffset,
      );

      expect(warning, isNull);
      expect(
        TimezoneService.isMismatched(
          deviceTime: now,
          locationOffset: now.timeZoneOffset,
        ),
        isFalse,
      );
    });

    test('Detects mismatch when device timezone differs significantly from location', () {
      // Device time fixed to UTC-5 (New York offset)
      final deviceTimeNY = DateTime.utc(2026, 7, 24, 12, 0).toLocal();
      
      // Target location offset is UTC+3 (Makkah)
      const makkahOffset = Duration(hours: 3);

      final warning = TimezoneService.getMismatchWarning(
        deviceTime: deviceTimeNY,
        locationOffset: makkahOffset,
      );

      // Unless running on a machine already set to UTC+3, warning triggers when diff > 1h
      if ((deviceTimeNY.timeZoneOffset.inMinutes - makkahOffset.inMinutes).abs() > 60) {
        expect(warning, equals("Using GPS location — device timezone differs"));
        expect(
          TimezoneService.isMismatched(
            deviceTime: deviceTimeNY,
            locationOffset: makkahOffset,
          ),
          isTrue,
        );
      }
    });

    test('Estimates timezone from longitude when explicit locationOffset is omitted', () {
      final deviceTime = DateTime.utc(2026, 7, 24, 12, 0); // UTC
      
      // Makkah longitude ~39.82 -> estimated UTC+3
      final warning = TimezoneService.getMismatchWarning(
        deviceTime: deviceTime,
        longitude: 39.8262,
      );

      // UTC (offset 0) vs Makkah (estimated +3h = 180 mins diff) -> Mismatch > 60 mins
      expect(warning, equals("Using GPS location — device timezone differs"));
    });
  });

  group('Step 4 & 5: Prayer Times & Qibla Calculation Tests', () {
    const calculator = PrayerTimesCalculator();

    test('Calculates accurate prayer times for Makkah (Umm Al-Qura)', () {
      final coordinates = Coordinates(21.4225, 39.8262); // Makkah
      final date = DateTime(2026, 7, 24);
      final params = CalculationMethodMapper.getMethodForCountry('SA');

      final prayerTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      expect(prayerTimes.fajr, isNotNull);
      expect(prayerTimes.sunrise, isNotNull);
      expect(prayerTimes.dhuhr, isNotNull);
      expect(prayerTimes.asr, isNotNull);
      expect(prayerTimes.maghrib, isNotNull);
      expect(prayerTimes.isha, isNotNull);

      // Verify strict chronological sequence
      expect(prayerTimes.fajr.isBefore(prayerTimes.sunrise), isTrue);
      expect(prayerTimes.sunrise.isBefore(prayerTimes.dhuhr), isTrue);
      expect(prayerTimes.dhuhr.isBefore(prayerTimes.asr), isTrue);
      expect(prayerTimes.asr.isBefore(prayerTimes.maghrib), isTrue);
      expect(prayerTimes.maghrib.isBefore(prayerTimes.isha), isTrue);
    });

    test('Calculates accurate prayer times for Cairo (Egyptian)', () {
      final coordinates = Coordinates(30.0444, 31.2357); // Cairo
      final date = DateTime(2026, 7, 24);
      final params = CalculationMethodMapper.getMethodForCountry('EG');

      final prayerTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      expect(prayerTimes.fajr.isBefore(prayerTimes.sunrise), isTrue);
      expect(prayerTimes.sunrise.isBefore(prayerTimes.dhuhr), isTrue);
      expect(prayerTimes.dhuhr.isBefore(prayerTimes.asr), isTrue);
      expect(prayerTimes.asr.isBefore(prayerTimes.maghrib), isTrue);
      expect(prayerTimes.maghrib.isBefore(prayerTimes.isha), isTrue);
    });

    test('Calculates accurate prayer times for London (MWL)', () {
      final coordinates = Coordinates(51.5074, -0.1278); // London
      final date = DateTime(2026, 7, 24);
      final params = CalculationMethodMapper.getMethodForCountry('GB');

      final prayerTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      expect(prayerTimes.fajr.isBefore(prayerTimes.sunrise), isTrue);
      expect(prayerTimes.sunrise.isBefore(prayerTimes.dhuhr), isTrue);
      expect(prayerTimes.dhuhr.isBefore(prayerTimes.asr), isTrue);
      expect(prayerTimes.asr.isBefore(prayerTimes.maghrib), isTrue);
      expect(prayerTimes.maghrib.isBefore(prayerTimes.isha), isTrue);
    });

    test('Calculates accurate prayer times for New York (ISNA)', () {
      final coordinates = Coordinates(40.7128, -74.0060); // New York
      final date = DateTime(2026, 7, 24);
      final params = CalculationMethodMapper.getMethodForCountry('US');

      final prayerTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
      );

      expect(prayerTimes.fajr.isBefore(prayerTimes.sunrise), isTrue);
      expect(prayerTimes.sunrise.isBefore(prayerTimes.dhuhr), isTrue);
      expect(prayerTimes.dhuhr.isBefore(prayerTimes.asr), isTrue);
      expect(prayerTimes.asr.isBefore(prayerTimes.maghrib), isTrue);
      expect(prayerTimes.maghrib.isBefore(prayerTimes.isha), isTrue);
    });

    test('Applies custom Madhab parameter (Hanafi vs Shafi)', () {
      final coordinates = Coordinates(31.5204, 74.3587); // Lahore, Pakistan
      final date = DateTime(2026, 7, 24);

      final shafiTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: CalculationMethodMapper.getMethodForCountry('PK'),
        madhab: Madhab.shafi,
      );

      final hanafiTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: CalculationMethodMapper.getMethodForCountry('PK'),
        madhab: Madhab.hanafi,
      );

      // Hanafi Asr time is later than Shafi Asr time
      expect(hanafiTimes.asr.isAfter(shafiTimes.asr), isTrue);
    });

    test('Calculates accurate Qibla bearings', () {
      // Cairo (~136 degrees SE)
      final cairoQibla = calculator.calculateQiblaBearing(Coordinates(30.0444, 31.2357));
      expect(cairoQibla, closeTo(136.0, 3.0));

      // London (~118 degrees SE)
      final londonQibla = calculator.calculateQiblaBearing(Coordinates(51.5074, -0.1278));
      expect(londonQibla, closeTo(118.0, 3.0));

      // New York (~58 degrees NE)
      final nyQibla = calculator.calculateQiblaBearing(Coordinates(40.7128, -74.0060));
      expect(nyQibla, closeTo(58.0, 3.0));
    });
  });
}
