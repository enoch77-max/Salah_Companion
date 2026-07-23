import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/database/app_database.dart';
import '../../domain/models/daily_content.dart';

class DailyContentRepository {
  final AppDatabase _db;
  final String? jsonAssetOverride;
  List<DailyContentItem>? _cachedPool;

  DailyContentRepository(
    this._db, {
    this.jsonAssetOverride,
  });

  Future<List<DailyContentItem>> loadPool() async {
    if (_cachedPool != null) return _cachedPool!;

    final String jsonStr;
    final override = jsonAssetOverride;
    if (override != null) {
      jsonStr = override;
    } else {
      jsonStr = await rootBundle.loadString('assets/data/daily_content.json');
    }

    final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
    _cachedPool = jsonList
        .map((e) => DailyContentItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return _cachedPool!;
  }

  Future<DailyContentItem> resolveTodayContent({
    required String installationSeed,
    required DateTime today,
    String? activeOccasion,
    int noRepeatDays = 45,
  }) async {
    final dateStr = _formatDate(today);

    // 1. Check cache first
    final cached = await (_db.select(_db.dailyContentCacheTable)
          ..where((tbl) => tbl.date.equals(dateStr)))
        .getSingleOrNull();

    final pool = await loadPool();

    if (cached != null) {
      final cachedItem =
          pool.where((item) => item.id == cached.contentId).firstOrNull;
      if (cachedItem != null) {
        return cachedItem;
      }
    }

    // 2. Filter pool against 45-day history in DailyContentShownLogTable
    final cutOffDate = today.subtract(Duration(days: noRepeatDays));
    final cutOffStr = _formatDate(cutOffDate);

    final recentLogs = await (_db.select(_db.dailyContentShownLogTable)
          ..where(
              (tbl) => tbl.shownDate.isBiggerOrEqualValue(cutOffStr)))
        .get();

    final excludedIds = recentLogs.map((log) => log.contentId).toSet();

    List<DailyContentItem> candidatePool =
        pool.where((item) => !excludedIds.contains(item.id)).toList();

    if (candidatePool.isEmpty) {
      candidatePool = List.from(pool);
    }

    // 3. Filter for activeOccasion if specified
    if (activeOccasion != null && activeOccasion.trim().isNotEmpty) {
      final occasionMatched = candidatePool
          .where((item) =>
              item.occasion == activeOccasion ||
              item.tags.contains(activeOccasion))
          .toList();
      if (occasionMatched.isNotEmpty) {
        candidatePool = occasionMatched;
      }
    }

    // 4. Source-weight weighted random selection seeded with hash(installationSeed + ISO_date)
    final seedInput = "$installationSeed$dateStr";
    final seed = _hashSeed(seedInput);
    final random = Random(seed);

    final double totalWeight = candidatePool.fold(
      0.0,
      (sum, item) => sum + item.sourceWeight,
    );

    final double roll = random.nextDouble() * totalWeight;
    double cumulative = 0.0;
    DailyContentItem selected = candidatePool.last;

    for (final item in candidatePool) {
      cumulative += item.sourceWeight;
      if (roll <= cumulative) {
        selected = item;
        break;
      }
    }

    // 5. Write resolved pick to DailyContentCacheTable and DailyContentShownLogTable
    await _db.into(_db.dailyContentCacheTable).insertOnConflictUpdate(
          DailyContentCacheTableCompanion.insert(
            date: dateStr,
            contentId: selected.id,
            resolvedAt: DateTime.now(),
          ),
        );

    await _db.into(_db.dailyContentShownLogTable).insert(
          DailyContentShownLogTableCompanion.insert(
            contentId: selected.id,
            shownDate: dateStr,
          ),
        );

    return selected;
  }

  Future<void> toggleFavorite(String contentId) async {
    final existing = await (_db.select(_db.favoriteDailyContentTable)
          ..where((tbl) => tbl.contentId.equals(contentId)))
        .getSingleOrNull();

    if (existing != null) {
      await (_db.delete(_db.favoriteDailyContentTable)
            ..where((tbl) => tbl.contentId.equals(contentId)))
          .go();
    } else {
      await _db.into(_db.favoriteDailyContentTable).insert(
            FavoriteDailyContentTableCompanion.insert(
              contentId: contentId,
              favoritedAt: DateTime.now(),
            ),
          );
    }
  }

  Future<bool> isFavorited(String contentId) async {
    final existing = await (_db.select(_db.favoriteDailyContentTable)
          ..where((tbl) => tbl.contentId.equals(contentId)))
        .getSingleOrNull();
    return existing != null;
  }

  Future<List<DailyContentItem>> getFavoritedContent() async {
    final favorites = await (_db.select(_db.favoriteDailyContentTable)
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.favoritedAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();

    final pool = await loadPool();
    final poolMap = {for (final item in pool) item.id: item};

    return favorites
        .map((f) => poolMap[f.contentId])
        .whereType<DailyContentItem>()
        .toList();
  }

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  int _hashSeed(String input) {
    var hash = 0x811c9dc5;
    for (var i = 0; i < input.length; i++) {
      hash ^= input.codeUnitAt(i);
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash & 0x7FFFFFFF;
  }
}
