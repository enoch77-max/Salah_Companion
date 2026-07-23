import 'dart:io';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/database/app_database.dart';
import 'package:salah_companion/features/reflection/data/repositories/daily_content_repository.dart';
import 'package:salah_companion/features/reflection/domain/models/daily_content.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late String jsonContent;
  late DailyContentRepository repo;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final file = File('assets/data/daily_content.json');
    expect(file.existsSync(), isTrue,
        reason: 'assets/data/daily_content.json must exist');
    jsonContent = file.readAsStringSync();
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DailyContentRepository(db, jsonAssetOverride: jsonContent);
  });

  tearDown(() async {
    await db.close();
  });

  group('DailyContentRepository Tests', () {
    test('Test 1: Sanity check dataset — 100% Sahih Hadiths & non-empty graded_by',
        () async {
      final pool = await repo.loadPool();

      expect(pool.length, greaterThanOrEqualTo(180),
          reason: 'Dataset must contain 180+ entries');

      final hadiths =
          pool.where((item) => item.type == DailyContentType.hadith).toList();
      final ayahs =
          pool.where((item) => item.type == DailyContentType.ayah).toList();

      expect(hadiths.length, greaterThan(0));
      expect(ayahs.length, greaterThan(0));

      for (final hadith in hadiths) {
        expect(hadith.grade, equals('Sahih'),
            reason: 'Hadith ${hadith.id} must be graded Sahih');
        expect(hadith.gradedBy, isNotNull,
            reason: 'Hadith ${hadith.id} must have non-empty gradedBy');
        expect(hadith.gradedBy!.trim().isNotEmpty, isTrue,
            reason: 'Hadith ${hadith.id} must have non-empty gradedBy');
        expect(hadith.arabicText.trim().isNotEmpty, isTrue);
        expect(hadith.translationText.trim().isNotEmpty, isTrue);
        expect(hadith.translationSource.trim().isNotEmpty, isTrue);
        expect(hadith.reference.trim().isNotEmpty, isTrue);
        expect(
            hadith.sourceWeight == 1.5 || hadith.sourceWeight == 1.0, isTrue);
      }

      for (final ayah in ayahs) {
        expect(ayah.arabicText.trim().isNotEmpty, isTrue);
        expect(ayah.translationText.trim().isNotEmpty, isTrue);
        expect(ayah.translationSource.trim().isNotEmpty, isTrue);
        expect(ayah.reference.trim().isNotEmpty, isTrue);
        expect(ayah.sourceWeight, equals(1.0));
      }
    });

    test('Test 2: Selection algorithm stability for same install on same date',
        () async {
      final today = DateTime(2026, 7, 24);
      const seed = 'installation_seed_12345';

      final item1 = await repo.resolveTodayContent(
        installationSeed: seed,
        today: today,
      );

      // Resolve again on the same date with same repository / DB (cache hit)
      final item2 = await repo.resolveTodayContent(
        installationSeed: seed,
        today: today,
      );

      expect(item1.id, equals(item2.id));

      // Create a fresh DB and repo instance to verify calculation stability
      final db2 = AppDatabase(NativeDatabase.memory());
      final repo2 = DailyContentRepository(db2, jsonAssetOverride: jsonContent);

      final item3 = await repo2.resolveTodayContent(
        installationSeed: seed,
        today: today,
      );

      await db2.close();

      expect(item1.id, equals(item3.id));
    });

    test(
        'Test 3: Selection variation between two different installation seeds on same date',
        () async {
      final today = DateTime(2026, 7, 24);

      final dbA = AppDatabase(NativeDatabase.memory());
      final repoA = DailyContentRepository(dbA, jsonAssetOverride: jsonContent);

      final dbB = AppDatabase(NativeDatabase.memory());
      final repoB = DailyContentRepository(dbB, jsonAssetOverride: jsonContent);

      final itemA = await repoA.resolveTodayContent(
        installationSeed: 'seed_alpha_001',
        today: today,
      );

      final itemB = await repoB.resolveTodayContent(
        installationSeed: 'seed_beta_99999',
        today: today,
      );

      await dbA.close();
      await dbB.close();

      expect(itemA.id, isNot(equals(itemB.id)));
    });

    test('Test 4: 45-day no-repeat constraint enforcement', () async {
      const seed = 'no_repeat_test_seed';
      final startDate = DateTime(2026, 1, 1);
      final shownIds = <String>[];

      for (int i = 0; i < 45; i++) {
        final currentDate = startDate.add(Duration(days: i));
        final item = await repo.resolveTodayContent(
          installationSeed: seed,
          today: currentDate,
          noRepeatDays: 45,
        );

        expect(shownIds.contains(item.id), isFalse,
            reason:
                'Item ${item.id} was shown on day $i despite 45-day no-repeat rule!');
        shownIds.add(item.id);
      }

      expect(shownIds.length, equals(45));
      expect(shownIds.toSet().length, equals(45));

      // Day 46 should resolve cleanly without error
      final day46Item = await repo.resolveTodayContent(
        installationSeed: seed,
        today: startDate.add(const Duration(days: 45)),
        noRepeatDays: 45,
      );
      expect(day46Item.id.isNotEmpty, isTrue);
    });

    test('Test 5: Favorites toggle and retrieve operations', () async {
      final pool = await repo.loadPool();
      final item1 = pool[0];
      final item2 = pool[1];

      // Initial state: not favorited
      expect(await repo.isFavorited(item1.id), isFalse);
      expect(await repo.isFavorited(item2.id), isFalse);

      var favorites = await repo.getFavoritedContent();
      expect(favorites, isEmpty);

      // Toggle favorite on item1
      await repo.toggleFavorite(item1.id);
      expect(await repo.isFavorited(item1.id), isTrue);

      favorites = await repo.getFavoritedContent();
      expect(favorites.length, equals(1));
      expect(favorites.first.id, equals(item1.id));

      // Toggle favorite on item2
      await repo.toggleFavorite(item2.id);
      expect(await repo.isFavorited(item2.id), isTrue);

      favorites = await repo.getFavoritedContent();
      expect(favorites.length, equals(2));

      // Toggle favorite off item1
      await repo.toggleFavorite(item1.id);
      expect(await repo.isFavorited(item1.id), isFalse);

      favorites = await repo.getFavoritedContent();
      expect(favorites.length, equals(1));
      expect(favorites.first.id, equals(item2.id));
    });
  });
}
