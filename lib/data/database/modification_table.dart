import 'package:moor/moor.dart';

@DataClassName("ModificationEntry")
class ModificationTable extends Table {
  TextColumn get id => text()();
  TextColumn get modelChangeId => text().customConstraint('references ModelChangeTable(id)')();
  TextColumn get fieldName => text()();
  TextColumn get from => text()();
  TextColumn get to => text()();
  TextColumn get homeId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
