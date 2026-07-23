import 'package:drift/drift.dart';

class DailyContentShownLogTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentId => text()();
  TextColumn get shownDate => text()();
}
