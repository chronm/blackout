import 'package:moor/moor.dart';

@DataClassName("ProductEntry")
class ProductTable extends Table {
  TextColumn get id => text()();

  TextColumn get ean => text().nullable().customConstraint('unique')();

  TextColumn get groupId => text().nullable().customConstraint('null references GroupTable(id)')();

  TextColumn get description => text().customConstraint('unique')();

  TextColumn get homeId => text().customConstraint('references Home(id)')();

  RealColumn get refillLimit => real().nullable()();

  IntColumn get unit => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
