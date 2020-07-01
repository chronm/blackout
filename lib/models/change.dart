import 'package:flutter/material.dart';
import 'package:moor/moor.dart' show Value, required;
import 'package:time_machine/time_machine.dart';

import '../data/database/database.dart';
import '../generated/l10n.dart';
import '../util/batch_extension.dart';
import '../util/string_extension.dart';
import '../util/time_machine_extension.dart';
import 'batch.dart';
import 'home.dart';
import 'unit/unit.dart';
import 'user.dart';

class Change {
  String id;
  User user;
  double value;
  LocalDate changeDate;
  Batch batch;
  Home home;

  Change({this.id, @required this.user, @required this.value, @required this.changeDate, @required this.batch, @required this.home});

  String get scientificAmount => UnitConverter.toScientific(Amount.fromSi(value.abs(), unit)).toString();

  String buildTitle(BuildContext context) {
    if (value < 0) {
      return S.of(context).CHANGE_TOOK(scientificAmount, changeDate.prettyPrintShortDifference(context)).capitalize();
    } else {
      return S.of(context).CHANGE_ADDED(scientificAmount, changeDate.prettyPrintShortDifference(context)).capitalize();
    }
  }

  String get subtitle => user.name;

  UnitEnum get unit => batch.unit;

  factory Change.fromEntry(ChangeEntry entry, User user, Home home, {Batch batch}) {
    return Change(
      id: entry.id,
      user: user,
      value: entry.value,
      changeDate: localDateFromDateTime(entry.changeDate),
      batch: batch,
      home: home,
    );
  }

  ChangeTableCompanion toCompanion() {
    return ChangeTableCompanion(
      id: Value(id),
      userId: Value(user.id),
      value: Value(value),
      changeDate: Value(changeDate.toDateTimeUnspecified()),
      batchId: Value(batch.id),
      homeId: Value(home.id),
    );
  }
}
