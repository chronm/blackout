import 'package:moor/moor.dart';

@DataClassName("SyncEntry")
class SyncTable extends Table {
  DateTimeColumn get synchronizationDate => dateTime()();

  TextColumn get userId => text()();

  TextColumn get homeId => text().customConstraint('references Home(id)')();

  @override
  Set<Column> get primaryKey => {userId};
}
