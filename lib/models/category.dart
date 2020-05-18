import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart' show Product;
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Category implements HomeListable {
  String id;
  String name;
  String pluralName;
  Period warnInterval;
  List<Product> products = [];
  Home home;
  double refillLimit;
  UnitEnum unit;
  List<ModelChange> modelChanges = [];

  Category({this.id, @required this.name, this.pluralName, this.warnInterval, this.refillLimit, @required this.unit, List<Product> products = const [], @required this.home, this.modelChanges}) : products = products;

  double get amount => products.map((p) => p.amount).reduce((a, b) => a + b);

  @override
  String get title => amount > 1 ? (pluralName != null ? pluralName : name) : name;

  @override
  String get subtitle => UnitConverter.toScientific(Amount(amount, Unit.fromSi(unit))).toString();

  @override
  bool get expiredOrNotification {
    return products.any((product) => product.expiredOrNotification);
  }

  @override
  bool get tooFewAvailable {
    return (amount <= refillLimit) || products.any((product) => product.tooFewAvailable);
  }

  Category clone() {
    return Category(id: id, name: name, pluralName: pluralName, warnInterval: warnInterval, refillLimit: refillLimit, unit: unit, products: products, home: home, modelChanges: modelChanges);
  }

  bool isValid() {
    return unit != null && name != null && name != "";
  }

  bool operator ==(other) {
    return name == other.name && pluralName == other.pluralName && warnInterval == other.warnInterval && unit == other.unit && refillLimit == other.refillLimit;
  }

  factory Category.fromEntry(CategoryEntry categoryEntry, Home home, {List<Product> products, List<ModelChange> modelChanges}) {
    return Category(
      id: categoryEntry.id,
      name: categoryEntry.name,
      pluralName: categoryEntry.pluralName,
      refillLimit: categoryEntry.refillLimit,
      unit: UnitEnum.values[categoryEntry.unit],
      warnInterval: periodFromISO8601String(categoryEntry.warnInterval),
      products: products,
      home: home,
      modelChanges: modelChanges,
    );
  }

  CategoryTableCompanion toCompanion() {
    return CategoryTableCompanion(
      id: Value(id),
      name: Value(name),
      pluralName: Value(pluralName),
      refillLimit: Value(refillLimit),
      warnInterval: Value(warnInterval.toString()),
      homeId: Value(home.id),
      unit: Value(UnitEnum.values.indexOf(unit)),
    );
  }

  List<Modification> getModifications(Category other) {
    List<Modification> modifications = [];
    if (unit != other.unit) {
      modifications.add(Modification(fieldName: "unit", from: describeEnum(unit), to: describeEnum(other.unit)));
    }
    if (name != other.name) {
      modifications.add(Modification(fieldName: "name", from: name, to: other.name));
    }
    if (pluralName != other.pluralName) {
      modifications.add(Modification(fieldName: "pluralName", from: pluralName, to: other.pluralName));
    }
    if (warnInterval != other.warnInterval) {
      modifications.add(Modification(fieldName: "warnInterval", from: warnInterval.toString(), to: other.warnInterval.toString()));
    }
    if (refillLimit != other.refillLimit) {
      modifications.add(Modification(fieldName: "refillLimit", from: UnitConverter.toScientific(Amount.fromSi(refillLimit, unit)).toString().trim(), to: UnitConverter.toScientific(Amount.fromSi(other.refillLimit, other.unit)).toString().trim()));
    }
    return modifications;
  }
}
