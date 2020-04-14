import 'package:moor/moor.dart';

@DataClassName("DatabaseChangelogEntry")
class DatabaseChangelogTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get modificationDate => dateTime()();
  TextColumn get userId => text()();
  TextColumn get categoryId =>
      text().nullable().customConstraint('null references CategoryTable(id)')();
  TextColumn get productId =>
      text().nullable().customConstraint('null references ProductTable(id)')();
  TextColumn get itemId =>
      text().nullable().customConstraint('null references ItemTable(id)')();
  IntColumn get direction => integer()();
  TextColumn get homeId => text().customConstraint('references Home(id)')();
  TextColumn get fieldName => text().nullable()();
  TextColumn get from => text().nullable()();
  TextColumn get to => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
