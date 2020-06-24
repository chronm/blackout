import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

import '../data/database/database.dart';
import '../util/charge_extension.dart';
import '../util/group_extension.dart';
import '../util/time_machine_extension.dart';
import 'home.dart';
import 'home_listable.dart';
import 'model_change.dart';
import 'modification.dart';
import 'product.dart' show Product;
import 'unit/unit.dart';

class Group implements HomeListable {
  String id;
  String name;
  String pluralName;
  Period warnInterval;
  List<Product> products = [];
  Home home;
  double refillLimit;
  UnitEnum unit;
  List<ModelChange> modelChanges = [];

  Group({this.id, @required this.name, this.pluralName, this.warnInterval, this.refillLimit, @required this.unit, this.products, @required this.home, this.modelChanges});

  @override
  String get title => amount != 1 ? (pluralName != null ? pluralName : name) : name;

  @override
  String get scientificAmount => UnitConverter.toScientific(Amount(amount, Unit.fromSi(unit))).toString();

  String get scientificRefillLimit => UnitConverter.toScientific(Amount(refillLimit, Unit.fromSi(unit))).toString();

  @override
  String get subtitleBestBeforeNotification => "";

  @override
  bool get expired {
    return products.any((product) => product.expired);
  }

  @override
  bool get warn {
    return products.any((element) => element.warn);
  }
  
  @override
  bool get tooFewAvailable {
    return refillLimit != null ? amount <= refillLimit : false;
  }

  @override
  String buildStatus(BuildContext context) {
    return products.length != 0 ? (products..sort((a, b) => (a.expirationDate ?? LocalDate.today().addYears(100)).compareTo((b.expirationDate ?? LocalDate.today().addYears(100))))).first.buildStatus(context) : null;
  }

  @override
  ChargeStatus get status {
    if (expired) return ChargeStatus.expired;
    if (warn) return ChargeStatus.warn;
    return ChargeStatus.none;
  }

  Group clone() {
    return Group(id: id, name: name, pluralName: pluralName, warnInterval: warnInterval, refillLimit: refillLimit, unit: unit, products: products, home: home, modelChanges: modelChanges);
  }

  bool isValid() {
    return unit != null && name != null && name != "";
  }

  bool operator ==(dynamic other) {
    return name == other.name && pluralName == other.pluralName && warnInterval == other.warnInterval && unit == other.unit && refillLimit == other.refillLimit;
  }

  factory Group.fromEntry(GroupEntry groupEntry, Home home, {List<Product> products, List<ModelChange> modelChanges}) {
    return Group(
      id: groupEntry.id,
      name: groupEntry.name,
      pluralName: groupEntry.pluralName,
      refillLimit: groupEntry.refillLimit,
      unit: UnitEnum.values[groupEntry.unit],
      warnInterval: periodFromISO8601String(groupEntry.warnInterval),
      products: products,
      home: home,
      modelChanges: modelChanges,
    );
  }

  GroupTableCompanion toCompanion() {
    return GroupTableCompanion(
      id: Value(id),
      name: Value(name),
      pluralName: Value(pluralName),
      refillLimit: Value(refillLimit),
      warnInterval: Value(warnInterval.toString()),
      homeId: Value(home.id),
      unit: Value(UnitEnum.values.indexOf(unit)),
    );
  }

  List<Modification> getModifications(Group other) {
    var modifications = <Modification>[];
    if (unit != other.unit) {
      var from = unit != null ? describeEnum(unit) : null;
      modifications.add(Modification(fieldName: "unit", from: from, to: describeEnum(other.unit)));
    }
    if (name != other.name) {
      modifications.add(Modification(fieldName: "name", from: name, to: other.name));
    }
    if (pluralName != other.pluralName) {
      modifications.add(Modification(fieldName: "pluralName", from: pluralName, to: other.pluralName));
    }
    if (warnInterval != other.warnInterval) {
      var from = warnInterval != null ? warnInterval.toString() : null;
      modifications.add(Modification(fieldName: "warnInterval", from: from, to: other.warnInterval.toString()));
    }
    if (refillLimit != other.refillLimit) {
      var from = refillLimit != null ? UnitConverter.toScientific(Amount.fromSi(refillLimit, unit)).toString() : null;
      modifications.add(Modification(fieldName: "refillLimit", from: from, to: UnitConverter.toScientific(Amount.fromSi(other.refillLimit, other.unit)).toString()));
    }
    return modifications;
  }

  @override
  int get hashCode => super.hashCode;
}
