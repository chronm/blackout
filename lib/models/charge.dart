import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Charge {
  String id;
  Product product;
  LocalDate expirationDate;
  List<Change> changes = [];
  Home home;
  List<ModelChange> modelChanges = [];

  Charge({this.id, this.expirationDate, @required this.product, this.changes, @required this.home, this.modelChanges});

  Charge clone() {
    return Charge(id: id,
        expirationDate: expirationDate,
        product: product,
        changes: changes,
        home: home,
        modelChanges: modelChanges);
  }

  bool operator ==(other) {
    return expirationDate == other.expirationDate;
  }

  factory Charge.fromEntry(ChargeEntry entry, Home home, {Product product, List<Change> changes, List<ModelChange> modelChanges}) {
    return Charge(
      id: entry.id,
      expirationDate: entry.expirationDate == null ? null : LocalDateFromDateTime(entry.expirationDate),
      product: product,
      changes: changes,
      home: home,
      modelChanges: modelChanges,
    );
  }

  ChargeTableCompanion toCompanion() {
    return ChargeTableCompanion(
      id: Value(id),
      productId: Value(product.id),
      expirationDate: expirationDate == null ? Value.absent() : Value(expirationDate.toDateTimeUnspecified()),
      homeId: Value(home.id),
    );
  }

  List<Modification> getModifications(Charge charge) {
    List<Modification> modifications = [];
    if (expirationDate != charge.expirationDate) {
      String from = expirationDate != null ? expirationDate.toString() : null;
      modifications.add(Modification(fieldName: "expirationDate", from: from, to: charge.expirationDate.toString()));
    }
    return modifications;
  }
}
