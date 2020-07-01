import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

import '../data/database/database.dart';
import '../generated/l10n.dart';
import '../util/time_machine_extension.dart';
import 'home.dart';
import 'modification.dart';
import 'user.dart';

enum ModelChangeType {
  create,
  modify,
  delete,
}

class ModelChange {
  String id;
  User user;
  LocalDate modificationDate;
  String groupId;
  String productId;
  String batchId;
  ModelChangeType modification;
  Home home;
  List<Modification> modifications;

  ModelChange({
    this.id,
    @required this.user,
    @required this.modificationDate,
    @required this.modification,
    @required this.home,
    this.groupId,
    this.productId,
    this.batchId,
    this.modifications,
  }) : assert((groupId != null && productId == null && batchId == null) || (groupId == null && productId != null && batchId == null) || (groupId == null && productId == null && batchId != null));

  factory ModelChange.fromEntry(ModelChangeEntry entry, User user, Home home, List<Modification> modifications) {
    return ModelChange(
      id: entry.id,
      user: user,
      modificationDate: localDateFromDateTime(entry.modificationDate),
      modification: ModelChangeType.values[entry.direction],
      groupId: entry.groupId,
      productId: entry.productId,
      batchId: entry.batchId,
      home: home,
      modifications: modifications,
    );
  }

  ModelChangeTableCompanion toCompanion() {
    return ModelChangeTableCompanion(
      id: Value(id),
      userId: Value(user.id),
      direction: Value(ModelChangeType.values.indexOf(modification)),
      groupId: Value(groupId),
      productId: Value(productId),
      batchId: Value(batchId),
      modificationDate: Value(modificationDate.toDateTimeUnspecified()),
      homeId: Value(home.id),
    );
  }

  String toLocalizedString(BuildContext context) {
    switch (modification) {
      case ModelChangeType.create:
        return S.of(context).MODEL_CHANGE_CREATED;
      case ModelChangeType.modify:
        return modifications.map((m) {
          if (m.from != "" && (m.to == "" || m.to == null)) {
            return S.of(context).MODEL_CHANGE_FIELD_DISABLED(m.fieldName, m.from);
          }
          if ((m.from == "" || m.from == null) && m.to != "") {
            return S.of(context).MODEL_CHANGE_FIELD_ENABLED(m.fieldName, m.to);
          }
          return S.of(context).MODEL_CHANGE_FIELD_MODIFIED(m.fieldName, m.from, m.to);
        }).join("\n");
      case ModelChangeType.delete:
        return "";
    }
    return "";
  }
}
