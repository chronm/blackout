import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

import '../data/database/database.dart';
import '../util/batch_extension.dart';
import '../util/time_machine_extension.dart';
import 'change.dart';
import 'model_change.dart';
import 'modification.dart';
import 'product.dart';

class Batch {
  String id;
  Product product;
  LocalDate expirationDate;
  List<Change> changes = [];
  List<ModelChange> modelChanges = [];

  Batch({this.id, this.expirationDate, @required this.product, this.changes, this.modelChanges});

  Batch clone() {
    return Batch(id: id, expirationDate: expirationDate, product: product, changes: changes, modelChanges: modelChanges);
  }

  LocalDate get creationOrExpirationDate {
    return expirationDate ?? creationDate;
  }

  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic other) {
    return expirationDate == other.expirationDate;
  }

  factory Batch.fromEntry(BatchEntry entry, {Product product, List<Change> changes, List<ModelChange> modelChanges}) {
    return Batch(
      id: entry.id,
      expirationDate: entry.expirationDate == null ? null : localDateFromDateTime(entry.expirationDate),
      product: product,
      changes: changes,
      modelChanges: modelChanges,
    );
  }

  BatchTableCompanion toCompanion() {
    return BatchTableCompanion(
      id: Value(id),
      productId: Value(product.id),
      expirationDate: expirationDate == null ? Value.absent() : Value(expirationDate.toDateTimeUnspecified()),
    );
  }

  List<Modification> getModifications(Batch other) {
    var modifications = <Modification>[];
    if (expirationDate != other.expirationDate) {
      var from = expirationDate != null ? expirationDate.toString() : null;
      var to = other.expirationDate != null ? other.expirationDate.toString() : null;
      modifications.add(Modification(fieldName: "expirationDate", from: from, to: to));
    }
    return modifications;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => super.hashCode;
}
