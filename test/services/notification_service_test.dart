import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:salah_companion/core/services/notification_service.dart';
import 'package:salah_companion/features/reflection/domain/models/daily_content.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(tz.TZDateTime.now(tz.local));
    registerFallbackValue(AndroidScheduleMode.exactAllowWhileIdle);
  });

  group('NotificationService - truncateNotificationBody tests', () {
    test('returns original string when text length is <= maxLength (short text)',
        () {
      const text = 'Actions are judged by intentions.';
      final result = NotificationService.truncateNotificationBody(text, 120);

      expect(result, equals(text));
      expect(result.endsWith('…'), isFalse);
      expect(result.length, equals(text.length));
    });

    test(
        'returns original string when text length is exactly maxLength (120 chars)',
        () {
      final text = 'A' * 120;
      final result = NotificationService.truncateNotificationBody(text, 120);

      expect(result, equals(text));
      expect(result.endsWith('…'), isFalse);
      expect(result.length, equals(120));
    });

    test(
        'truncates at word boundary with "…" suffix when text length exceeds 120 chars',
        () {
      const text =
          'Actions are by intentions, and every person will get what they intended. '
          'Whoever migrated for Allah and His Messenger, their migration is for Allah and His Messenger.';
      expect(text.length, greaterThan(120));

      final result = NotificationService.truncateNotificationBody(text, 120);

      expect(result.endsWith('…'), isTrue);
      // Ensure truncated string (excluding '…') does not exceed 120 chars
      final bodyNoEllipsis = result.substring(0, result.length - 1);
      expect(bodyNoEllipsis.length, lessThanOrEqualTo(120));
      // Word boundary check: body should not end with space before '…'
      expect(bodyNoEllipsis, equals(bodyNoEllipsis.trimRight()));
      // Verify clean word cut
      expect(text.startsWith(bodyNoEllipsis), isTrue);
    });

    test(
        'cuts at maxLength with "…" when text has no whitespace before limit',
        () {
      final text = 'B' * 130;
      final result = NotificationService.truncateNotificationBody(text, 120);

      expect(result, equals('${'B' * 120}…'));
      expect(result.length, equals(121));
    });

    test('handles empty text cleanly', () {
      final result = NotificationService.truncateNotificationBody('', 120);
      expect(result, equals(''));
    });
  });

  group('NotificationService - Payload Formatting tests', () {
    test('formats payload correctly for Hadith item', () {
      const hadithItem = DailyContentItem(
        id: 'hadith_bukhari_1',
        type: DailyContentType.hadith,
        reference: 'Sahih al-Bukhari 1',
        sourceWeight: 1.0,
        grade: 'Sahih',
        gradedBy: 'Al-Bukhari',
        arabicText: 'إنما الأعمال بالنيات',
        translationText: 'Actions are judged by intentions.',
        translationSource: 'Sahih al-Bukhari Translation',
      );

      final payload = NotificationService.formatNotificationPayload(hadithItem);
      expect(payload, contains('"id":"hadith_bukhari_1"'));
      expect(payload, contains('"type":"hadith"'));
      expect(payload, contains('"reference":"Sahih al-Bukhari 1"'));

      final parsed = NotificationService.parseNotificationPayload(payload);
      expect(parsed['id'], equals('hadith_bukhari_1'));
      expect(parsed['type'], equals('hadith'));
      expect(parsed['reference'], equals('Sahih al-Bukhari 1'));
    });

    test('formats payload correctly for Ayah item', () {
      const ayahItem = DailyContentItem(
        id: 'ayah_baqarah_255',
        type: DailyContentType.ayah,
        reference: 'Surah Al-Baqarah 2:255',
        sourceWeight: 1.0,
        arabicText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
        translationText:
            'Allah! There is no deity except Him, the Ever-Living, the Sustainer of all existence.',
        translationSource: 'Sahih International',
      );

      final payload = NotificationService.formatNotificationPayload(ayahItem);
      expect(payload, contains('"id":"ayah_baqarah_255"'));
      expect(payload, contains('"type":"ayah"'));
      expect(payload, contains('"reference":"Surah Al-Baqarah 2:255"'));

      final parsed = NotificationService.parseNotificationPayload(payload);
      expect(parsed['id'], equals('ayah_baqarah_255'));
      expect(parsed['type'], equals('ayah'));
      expect(parsed['reference'], equals('Surah Al-Baqarah 2:255'));
    });
  });

  group('NotificationService - Prayer Notification Scheduling Data Modeling tests',
      () {
    test('PrayerNotificationData equality and hashcode', () {
      final now = DateTime(2026, 7, 24, 5, 0);
      final model1 = PrayerNotificationData(
        prayerName: 'Fajr',
        scheduledTime: now,
        isEnabled: true,
        notificationId: 101,
      );
      final model2 = PrayerNotificationData(
        prayerName: 'Fajr',
        scheduledTime: now,
        isEnabled: true,
        notificationId: 101,
      );

      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('buildPrayerNotificationModels creates correct models and default IDs',
        () {
      final now = DateTime(2026, 7, 24, 12, 0);
      final prayerTimes = <String, DateTime>{
        'Fajr': now.add(const Duration(hours: 5)),
        'Sunrise': now.add(const Duration(hours: 6, minutes: 30)),
        'Dhuhr': now.add(const Duration(hours: 12)),
        'Asr': now.add(const Duration(hours: 15, minutes: 30)),
        'Maghrib': now.add(const Duration(hours: 18, minutes: 45)),
        'Isha': now.add(const Duration(hours: 20)),
      };

      final enabledPrayers = <String, bool>{
        'Fajr': true,
        'Sunrise': false,
        'Dhuhr': true,
        'Asr': true,
        'Maghrib': true,
        'Isha': false,
      };

      final models = NotificationService.buildPrayerNotificationModels(
        prayerTimes: prayerTimes,
        enabledPrayers: enabledPrayers,
      );

      expect(models.length, equals(6));

      final fajrModel = models.firstWhere((m) => m.prayerName == 'Fajr');
      expect(fajrModel.isEnabled, isTrue);
      expect(fajrModel.notificationId, equals(101));

      final sunriseModel = models.firstWhere((m) => m.prayerName == 'Sunrise');
      expect(sunriseModel.isEnabled, isFalse);
      expect(sunriseModel.notificationId, equals(102));

      final dhuhrModel = models.firstWhere((m) => m.prayerName == 'Dhuhr');
      expect(dhuhrModel.isEnabled, isTrue);
      expect(dhuhrModel.notificationId, equals(103));

      final ishaModel = models.firstWhere((m) => m.prayerName == 'Isha');
      expect(ishaModel.isEnabled, isFalse);
      expect(ishaModel.notificationId, equals(106));
    });
  });

  group('NotificationService - Scheduling Interactions tests', () {
    late MockFlutterLocalNotificationsPlugin mockPlugin;
    late NotificationService service;

    setUp(() {
      mockPlugin = MockFlutterLocalNotificationsPlugin();
      service = NotificationService(notificationsPlugin: mockPlugin);
    });

    test('schedulePrayerNotifications schedules enabled future prayers',
        () async {
      when(() => mockPlugin.zonedSchedule(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          )).thenAnswer((_) async {});

      final baseTime = DateTime(2026, 7, 24, 10, 0);
      final nowOverride = DateTime(2026, 7, 24, 9, 0); // before baseTime

      final prayerTimes = <String, DateTime>{
        'Fajr': baseTime.subtract(const Duration(hours: 4)), // past
        'Dhuhr': baseTime.add(const Duration(hours: 3)), // future
        'Asr': baseTime.add(const Duration(hours: 6)), // future
      };

      final enabledPrayers = <String, bool>{
        'Fajr': true,
        'Dhuhr': true,
        'Asr': false, // disabled
      };

      await service.schedulePrayerNotifications(
        prayerTimes: prayerTimes,
        enabledPrayers: enabledPrayers,
        nowOverride: nowOverride,
      );

      // Fajr start notification (id: 101) and Dhuhr start notification (id: 103) should be scheduled
      verify(() => mockPlugin.zonedSchedule(
            id: 101,
            title: 'Fajr Prayer',
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          )).called(1);

      verify(() => mockPlugin.zonedSchedule(
            id: 103,
            title: 'Dhuhr Prayer',
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          )).called(1);

      // Asr is disabled (enabled: false), so id 104 should never be scheduled
      verifyNever(() => mockPlugin.zonedSchedule(
            id: 104,
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          ));
    });

    test('cancelPrayerReminders cancels 15m post and 30m urgent reminder IDs', () async {
      when(() => mockPlugin.cancel(id: any(named: 'id'))).thenAnswer((_) async {});

      await service.cancelPrayerReminders('Maghrib');

      verify(() => mockPlugin.cancel(id: 1105)).called(1); // 105 + 1000
      verify(() => mockPlugin.cancel(id: 2105)).called(1); // 105 + 2000
    });

    test('schedulePrayerNotifications cancels and skips reminders for completedPrayers', () async {
      when(() => mockPlugin.zonedSchedule(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          )).thenAnswer((_) async {});
      when(() => mockPlugin.cancel(id: any(named: 'id'))).thenAnswer((_) async {});

      final baseTime = DateTime(2026, 7, 24, 18, 0);
      final nowOverride = DateTime(2026, 7, 24, 17, 0);

      final prayerTimes = <String, DateTime>{
        'Maghrib': baseTime,
      };
      final endTimes = <String, DateTime>{
        'Maghrib': baseTime.add(const Duration(hours: 1, minutes: 30)),
      };

      await service.schedulePrayerNotifications(
        prayerTimes: prayerTimes,
        enabledPrayers: {'Maghrib': true},
        endTimes: endTimes,
        completedPrayers: {'Maghrib'},
        nowOverride: nowOverride,
      );

      // 15m post (1105) and 30m urgent (2105) should be cancelled and not scheduled
      verify(() => mockPlugin.cancel(id: 1105)).called(1);
      verify(() => mockPlugin.cancel(id: 2105)).called(1);
      verifyNever(() => mockPlugin.zonedSchedule(
            id: 1105,
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          ));
      verifyNever(() => mockPlugin.zonedSchedule(
            id: 2105,
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          ));
    });

    test('scheduleDailyReflectionNotification schedules future reflection',
        () async {
      when(() => mockPlugin.zonedSchedule(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            payload: any(named: 'payload'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          )).thenAnswer((_) async {});

      const item = DailyContentItem(
        id: 'hadith_001',
        type: DailyContentType.hadith,
        reference: 'Sahih al-Bukhari 5',
        sourceWeight: 1.0,
        grade: 'Sahih',
        gradedBy: 'Al-Bukhari',
        arabicText: 'إنما الأعمال بالنيات',
        translationText: 'Actions are judged by intentions.',
        translationSource: 'Bukhari',
      );

      final now = DateTime(2026, 7, 24, 8, 0);
      final scheduledTime = DateTime(2026, 7, 24, 8, 30);

      await service.scheduleDailyReflectionNotification(
        content: item,
        scheduledTime: scheduledTime,
        nowOverride: now,
      );

      verify(() => mockPlugin.zonedSchedule(
            id: 9999,
            title: 'Sahih al-Bukhari 5',
            body: 'Actions are judged by intentions.',
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            payload: any(named: 'payload'),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          )).called(1);
    });

    test(
        'scheduleDailyReflectionNotification cancels notification and skips scheduling when enabled is false',
        () async {
      when(() => mockPlugin.cancel(id: any(named: 'id'))).thenAnswer((_) async {});

      const item = DailyContentItem(
        id: 'hadith_001',
        type: DailyContentType.hadith,
        reference: 'Sahih al-Bukhari 5',
        sourceWeight: 1.0,
        grade: 'Sahih',
        gradedBy: 'Al-Bukhari',
        arabicText: 'إنما الأعمال بالنيات',
        translationText: 'Actions are judged by intentions.',
        translationSource: 'Bukhari',
      );

      final now = DateTime(2026, 7, 24, 8, 0);
      final scheduledTime = DateTime(2026, 7, 24, 8, 30);

      await service.scheduleDailyReflectionNotification(
        content: item,
        scheduledTime: scheduledTime,
        enabled: false,
        nowOverride: now,
      );

      verify(() => mockPlugin.cancel(id: 9999)).called(1);
      verifyNever(() => mockPlugin.zonedSchedule(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            payload: any(named: 'payload'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          ));
    });

    test(
        'scheduleDailyReflectionNotification auto-advances past scheduled time to tomorrow',
        () async {
      when(() => mockPlugin.zonedSchedule(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            payload: any(named: 'payload'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          )).thenAnswer((_) async {});

      const item = DailyContentItem(
        id: 'hadith_001',
        type: DailyContentType.hadith,
        reference: 'Sahih al-Bukhari 5',
        sourceWeight: 1.0,
        grade: 'Sahih',
        gradedBy: 'Al-Bukhari',
        arabicText: 'إنما الأعمال بالنيات',
        translationText: 'Actions are judged by intentions.',
        translationSource: 'Bukhari',
      );

      final now = DateTime(2026, 7, 24, 9, 0);
      final scheduledTime = DateTime(2026, 7, 24, 8, 30); // past

      await service.scheduleDailyReflectionNotification(
        content: item,
        scheduledTime: scheduledTime,
        nowOverride: now,
      );

      verify(() => mockPlugin.zonedSchedule(
            id: 9999,
            title: 'Sahih al-Bukhari 5',
            body: 'Actions are judged by intentions.',
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            payload: any(named: 'payload'),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          )).called(1);
    });
  });
}
