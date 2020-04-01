import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

enum ChangelogModification { create, delete }

class DatabaseChangelog {
  String id;
  User user;
  LocalDateTime modificationDate;
  String categoryId;
  String productId;
  String itemId;
  ChangelogModification modification;
  Home home;

  DatabaseChangelog({this.id, @required this.user, @required this.modificationDate, @required this.modification, @required this.home, String categoryId, String productId, String itemId})
      : assert((categoryId != null && productId == null && itemId == null) || (categoryId == null && productId != null && itemId == null) || (categoryId == null && productId == null && itemId != null)),
        this.categoryId = categoryId,
        this.productId = productId,
        this.itemId = itemId;

  factory DatabaseChangelog.fromEntry(DatabaseChangelogEntry entry, User user, Home home) {
    return DatabaseChangelog(
      id: entry.id,
      user: user,
      modificationDate: localDateTimeFromDateTime(entry.modificationDate),
      modification: ChangelogModification.values[entry.direction],
      categoryId: entry.categoryId,
      productId: entry.productId,
      itemId: entry.itemId,
      home: home,
    );
  }

  DatabaseChangelogTableCompanion toCompanion() {
    return DatabaseChangelogTableCompanion(
      id: Value(id),
      userId: Value(user.id),
      direction: Value(ChangelogModification.values.indexOf(modification)),
      categoryId: Value(categoryId),
      productId: Value(productId),
      itemId: Value(itemId),
      modificationDate: Value(modificationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }
}
