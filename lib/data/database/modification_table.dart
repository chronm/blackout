import 'package:moor/moor.dart';

@DataClassName("ModificationEntry")
class ModificationTable extends Table {
  TextColumn get id => text()();

  TextColumn get modelChangeId =>
      text().customConstraint('references ModelChangeTable(id)')();

  TextColumn get fieldName => text()();

  TextColumn get from => text().nullable()();

  TextColumn get to => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
