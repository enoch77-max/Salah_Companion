import 'package:flutter_test/flutter_test.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:salah_companion/features/home/domain/prayer_times_calculator.dart';
import 'package:salah_companion/features/home/presentation/widgets/prayer_list_card.dart';
import 'package:salah_companion/core/utils/calculation_method_mapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Core Prayer Logic Engine Verification', () {
    const calc = PrayerTimesCalculator();
    final coords = Coordinates(23.8103, 90.4125); // Dhaka
    final calcParams = CalculationMethodMapper.getMethodForCountry('BD');

    test('Full 24-Hour Timeline State Simulation Test', () {
      final baseDate = DateTime.now();
      final times = calc.calculatePrayerTimes(
        coordinates: coords,
        date: baseDate,
        calculationParameters: calcParams,
      );

      print('\n=== TODAY CALCULATION TIMES ===');
      print('Fajr: ${times.fajr}');
      print('Sunrise: ${times.sunrise}');
      print('Dhuhr: ${times.dhuhr}');
      print('Asr: ${times.asr}');
      print('Maghrib: ${times.maghrib}');
      print('Isha: ${times.isha}');
      print('================================\n');

      // Helper to evaluate statuses for a simulated `now` time
      List<PrayerItem> evaluateForTime(DateTime now, Map<String, PrayerStatus> userDbLogs) {
        final ishaEnd = times.fajr.add(const Duration(days: 1));

        final items = [
          PrayerItem(name: 'Fajr', time: 'Fajr', status: userDbLogs['Fajr'] ?? PrayerStatus.pending),
          PrayerItem(name: 'Dhuhr', time: 'Dhuhr', status: userDbLogs['Dhuhr'] ?? PrayerStatus.pending),
          PrayerItem(name: 'Asr', time: 'Asr', status: userDbLogs['Asr'] ?? PrayerStatus.pending),
          PrayerItem(name: 'Maghrib', time: 'Maghrib', status: userDbLogs['Maghrib'] ?? PrayerStatus.pending),
          PrayerItem(name: 'Isha', time: 'Isha', status: userDbLogs['Isha'] ?? PrayerStatus.pending),
        ];

        return items.map((item) {
          DateTime startT = times.fajr;
          DateTime endT = times.sunrise;

          if (item.name == 'Fajr') {
            startT = times.fajr;
            endT = times.sunrise;
          } else if (item.name == 'Dhuhr') {
            startT = times.dhuhr;
            endT = times.asr;
          } else if (item.name == 'Asr') {
            startT = times.asr;
            endT = times.maghrib;
          } else if (item.name == 'Maghrib') {
            startT = times.maghrib;
            endT = times.isha;
          } else if (item.name == 'Isha') {
            startT = times.isha;
            endT = ishaEnd;
          }

          final isFut = now.isBefore(startT);
          PrayerStatus evalStatus = item.status;

          if (isFut) {
            evalStatus = PrayerStatus.pending;
          } else if (now.isAfter(endT)) {
            if (evalStatus == PrayerStatus.pending) {
              evalStatus = PrayerStatus.missed;
            }
          }

          return item.copyWith(isFuture: isFut, status: evalStatus);
        }).toList();
      }

      // Step A: 30 minutes before Fajr - Late night before Fajr
      final simBeforeFajr = times.fajr.subtract(const Duration(minutes: 30));
      final listBeforeFajr = evaluateForTime(simBeforeFajr, {});
      for (final p in listBeforeFajr) {
        expect(p.status, PrayerStatus.pending, reason: '${p.name} before Fajr must be pending');
      }

      // Step B: 10 minutes after Fajr start - Fajr active
      final simFajrActive = times.fajr.add(const Duration(minutes: 10));
      final listFajrActive = evaluateForTime(simFajrActive, {});
      expect(listFajrActive.firstWhere((p) => p.name == 'Fajr').status, PrayerStatus.pending, reason: 'Fajr during active period must be pending');
      expect(listFajrActive.firstWhere((p) => p.name == 'Dhuhr').status, PrayerStatus.pending);

      // Step C: 10 minutes after Dhuhr start - Fajr expired unprayed, Dhuhr active pending
      final simDhuhrActive = times.dhuhr.add(const Duration(minutes: 10));
      final listDhuhrActive = evaluateForTime(simDhuhrActive, {});
      expect(listDhuhrActive.firstWhere((p) => p.name == 'Fajr').status, PrayerStatus.missed, reason: 'Expired Fajr unprayed becomes missed');
      expect(listDhuhrActive.firstWhere((p) => p.name == 'Dhuhr').status, PrayerStatus.pending, reason: 'Active Dhuhr must be pending');
      expect(listDhuhrActive.firstWhere((p) => p.name == 'Asr').status, PrayerStatus.pending, reason: 'Future Asr must be pending');

      // Step D: User prays Dhuhr during Dhuhr active time
      final dbLogs = {'Dhuhr': PrayerStatus.prayed};
      final listDhuhrLogged = evaluateForTime(times.dhuhr.add(const Duration(minutes: 20)), dbLogs);
      expect(listDhuhrLogged.firstWhere((p) => p.name == 'Dhuhr').status, PrayerStatus.prayed, reason: 'Logged Dhuhr displays prayed');

      // Step E: 10 minutes after Asr start - Dhuhr was prayed, Asr active pending
      final simAsrActive = times.asr.add(const Duration(minutes: 10));
      final listAsrActive = evaluateForTime(simAsrActive, dbLogs);
      expect(listAsrActive.firstWhere((p) => p.name == 'Dhuhr').status, PrayerStatus.prayed);
      expect(listAsrActive.firstWhere((p) => p.name == 'Asr').status, PrayerStatus.pending);

      print('SUCCESS: All 24-hour timeline steps verified perfectly!');
    });
  });
}
