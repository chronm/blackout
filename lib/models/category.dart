import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/cloneable.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Category extends Displayable implements Cloneable<Category> {
  String id;
  String name;
  String pluralName;
  Period warnInterval;
  List<Product> products = [];
  Home home;
  double refillLimit;

  Category clone() {
    return Category(id: this.id, name: this.name, pluralName: this.pluralName, warnInterval: this.warnInterval, refillLimit: this.refillLimit, unit: this.unit, products: this.products, home: this.home);
  }

  double get amount => products.map((p) => p.amount).reduce((a, b) => a + b);

  @override
  String get title => amount > 1 ? (pluralName != null ? pluralName : name) : name;

  @override
  bool get expiredOrNotification {
    return products.any((product) => product.expiredOrNotification);
  }

  @override
  bool get tooFewAvailable {
    return (amount <= refillLimit) || products.any((product) => product.tooFewAvailable);
  }

  Category({this.id, @required this.name, this.pluralName, this.warnInterval, this.refillLimit, @required UnitEnum unit, List<Product> products = const [], @required this.home})
      : products = products,
        super(unit);

  factory Category.fromEntry(CategoryEntry categoryEntry, Home home, {List<Product> products}) {
    return Category(
      id: categoryEntry.id,
      name: categoryEntry.name,
      pluralName: categoryEntry.pluralName,
      refillLimit: categoryEntry.refillLimit,
      unit: UnitEnum.values[categoryEntry.unit],
      warnInterval: periodFromISO8601String(categoryEntry.warnInterval),
      products: products,
      home: home,
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

  @override
  bool isValid() {
    return unit != null && name != null && name != "";
  }

  List<Modification> getModifications(Category category) {
    List<Modification> modifications = [];
    if (unit != category.unit) {
      modifications.add(Modification(fieldName: "unit", from: describeEnum(unit), to: describeEnum(category.unit)));
    }
    if (name != category.name) {
      modifications.add(Modification(fieldName: "name", from: name, to: category.name));
    }
    if (pluralName != category.pluralName) {
      modifications.add(Modification(fieldName: "pluralName", from: pluralName, to: category.pluralName));
    }
    if (warnInterval != category.warnInterval) {
      modifications.add(Modification(fieldName: "warnInterval", from: warnInterval.toString(), to: category.warnInterval.toString()));
    }
    if (refillLimit != category.refillLimit) {
      modifications.add(Modification(fieldName: "refillLimit", from: UnitConverter.toScientific(Amount.fromSi(refillLimit, unit)).toString().trim(), to: UnitConverter.toScientific(Amount.fromSi(category.refillLimit, category.unit)).toString().trim()));
    }
    return modifications;
  }

  @override
  bool operator ==(other) {
    return name == other.name && pluralName == other.pluralName && warnInterval == other.warnInterval && unit == other.unit && refillLimit == other.refillLimit;
  }
}
