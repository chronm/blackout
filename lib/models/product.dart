import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/charge.dart' show Charge;
import 'package:Blackout/models/group.dart' show Group;
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/product_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Product implements HomeListable {
  String id;
  String ean;
  Group group;
  String description;
  Period warnInterval;
  List<Charge> charges = [];
  Home home;
  double refillLimit;
  UnitEnum _unit;
  List<ModelChange> modelChanges = [];

  Product({this.id, this.ean, @required this.description, this.group, this.warnInterval, this.charges, this.refillLimit, UnitEnum unit, @required this.home, this.modelChanges}) : _unit = unit;

  void set unit(UnitEnum unit) => _unit = unit;

  UnitEnum get unit => group != null ? group.unit : _unit;

  @override
  String get title => description;

  @override
  String get scientificAmount => UnitConverter.toScientific(Amount(amount, Unit.fromSi(group != null ? group.unit : unit))).toString();

  String get scientificRefillLimit => UnitConverter.toScientific(Amount(refillLimit, Unit.fromSi(unit))).toString();

  @override
  String get subtitleBestBeforeNotification => "";

  @override
  bool get expired => charges.any((element) => element.expired);

  @override
  bool get warn => charges.any((element) => element.warn);

  @override
  bool get tooFewAvailable {
    return refillLimit != null ? amount <= refillLimit : false;
  }

  @override
  String buildStatus(BuildContext context) {
    return (charges..sort((a, b) => a.expirationDate.compareTo(b.expirationDate))).first.buildStatus(context);
  }

  LocalDate get expirationDate {
    return (charges..sort((a, b) => a.expirationDate.compareTo(b.expirationDate))).first.expirationDate;
  }

  @override
  ChargeStatus get status {
    if (expired) return ChargeStatus.expired;
    if (warn) return ChargeStatus.warn;
    return ChargeStatus.none;
  }

  Product clone() {
    return Product(id: id, ean: ean, group: group, description: description, warnInterval: warnInterval, charges: charges, home: home, refillLimit: refillLimit, unit: _unit, modelChanges: modelChanges);
  }

  bool isValid() {
    return description != null && description != "";
  }

  bool operator ==(other) {
    return ean == other.ean && description == other.description && refillLimit == other.refillLimit && group == other.group && warnInterval == other.warnInterval;
  }

  factory Product.fromEntry(ProductEntry entry, Home home, {Group group, List<Charge> charges, List<ModelChange> modelChanges}) {
    return Product(
      id: entry.id,
      ean: entry.ean,
      description: entry.description,
      refillLimit: entry.refillLimit,
      unit: entry.unit == null ? null : UnitEnum.values[entry.unit],
      group: group,
      charges: charges,
      home: home,
      modelChanges: modelChanges,
      warnInterval: periodFromISO8601String(entry.warnInterval),
    );
  }

  ProductTableCompanion toCompanion() {
    return ProductTableCompanion(
      id: Value(id),
      ean: Value(ean),
      description: Value(description),
      refillLimit: Value(refillLimit),
      unit: unit != null ? Value(UnitEnum.values.indexOf(unit)) : Value.absent(),
      groupId: group != null ? Value(group.id) : Value(null),
      homeId: Value(home.id),
      warnInterval: Value(warnInterval.toString()),
    );
  }

  List<Modification> getModifications(Product other) {
    List<Modification> modifications = [];
    if (ean != other.ean) {
      modifications.add(Modification(fieldName: "ean", from: ean, to: other.ean));
    }
    if (warnInterval != other.warnInterval) {
      String from = warnInterval != null ? warnInterval.toString() : null;
      modifications.add(Modification(fieldName: "warnInterval", from: from, to: other.warnInterval.toString()));
    }
    if (description != other.description) {
      modifications.add(Modification(fieldName: "description", from: description, to: other.description));
    }
    if (refillLimit != other.refillLimit) {
      String from = refillLimit != null ? UnitConverter.toScientific(Amount.fromSi(refillLimit, _unit)).toString() : null;
      modifications.add(Modification(fieldName: "refillLimit", from: from, to: UnitConverter.toScientific(Amount.fromSi(other.refillLimit, other.unit)).toString()));
    }
    if (unit != other.unit) {
      String from = unit != null ? describeEnum(_unit) : null;
      modifications.add(Modification(fieldName: "unit", from: from, to: describeEnum(group.unit)));
    }


    return modifications;
  }
}
