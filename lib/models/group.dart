import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart' show Product;
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/group_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

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

  Group({this.id, @required this.name, this.pluralName, this.warnInterval, this.refillLimit, @required this.unit, List<Product> products, @required this.home, this.modelChanges}) : products = products;

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
    return products.length != 0 ? (products..sort((a, b) => a.expirationDate.compareTo(b.expirationDate))).first.buildStatus(context) : null;
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

  bool operator ==(other) {
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
    List<Modification> modifications = [];
    if (unit != other.unit) {
      String from = unit != null ? describeEnum(unit) : null;
      modifications.add(Modification(fieldName: "unit", from: from, to: describeEnum(other.unit)));
    }
    if (name != other.name) {
      modifications.add(Modification(fieldName: "name", from: name, to: other.name));
    }
    if (pluralName != other.pluralName) {
      modifications.add(Modification(fieldName: "pluralName", from: pluralName, to: other.pluralName));
    }
    if (warnInterval != other.warnInterval) {
      String from = warnInterval != null ? warnInterval.toString() : null;
      modifications.add(Modification(fieldName: "warnInterval", from: from, to: other.warnInterval.toString()));
    }
    if (refillLimit != other.refillLimit) {
      String from = refillLimit != null ? UnitConverter.toScientific(Amount.fromSi(refillLimit, unit)).toString() : null;
      modifications.add(Modification(fieldName: "refillLimit", from: from, to: UnitConverter.toScientific(Amount.fromSi(other.refillLimit, other.unit)).toString()));
    }
    return modifications;
  }
}
