import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Change {
  String id;
  User user;
  double value;
  LocalDateTime changeDate;
  Item item;
  Home home;

  Change({this.id, @required this.user, @required this.value, @required this.changeDate, @required this.item, @required this.home});

  factory Change.fromEntry(ChangeEntry entry, User user, Home home, {Item item}) {
    return Change(
      id: entry.id,
      user: user,
      value: entry.value,
      changeDate: localDateTimeFromDateTime(entry.changeDate),
      item: item,
      home: home,
    );
  }

  ChangeTableCompanion toCompanion() {
    return ChangeTableCompanion(
      id: Value(id),
      userId: Value(user.id),
      value: Value(value),
      changeDate: Value(changeDate.toDateTimeLocal()),
      itemId: Value(item.id),
      homeId: Value(home.id),
    );
  }
}
