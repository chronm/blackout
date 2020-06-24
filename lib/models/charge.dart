import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

import '../data/database/database.dart';
import '../util/time_machine_extension.dart';
import 'change.dart';
import 'model_change.dart';
import 'modification.dart';
import 'product.dart';

class Charge {
  String id;
  Product product;
  LocalDate expirationDate;
  List<Change> changes = [];
  List<ModelChange> modelChanges = [];

  Charge(
      {this.id,
      this.expirationDate,
      @required this.product,
      this.changes,
      this.modelChanges});

  Charge clone() {
    return Charge(
        id: id,
        expirationDate: expirationDate,
        product: product,
        changes: changes,
        modelChanges: modelChanges);
  }

  bool operator ==(dynamic other) {
    return expirationDate == other.expirationDate;
  }

  factory Charge.fromEntry(ChargeEntry entry,
      {Product product, List<Change> changes, List<ModelChange> modelChanges}) {
    return Charge(
      id: entry.id,
      expirationDate: entry.expirationDate == null
          ? null
          : localDateFromDateTime(entry.expirationDate),
      product: product,
      changes: changes,
      modelChanges: modelChanges,
    );
  }

  ChargeTableCompanion toCompanion() {
    return ChargeTableCompanion(
      id: Value(id),
      productId: Value(product.id),
      expirationDate: expirationDate == null
          ? Value.absent()
          : Value(expirationDate.toDateTimeUnspecified()),
    );
  }

  List<Modification> getModifications(Charge charge) {
    var modifications = <Modification>[];
    if (expirationDate != charge.expirationDate) {
      var from = expirationDate != null ? expirationDate.toString() : null;
      modifications.add(Modification(
          fieldName: "expirationDate",
          from: from,
          to: charge.expirationDate.toString()));
    }
    return modifications;
  }

  @override
  int get hashCode => super.hashCode;
}
