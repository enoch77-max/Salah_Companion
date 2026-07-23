import 'package:drift/drift.dart';

class PrayerLogsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get prayerName => text()();
  TextColumn get status => text()();
  DateTimeColumn get updatedAt => dateTime()();
}
