import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/category.dart' show Category;
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/item.dart' show Item;
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Product extends HomeListable {
  String id;
  String ean;
  Category category;
  String description;
  List<Item> items = [];
  Home home;
  double refillLimit;
  UnitEnum _unit;
  List<ModelChange> modelChanges = [];

  Product({this.id, this.ean, @required this.description, this.category, this.items, this.refillLimit, UnitEnum unit, @required this.home, this.modelChanges}) : _unit = unit;

  void set unit(UnitEnum unit) => _unit = unit;

  UnitEnum get unit => category != null ? category.unit : _unit;

  double get amount => items.map((i) => i.amount).reduce((a, b) => a + b);

  @override
  String get title => description;

  @override
  String get subtitle => UnitConverter.toScientific(Amount(amount, Unit.fromSi(category != null ? category.unit : unit))).toString();

  @override
  bool get expiredOrNotification {
    bool isExpired = false;
    if (category?.warnInterval != null) {
      isExpired = items.where((item) => item.expirationDate != null).any((item) => item.expirationDate.subtract(category.warnInterval) < LocalDateTime.now());
    }

    return isExpired || items.where((item) => item.notificationDate != null).any((item) => item.notificationDate <= LocalDateTime.now());
  }

  @override
  bool get tooFewAvailable => refillLimit != null ? amount <= refillLimit : false;

  Product clone() {
    return Product(id: id, ean: ean, category: category, description: description, items: items, home: home, refillLimit: refillLimit, unit: unit, modelChanges: modelChanges);
  }

  bool isValid() {
    return description != null && description != "";
  }

   bool operator ==(other) {
    return ean == other.ean && description == other.description && refillLimit == other.refillLimit && category == other.category;
  }

  factory Product.fromEntry(ProductEntry entry, Home home, {Category category, List<Item> items, List<ModelChange> modelChanges}) {
    return Product(
      id: entry.id,
      ean: entry.ean,
      description: entry.description,
      refillLimit: entry.refillLimit,
      unit: entry.unit == null ? null : UnitEnum.values[entry.unit],
      category: category,
      items: items,
      home: home,
      modelChanges: modelChanges,
    );
  }

  ProductTableCompanion toCompanion() {
    return ProductTableCompanion(
      id: Value(id),
      ean: Value(ean),
      description: Value(description),
      refillLimit: Value(refillLimit),
      unit: unit != null ? Value(UnitEnum.values.indexOf(unit)) : Value.absent(),
      categoryId: category != null ? Value(category.id) : Value(null),
      homeId: Value(home.id),
    );
  }

  List<Modification> getModifications(Product other) {
    List<Modification> modifications = [];
    if (ean != other.ean) {
      modifications.add(Modification(fieldName: "ean", from: ean, to: other.ean));
    }
    if (description != other.description) {
      modifications.add(Modification(fieldName: "description", from: description, to: other.description));
    }
    if (refillLimit != other.refillLimit) {
      modifications.add(Modification(fieldName: "refillLimit", from: UnitConverter.toScientific(Amount.fromSi(refillLimit, _unit)).toString(), to: UnitConverter.toScientific(Amount.fromSi(other.refillLimit, other.unit)).toString()));
    }
    if (unit != other.unit) {
      modifications.add(Modification(fieldName: "unit", from: describeEnum(unit), to: describeEnum(category.unit)));
    }

    return modifications;
  }
}
