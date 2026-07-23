import 'package:drift/drift.dart';

class FavoriteDailyContentTable extends Table {
  TextColumn get contentId => text()();
  DateTimeColumn get favoritedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {contentId};
}
