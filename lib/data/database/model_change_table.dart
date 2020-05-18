import 'package:moor/moor.dart';

@DataClassName("ModelChangeEntry")
class ModelChangeTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get modificationDate => dateTime()();
  TextColumn get userId => text()();
  TextColumn get categoryId => text().nullable().customConstraint('null references CategoryTable(id)')();
  TextColumn get productId => text().nullable().customConstraint('null references ProductTable(id)')();
  TextColumn get chargeId => text().nullable().customConstraint('null references ChargeTable(id)')();
  IntColumn get direction => integer()();
  TextColumn get homeId => text().customConstraint('references Home(id)')();

  @override
  Set<Column> get primaryKey => {id};
}
