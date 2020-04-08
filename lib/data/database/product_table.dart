import 'package:moor/moor.dart';

@DataClassName("ProductEntry")
class ProductTable extends Table {
  TextColumn get id => text()();

  TextColumn get ean => text().nullable()();

  TextColumn get categoryId => text().nullable().customConstraint('null references CategoryTable(id)')();

  TextColumn get description => text()();

  TextColumn get homeId => text().customConstraint('references Home(id)')();

  RealColumn get refillLimit => real().nullable()();

  IntColumn get unit => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
