import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Change {
  String id;
  User user;
  double value;
  LocalDate changeDate;
  Charge charge;
  Home home;

  Change({this.id, @required this.user, @required this.value, @required this.changeDate, @required this.charge, @required this.home});

  String get scientificAmount => UnitConverter.toScientific(Amount.fromSi(value.abs(), unit)).toString();

  String buildTitle(BuildContext context) {
    if (value < 0) {
      return S.of(context).CHANGE_TOOK(scientificAmount, changeDate.prettyPrintShortDifference(context));
    } else {
      return S.of(context).CHANGE_ADDED(scientificAmount, changeDate.prettyPrintShortDifference(context));
    }
  }

  String get subtitle => user.name;

  UnitEnum get unit => charge.unit;

  factory Change.fromEntry(ChangeEntry entry, User user, Home home, {Charge charge}) {
    return Change(
      id: entry.id,
      user: user,
      value: entry.value,
      changeDate: LocalDateFromDateTime(entry.changeDate),
      charge: charge,
      home: home,
    );
  }

  ChangeTableCompanion toCompanion() {
    return ChangeTableCompanion(
      id: Value(id),
      userId: Value(user.id),
      value: Value(value),
      changeDate: Value(changeDate.toDateTimeUnspecified()),
      chargeId: Value(charge.id),
      homeId: Value(home.id),
    );
  }
}
