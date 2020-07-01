import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' show Value, required;
import 'package:time_machine/time_machine.dart';

import '../data/database/database.dart';
import '../util/batch_extension.dart';
import '../util/product_extension.dart';
import '../util/time_machine_extension.dart';
import 'batch.dart' show Batch;
import 'group.dart' show Group;
import 'home.dart';
import 'home_listable.dart';
import 'model_change.dart';
import 'modification.dart';
import 'unit/unit.dart';

class Product implements HomeListable {
  String id;
  String ean;
  Group group;
  String description;
  Period warnInterval;
  List<Batch> batches = [];
  Home home;
  double refillLimit;
  UnitEnum _unit;
  List<ModelChange> modelChanges = [];

  Product({this.id, this.ean, @required this.description, this.group, this.warnInterval, this.batches, this.refillLimit, UnitEnum unit, @required this.home, this.modelChanges}) : _unit = unit;

  set unit(UnitEnum unit) => _unit = unit;

  UnitEnum get unit => group != null ? group.unit : _unit;

  @override
  String get title => description;

  @override
  String get scientificAmount => UnitConverter.toScientific(Amount(amount, Unit.fromSi(group != null ? group.unit : unit))).toString();

  String get scientificRefillLimit => UnitConverter.toScientific(Amount(refillLimit, Unit.fromSi(unit))).toString();

  @override
  String get subtitleBestBeforeNotification => "";

  @override
  bool get expired => batches.any((element) => element.expired);

  @override
  bool get warn => batches.any((element) => element.warn);

  @override
  bool get tooFewAvailable {
    return refillLimit != null ? amount <= refillLimit : false;
  }

  @override
  String buildStatus(BuildContext context) {
    return batches.length != 0 ? (batches..sort((a, b) => a.expirationDate.compareTo(b.expirationDate))).first.buildStatus(context) : null;
  }

  LocalDate get expirationDate {
    return batches.length != 0 ? (batches..sort((a, b) => a.expirationDate.compareTo(b.expirationDate))).first.expirationDate : null;
  }

  @override
  BatchStatus get status {
    if (expired) return BatchStatus.expired;
    if (warn) return BatchStatus.warn;
    return BatchStatus.none;
  }

  Product clone() {
    return Product(id: id, ean: ean, group: group, description: description, warnInterval: warnInterval, batches: batches, home: home, refillLimit: refillLimit, unit: _unit, modelChanges: modelChanges);
  }

  bool isValid() {
    return description != null && description != "";
  }

  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic other) {
    return ean == other.ean && description == other.description && refillLimit == other.refillLimit && group == other.group && warnInterval == other.warnInterval;
  }

  factory Product.fromEntry(ProductEntry entry, Home home, {Group group, List<Batch> batches, List<ModelChange> modelChanges}) {
    return Product(
      id: entry.id,
      ean: entry.ean,
      description: entry.description,
      refillLimit: entry.refillLimit,
      unit: entry.unit == null ? null : UnitEnum.values[entry.unit],
      group: group,
      batches: batches,
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
    var modifications = <Modification>[];
    if (ean != other.ean) {
      modifications.add(Modification(fieldName: "ean", from: ean, to: other.ean));
    }
    if (warnInterval != other.warnInterval) {
      var from = warnInterval != null ? warnInterval.toString() : null;
      modifications.add(Modification(fieldName: "warnInterval", from: from, to: other.warnInterval.toString()));
    }
    if (description != other.description) {
      modifications.add(Modification(fieldName: "description", from: description, to: other.description));
    }
    if (refillLimit != other.refillLimit) {
      var from = refillLimit != null ? UnitConverter.toScientific(Amount.fromSi(refillLimit, _unit)).toString() : null;
      modifications.add(Modification(fieldName: "refillLimit", from: from, to: UnitConverter.toScientific(Amount.fromSi(other.refillLimit, other.unit)).toString()));
    }
    if (unit != other.unit) {
      var from = unit != null ? describeEnum(_unit) : null;
      modifications.add(Modification(fieldName: "unit", from: from, to: describeEnum(group.unit)));
    }

    return modifications;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => super.hashCode;
}
