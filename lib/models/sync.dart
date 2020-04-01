import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Sync {
  User user;
  LocalDateTime synchronizationDate;
  Home home;

  Sync({@required this.user, @required this.synchronizationDate, @required this.home});

  factory Sync.fromEntry(SyncEntry entry, User user, Home home) {
    return Sync(
      user: user,
      synchronizationDate: localDateTimeFromDateTime(entry.synchronizationDate),
      home: home,
    );
  }

  SyncTableCompanion toCompanion() {
    return SyncTableCompanion(
      userId: Value(user.id),
      synchronizationDate: Value(synchronizationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }
}
