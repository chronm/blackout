import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName("ChangeEntry")
class ChangeTable extends Table {
  TextColumn get id => text().clientDefault(() => Uuid().v4())();

  TextColumn get userId => text()();

  RealColumn get value => real()();

  DateTimeColumn get changeDate => dateTime()();

  TextColumn get chargeId =>
      text().customConstraint('references ChargeTable(id)')();

  TextColumn get homeId => text().customConstraint('references Home(id)')();

  @override
  Set<Column> get primaryKey => {id};
}
