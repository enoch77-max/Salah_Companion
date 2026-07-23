import 'package:drift/drift.dart';

import 'tables/app_metadata_table.dart';
import 'tables/battery_opt_state_table.dart';
import 'tables/daily_content_cache_table.dart';
import 'tables/daily_content_shown_log_table.dart';
import 'tables/favorite_daily_content_table.dart';
import 'tables/prayer_logs_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  PrayerLogsTable,
  BatteryOptStateTable,
  DailyContentCacheTable,
  DailyContentShownLogTable,
  FavoriteDailyContentTable,
  AppMetadataTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
