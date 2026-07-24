import 'dart:convert';
import 'dart:io';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:workmanager/workmanager.dart';

import '../database/app_database.dart';
import '../utils/calculation_method_mapper.dart';
import '../../features/home/domain/prayer_times_calculator.dart';
import '../../features/reflection/data/repositories/daily_content_repository.dart';
import '../../features/reflection/domain/models/daily_content.dart';
import 'location_service.dart';
import 'notification_service.dart';

/// Top-level callback dispatcher required by [Workmanager].
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == BackgroundService.midnightTaskName) {
      final handler = MidnightRefreshHandler();
      return await handler.execute();
    }
    return Future.value(true);
  });
}

/// Handler responsible for executing midnight prayer time recalculation,
/// daily reflection content resolution, and notification rescheduling.
class MidnightRefreshHandler {
  final AppDatabase? db;
  final NotificationService? notificationService;
  final LocationService? locationService;
  final DailyContentRepository? dailyContentRepository;
  final SharedPreferences? prefs;
  final HttpClient? httpClient;

  MidnightRefreshHandler({
    this.db,
    this.notificationService,
    this.locationService,
    this.dailyContentRepository,
    this.prefs,
    this.httpClient,
  });

  Future<bool> execute({
    String? featuredOverrideUrl,
    DateTime? tomorrowOverride,
    String? installationSeedOverride,
  }) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      tz.initializeTimeZones();

      final effectivePrefs = prefs ?? await SharedPreferences.getInstance();
      final effectiveDb = db ?? AppDatabase(NativeDatabase.memory());
      final effectiveNotif =
          notificationService ?? NotificationService();
      final effectiveLocation =
          locationService ?? LocationService(effectivePrefs);
      final effectiveRepo =
          dailyContentRepository ?? DailyContentRepository(effectiveDb);

      // 1. Recalculate prayer times for tomorrow's date
      final now = DateTime.now();
      final tomorrow = tomorrowOverride ??
          DateTime(now.year, now.month, now.day + 1, 0, 0, 0);

      LocationData? location = await effectiveLocation.getCachedLocation();
      // Default to Mecca coordinates if no cached location is available
      location ??= const LocationData(latitude: 21.4225, longitude: 39.8262);

      const calculator = PrayerTimesCalculator();
      final coordinates = Coordinates(location.latitude, location.longitude);
      final params =
          CalculationMethodMapper.getMethodForCountry(location.countryCode);

      final prayerTimes = calculator.calculatePrayerTimes(
        coordinates: coordinates,
        date: tomorrow,
        calculationParameters: params,
      );

      final prayerMap = <String, DateTime>{
        'Fajr': prayerTimes.fajr,
        'Sunrise': prayerTimes.sunrise,
        'Dhuhr': prayerTimes.dhuhr,
        'Asr': prayerTimes.asr,
        'Maghrib': prayerTimes.maghrib,
        'Isha': prayerTimes.isha,
      };

      // Enabled prayers settings from SharedPreferences
      final enabledPrayers = <String, bool>{
        'Fajr': effectivePrefs.getBool('notif_enabled_fajr') ?? true,
        'Sunrise': effectivePrefs.getBool('notif_enabled_sunrise') ?? true,
        'Dhuhr': effectivePrefs.getBool('notif_enabled_dhuhr') ?? true,
        'Asr': effectivePrefs.getBool('notif_enabled_asr') ?? true,
        'Maghrib': effectivePrefs.getBool('notif_enabled_maghrib') ?? true,
        'Isha': effectivePrefs.getBool('notif_enabled_isha') ?? true,
      };

      // 2. Check optional featured content override (Remote Config / static JSON URL).
      // Falls back silently to DailyContentRepository.resolveTodayContent if offline or timeout.
      final overrideUrl = featuredOverrideUrl ??
          effectivePrefs.getString('featured_content_override_url');

      DailyContentItem? resolvedPick;

      if (overrideUrl != null && overrideUrl.isNotEmpty) {
        resolvedPick = await _fetchFeaturedOverride(overrideUrl);
      }

      final seed = installationSeedOverride ??
          effectivePrefs.getString('installation_seed') ??
          'salah_companion_default_seed';

      if (resolvedPick != null) {
        final dateStr = _formatDate(tomorrow);
        await effectiveDb
            .into(effectiveDb.dailyContentCacheTable)
            .insertOnConflictUpdate(
              DailyContentCacheTableCompanion.insert(
                date: dateStr,
                contentId: resolvedPick.id,
                resolvedAt: DateTime.now(),
              ),
            );
        await effectiveDb
            .into(effectiveDb.dailyContentShownLogTable)
            .insert(
              DailyContentShownLogTableCompanion.insert(
                contentId: resolvedPick.id,
                shownDate: dateStr,
              ),
            );
      } else {
        resolvedPick = await effectiveRepo.resolveTodayContent(
          installationSeed: seed,
          today: tomorrow,
        );
      }

      // 3. Reschedule prayer and daily reflection notifications
      await effectiveNotif.schedulePrayerNotifications(
        prayerTimes: prayerMap,
        enabledPrayers: enabledPrayers,
      );

      // Default reflection notification is scheduled 30 min post-Fajr
      final reflectionTime = prayerTimes.fajr.add(const Duration(minutes: 30));
      await effectiveNotif.scheduleDailyReflectionNotification(
        content: resolvedPick,
        scheduledTime: reflectionTime,
      );

      return true;
    } catch (_) {
      // Background task failures should return false cleanly
      return false;
    }
  }

  Future<DailyContentItem?> _fetchFeaturedOverride(String url) async {
    try {
      final client = httpClient ?? HttpClient();
      client.connectionTimeout = const Duration(seconds: 5);
      final request = await client.getUrl(Uri.parse(url)).timeout(
            const Duration(seconds: 5),
          );
      final response = await request.close().timeout(
            const Duration(seconds: 5),
          );

      if (response.statusCode == 200) {
        final responseBody =
            await response.transform(utf8.decoder).join().timeout(
                  const Duration(seconds: 5),
                );
        final jsonMap = jsonDecode(responseBody) as Map<String, dynamic>;
        return DailyContentItem.fromJson(jsonMap);
      }
    } catch (_) {
      // Offline, timeout, or invalid format — fall back silently
    }
    return null;
  }

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}

/// Service configuring and managing Workmanager background tasks.
class BackgroundService {
  static const String midnightTaskName = 'midnight_prayer_refresh';
  static const String midnightTaskTag = 'salah_companion_midnight_refresh';

  final Workmanager _workmanager;

  BackgroundService([Workmanager? workmanager])
      : _workmanager = workmanager ?? Workmanager();

  /// Initializes [Workmanager] with [callbackDispatcher].
  Future<void> initialize() async {
    await _workmanager.initialize(
      callbackDispatcher,
    );
  }

  /// Configures the midnight periodic refresh job.
  Future<void> registerMidnightRefreshJob() async {
    await _workmanager.registerPeriodicTask(
      midnightTaskName,
      midnightTaskName,
      tag: midnightTaskTag,
      frequency: const Duration(hours: 24),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.notRequired,
      ),
    );
  }
}
