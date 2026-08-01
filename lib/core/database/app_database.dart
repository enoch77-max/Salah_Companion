import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/app_metadata_table.dart';
import 'tables/battery_opt_state_table.dart';
import 'tables/daily_content_cache_table.dart';
import 'tables/daily_content_shown_log_table.dart';
import 'tables/favorite_daily_content_table.dart';
import 'tables/prayer_logs_table.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'salah_companion.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [
  PrayerLogsTable,
  BatteryOptStateTable,
  DailyContentCacheTable,
  DailyContentShownLogTable,
  FavoriteDailyContentTable,
  AppMetadataTable,
])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  AppDatabase(super.e);

  factory AppDatabase.instance() {
    _instance ??= AppDatabase(_openConnection());
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Safe schema upgrade path without dropping user data
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
