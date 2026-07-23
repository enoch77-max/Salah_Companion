import 'package:drift/drift.dart';

class BatteryOptStateTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get lastKnownExempt => boolean().nullable()();
  BoolColumn get nagDisabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastPromptAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
