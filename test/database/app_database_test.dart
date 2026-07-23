import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase Tests', () {
    test('FavoriteDailyContent Table CRUD', () async {
      final now = DateTime.now();
      await db.into(db.favoriteDailyContentTable).insert(
        FavoriteDailyContentTableCompanion.insert(
          contentId: 'verse_1',
          favoritedAt: now,
        ),
      );

      final result = await db.select(db.favoriteDailyContentTable).get();
      expect(result.length, 1);
      expect(result.first.contentId, 'verse_1');

      await db.delete(db.favoriteDailyContentTable).delete(result.first);
      final afterDelete = await db.select(db.favoriteDailyContentTable).get();
      expect(afterDelete.isEmpty, isTrue);
    });

    test('DailyContentCache Table CRUD', () async {
      final now = DateTime.now();
      await db.into(db.dailyContentCacheTable).insert(
        DailyContentCacheTableCompanion.insert(
          date: '2026-07-24',
          contentId: 'hadith_42',
          resolvedAt: now,
        ),
      );

      final result = await db.select(db.dailyContentCacheTable).get();
      expect(result.length, 1);
      expect(result.first.date, '2026-07-24');
      expect(result.first.contentId, 'hadith_42');
    });

    test('BatteryOptState Table CRUD', () async {
      final now = DateTime.now();
      await db.into(db.batteryOptStateTable).insert(
        BatteryOptStateTableCompanion.insert(
          id: const Value(1),
          lastKnownExempt: const Value(true),
          nagDisabled: const Value(false),
          lastPromptAt: Value(now),
        ),
      );

      final result = await db.select(db.batteryOptStateTable).get();
      expect(result.length, 1);
      expect(result.first.id, 1);
      expect(result.first.lastKnownExempt, isTrue);
      expect(result.first.nagDisabled, isFalse);
    });

    test('AppMetadata Table CRUD', () async {
      await db.into(db.appMetadataTable).insert(
        AppMetadataTableCompanion.insert(
          key: 'installation_seed',
          value: 'xyz123',
        ),
      );

      final result = await db.select(db.appMetadataTable).get();
      expect(result.length, 1);
      expect(result.first.key, 'installation_seed');
      expect(result.first.value, 'xyz123');
    });

    test('DailyContentShownLog Table CRUD', () async {
      await db.into(db.dailyContentShownLogTable).insert(
        DailyContentShownLogTableCompanion.insert(
          contentId: 'verse_1',
          shownDate: '2026-07-24',
        ),
      );

      final result = await db.select(db.dailyContentShownLogTable).get();
      expect(result.length, 1);
      expect(result.first.contentId, 'verse_1');
      expect(result.first.shownDate, '2026-07-24');
    });

    test('PrayerLogs Table CRUD', () async {
      final now = DateTime.now();
      await db.into(db.prayerLogsTable).insert(
        PrayerLogsTableCompanion.insert(
          date: '2026-07-24',
          prayerName: 'Fajr',
          status: 'completed',
          updatedAt: now,
        ),
      );

      final result = await db.select(db.prayerLogsTable).get();
      expect(result.length, 1);
      expect(result.first.prayerName, 'Fajr');
      expect(result.first.status, 'completed');
    });
  });
}
