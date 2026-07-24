import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:salah_companion/core/database/app_database.dart';
import 'package:salah_companion/core/services/background_service.dart';
import 'package:salah_companion/core/services/location_service.dart';
import 'package:salah_companion/core/services/notification_service.dart';
import 'package:salah_companion/features/reflection/data/repositories/daily_content_repository.dart';
import 'package:salah_companion/features/reflection/domain/models/daily_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class MockNotificationService extends Mock implements NotificationService {}

class MockLocationService extends Mock implements LocationService {}

class MockDailyContentRepository extends Mock
    implements DailyContentRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late MockNotificationService mockNotif;
  late MockLocationService mockLocation;
  late MockDailyContentRepository mockRepo;
  late SharedPreferences prefs;

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(const DailyContentItem(
      id: 'test_1',
      type: DailyContentType.hadith,
      reference: 'Ref',
      sourceWeight: 1.0,
      grade: 'Sahih',
      gradedBy: 'GradedBy',
      arabicText: 'Arabic',
      translationText: 'Translation',
      translationSource: 'Source',
    ));
    registerFallbackValue(DateTime.now());
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'notif_enabled_fajr': true,
      'notif_enabled_dhuhr': true,
      'installation_seed': 'test_seed_123',
    });
    prefs = await SharedPreferences.getInstance();
    db = AppDatabase(NativeDatabase.memory());
    mockNotif = MockNotificationService();
    mockLocation = MockLocationService();
    mockRepo = MockDailyContentRepository();
  });

  tearDown(() async {
    await db.close();
  });

  group('MidnightRefreshHandler tests', () {
    test('execute completes successfully and resolves content & schedules notifications',
        () async {
      when(() => mockLocation.getCachedLocation()).thenAnswer(
        (_) async => const LocationData(
          latitude: 21.4225,
          longitude: 39.8262,
          city: 'Mecca',
        ),
      );

      const mockPick = DailyContentItem(
        id: 'hadith_pick_1',
        type: DailyContentType.hadith,
        reference: 'Sahih al-Bukhari 10',
        sourceWeight: 1.0,
        grade: 'Sahih',
        gradedBy: 'Al-Bukhari',
        arabicText: 'أن تعبد الله كأنك تراه',
        translationText:
            'Worship Allah as if you see Him, for if you do not see Him, He sees you.',
        translationSource: 'Sahih al-Bukhari',
      );

      when(() => mockRepo.resolveTodayContent(
            installationSeed: any(named: 'installationSeed'),
            today: any(named: 'today'),
          )).thenAnswer((_) async => mockPick);

      when(() => mockNotif.schedulePrayerNotifications(
            prayerTimes: any(named: 'prayerTimes'),
            enabledPrayers: any(named: 'enabledPrayers'),
          )).thenAnswer((_) async {});

      when(() => mockNotif.scheduleDailyReflectionNotification(
            content: any(named: 'content'),
            scheduledTime: any(named: 'scheduledTime'),
            enabled: any(named: 'enabled'),
          )).thenAnswer((_) async {});

      final handler = MidnightRefreshHandler(
        db: db,
        notificationService: mockNotif,
        locationService: mockLocation,
        dailyContentRepository: mockRepo,
        prefs: prefs,
      );

      final tomorrow = DateTime(2026, 7, 25);
      final result = await handler.execute(
        tomorrowOverride: tomorrow,
        installationSeedOverride: 'seed_123',
      );

      expect(result, isTrue);

      verify(() => mockNotif.schedulePrayerNotifications(
            prayerTimes: any(named: 'prayerTimes'),
            enabledPrayers: any(named: 'enabledPrayers'),
          )).called(1);

      verify(() => mockNotif.scheduleDailyReflectionNotification(
            content: mockPick,
            scheduledTime: any(named: 'scheduledTime'),
            enabled: true,
          )).called(1);
    });

    test('execute falls back silently to resolveTodayContent when override URL fails',
        () async {
      when(() => mockLocation.getCachedLocation()).thenAnswer(
        (_) async => const LocationData(
          latitude: 21.4225,
          longitude: 39.8262,
        ),
      );

      const fallbackPick = DailyContentItem(
        id: 'ayah_pick_1',
        type: DailyContentType.ayah,
        reference: 'Surah Al-Fatiha 1:1',
        sourceWeight: 1.0,
        arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        translationText:
            'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
        translationSource: 'Sahih International',
      );

      when(() => mockRepo.resolveTodayContent(
            installationSeed: any(named: 'installationSeed'),
            today: any(named: 'today'),
          )).thenAnswer((_) async => fallbackPick);

      when(() => mockNotif.schedulePrayerNotifications(
            prayerTimes: any(named: 'prayerTimes'),
            enabledPrayers: any(named: 'enabledPrayers'),
          )).thenAnswer((_) async {});

      when(() => mockNotif.scheduleDailyReflectionNotification(
            content: any(named: 'content'),
            scheduledTime: any(named: 'scheduledTime'),
            enabled: any(named: 'enabled'),
          )).thenAnswer((_) async {});

      final handler = MidnightRefreshHandler(
        db: db,
        notificationService: mockNotif,
        locationService: mockLocation,
        dailyContentRepository: mockRepo,
        prefs: prefs,
      );

      final tomorrow = DateTime(2026, 7, 25);
      final result = await handler.execute(
        featuredOverrideUrl: 'http://invalid-non-existent-url-12345.com/item.json',
        tomorrowOverride: tomorrow,
      );

      expect(result, isTrue);

      verify(() => mockRepo.resolveTodayContent(
            installationSeed: any(named: 'installationSeed'),
            today: tomorrow,
          )).called(1);
    });

    test(
        'execute passes enabled == false when notif_enabled_daily_reflection is false in SharedPreferences',
        () async {
      SharedPreferences.setMockInitialValues({
        'notif_enabled_daily_reflection': false,
        'daily_reflection_time_mins_post_fajr': 45,
      });
      final customPrefs = await SharedPreferences.getInstance();

      when(() => mockLocation.getCachedLocation()).thenAnswer(
        (_) async => const LocationData(
          latitude: 21.4225,
          longitude: 39.8262,
        ),
      );

      const mockPick = DailyContentItem(
        id: 'hadith_pick_disabled',
        type: DailyContentType.hadith,
        reference: 'Sahih al-Bukhari 1',
        sourceWeight: 1.0,
        arabicText: 'أن تعبد الله',
        translationText: 'Worship Allah',
        translationSource: 'Sahih al-Bukhari',
      );

      when(() => mockRepo.resolveTodayContent(
            installationSeed: any(named: 'installationSeed'),
            today: any(named: 'today'),
          )).thenAnswer((_) async => mockPick);

      when(() => mockNotif.schedulePrayerNotifications(
            prayerTimes: any(named: 'prayerTimes'),
            enabledPrayers: any(named: 'enabledPrayers'),
          )).thenAnswer((_) async {});

      when(() => mockNotif.scheduleDailyReflectionNotification(
            content: any(named: 'content'),
            scheduledTime: any(named: 'scheduledTime'),
            enabled: any(named: 'enabled'),
          )).thenAnswer((_) async {});

      final handler = MidnightRefreshHandler(
        db: db,
        notificationService: mockNotif,
        locationService: mockLocation,
        dailyContentRepository: mockRepo,
        prefs: customPrefs,
      );

      final tomorrow = DateTime(2026, 7, 25);
      final result = await handler.execute(
        tomorrowOverride: tomorrow,
      );

      expect(result, isTrue);

      verify(() => mockNotif.scheduleDailyReflectionNotification(
            content: mockPick,
            scheduledTime: any(named: 'scheduledTime'),
            enabled: false,
          )).called(1);
    });
  });
}
