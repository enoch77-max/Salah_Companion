import 'package:drift/drift.dart';

class DailyContentCacheTable extends Table {
  TextColumn get date => text()();
  TextColumn get contentId => text()();
  DateTimeColumn get resolvedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {date};
}
