import 'package:moor/moor.dart';

@DataClassName("BatchEntry")
class BatchTable extends Table {
  TextColumn get id => text()();

  TextColumn get productId => text().customConstraint('references ProductTable(id)')();

  DateTimeColumn get expirationDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
