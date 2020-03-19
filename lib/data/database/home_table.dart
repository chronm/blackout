import 'package:moor/moor.dart';

@DataClassName("HomeEntry")
class HomeTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}