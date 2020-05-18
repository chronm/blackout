import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:super_enum/super_enum.dart';
import 'package:time_machine/time_machine.dart';

enum ModelChangeType {
  create,
  modify,
}

class ModelChange {
  String id;
  User user;
  LocalDateTime modificationDate;
  String categoryId;
  String productId;
  String itemId;
  ModelChangeType modification;
  Home home;
  List<Modification> modifications;

  ModelChange({
    this.id,
    @required this.user,
    @required this.modificationDate,
    @required this.modification,
    @required this.home,
    String categoryId,
    String productId,
    String itemId,
    this.modifications,
  })  : assert((categoryId != null && productId == null && itemId == null) || (categoryId == null && productId != null && itemId == null) || (categoryId == null && productId == null && itemId != null)),
        this.categoryId = categoryId,
        this.productId = productId,
        this.itemId = itemId;

  factory ModelChange.fromEntry(ModelChangeEntry entry, User user, Home home, List<Modification> modifications) {
    return ModelChange(
      id: entry.id,
      user: user,
      modificationDate: localDateTimeFromDateTime(entry.modificationDate),
      modification: ModelChangeType.values[entry.direction],
      categoryId: entry.categoryId,
      productId: entry.productId,
      itemId: entry.itemId,
      home: home,
      modifications: modifications,
    );
  }

  ModelChangeTableCompanion toCompanion() {
    return ModelChangeTableCompanion(
      id: Value(id),
      userId: Value(user.id),
      direction: Value(ModelChangeType.values.indexOf(modification)),
      categoryId: Value(categoryId),
      productId: Value(productId),
      itemId: Value(itemId),
      modificationDate: Value(modificationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }

  String toLocalizedString(BuildContext context) {
    switch (modification) {
      case ModelChangeType.create:
        return S.of(context).created;
      case ModelChangeType.modify:
        return modifications.map((m) {
          if (m.from != "" && (m.to == "" || m.to == null)) {
            return S.of(context).disabledField(m.fieldName, m.from);
          }
          if ((m.from == "" || m.from == null) && m.to != "") {
            return S.of(context).enabledField(m.fieldName, m.to);
          }
          return S.of(context).modifiedField(m.fieldName, m.from, m.to);
        }).join("\n");
    }
    return "";
  }
}
