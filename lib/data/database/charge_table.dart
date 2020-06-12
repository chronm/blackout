import 'package:moor/moor.dart';

@DataClassName("ChargeEntry")
class ChargeTable extends Table {
  TextColumn get id => text()();

  TextColumn get productId => text().customConstraint('references ProductTable(id)')();

  DateTimeColumn get expirationDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
