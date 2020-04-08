import 'package:moor/moor.dart';

@DataClassName("CategoryEntry")
class CategoryTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().customConstraint('unique')();

  TextColumn get pluralName => text().nullable()();

  TextColumn get warnInterval => text().nullable()();

  TextColumn get homeId => text().customConstraint('references Home(id)')();

  RealColumn get refillLimit => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
