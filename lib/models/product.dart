import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/group.dart' show Group;
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/charge.dart' show Charge;
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Product implements HomeListable {
  String id;
  String ean;
  Group group;
  String description;
  List<Charge> charges = [];
  Home home;
  double refillLimit;
  UnitEnum _unit;
  List<ModelChange> modelChanges = [];

  String hierarchy(BuildContext context) => group != null ? group.title : null;

  Product({this.id, this.ean, @required this.description, this.group, this.charges, this.refillLimit, UnitEnum unit, @required this.home, this.modelChanges}) : _unit = unit;

  void set unit(UnitEnum unit) => _unit = unit;

  UnitEnum get unit => group != null ? group.unit : _unit;

  double get amount => charges.map((i) => i.amount).reduce((a, b) => a + b);

  @override
  String get title => description;

  @override
  String get subtitle => UnitConverter.toScientific(Amount(amount, Unit.fromSi(group != null ? group.unit : unit))).toString();

  @override
  bool get expiredOrNotification {
    bool isExpired = false;
    if (group?.warnInterval != null) {
      isExpired = charges.where((charge) => charge.expirationDate != null).any((charge) => charge.expirationDate.subtract(group.warnInterval) < LocalDateTime.now());
    }

    return isExpired || charges.where((charge) => charge.notificationDate != null).any((charge) => charge.notificationDate <= LocalDateTime.now());
  }

  @override
  bool get tooFewAvailable => refillLimit != null ? amount <= refillLimit : false;

  Product clone() {
    return Product(id: id, ean: ean, group: group, description: description, charges: charges, home: home, refillLimit: refillLimit, unit: unit, modelChanges: modelChanges);
  }

  bool isValid() {
    return description != null && description != "";
  }

   bool operator ==(other) {
    return ean == other.ean && description == other.description && refillLimit == other.refillLimit && group == other.group;
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
      modifications.add(Modification(fieldName: "unit", from: describeEnum(unit), to: describeEnum(group.unit)));
    }

    return modifications;
  }
}
