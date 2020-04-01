import 'package:moor/moor.dart';

@DataClassName("ItemEntry")
class ItemTable extends Table {
  TextColumn get id => text()();

  TextColumn get productId => text().customConstraint('references ProductTable(id)')();

  DateTimeColumn get expirationDate => dateTime().nullable()();

  DateTimeColumn get notificationDate => dateTime().nullable()();

  TextColumn get homeId => text().customConstraint('references Home(id)')();

  @override
  Set<Column> get primaryKey => {id};
}
