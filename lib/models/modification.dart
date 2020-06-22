import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

class Modification {
  String id;
  String fieldName;
  String from;
  String to;
  ModelChange modelChange;

  Modification({this.id, @required this.fieldName, @required this.from, @required this.to, this.modelChange});

  factory Modification.fromEntry(ModificationEntry entry) {
    return Modification(
      id: entry.id,
      fieldName: entry.fieldName,
      from: entry.from,
      to: entry.to,
    );
  }

  ModificationTableCompanion toCompanion() {
    return ModificationTableCompanion(
      id: Value(Uuid().v4()),
      fieldName: Value(fieldName),
      from: Value(from),
      to: Value(to),
      modelChangeId: Value(modelChange.id),
    );
  }
}
