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
  LocalDateTime expirationDate;
  LocalDateTime notificationDate;
  List<Change> changes = [];
  Home home;
  List<ModelChange> modelChanges = [];

  String hierarchy(BuildContext context) {
    List<String> items = [product.hierarchy(context), product.title]..removeWhere((element) => element == null);
    return items.join(" • ");
  }

  Charge({this.id, this.expirationDate, this.notificationDate, @required this.product, this.changes, @required this.home, this.modelChanges});

  String buildTitle(BuildContext context) {
    ModelChange creation = modelChanges.firstWhere((c) => c.modification == ModelChangeType.create);
    String creationDate = creation.modificationDate.prettyPrintShortDifference(context);
    if (expirationDate != null) {
      String expirationDate = this.expirationDate.prettyPrintShortDifference(context);
      if (LocalDateTime.now() >= this.expirationDate) {
        return "${S.of(context).createdAt(creationDate).capitalize()} • ${S.of(context).expired(expirationDate).capitalize()}";
      } else {
        return "${S.of(context).createdAt(creationDate).capitalize()} • ${S.of(context).expires(expirationDate).capitalize()}";
      }
    } else {
      if (notificationDate != null) {
        String notificationDate = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(this.notificationDate.toDateTimeLocal());
        return "${S.of(context).createdAt(creationDate).capitalize()} • ${S.of(context).notify(notificationDate).capitalize()}";
      } else {
        return S.of(context).createdAt(creationDate).capitalize();
      }
    }
  }

  String get subtitle => UnitConverter.toScientific(Amount(amount, Unit.fromSi(product.group != null ? product.group.unit : product.unit))).toString();

  UnitEnum get unit => product.unit;

  double get amount => changes.length != 0 ? changes.map((c) => c.value).reduce((a, b) => a + b) : 0;

  bool get expiredOrNotification {
    bool isExpired = false;
    if (product.group?.warnInterval != null) {
      isExpired = expirationDate.subtract(product.group.warnInterval) < LocalDateTime.now();
    }

    bool notification = notificationDate != null ? notificationDate <= LocalDateTime.now() : false;

    return isExpired || notification;
  }

  LocalDateTime get expirationOrNotificationDate {
    return expirationDate ?? notificationDate;
  }

  Charge clone() {
    return Charge(id: id,
        expirationDate: expirationDate,
        notificationDate: notificationDate,
        product: product,
        changes: changes,
        home: home,
        modelChanges: modelChanges);
  }

  bool operator ==(other) {
    return expirationDate == other.expirationDate && notificationDate == other.notificationDate;
  }

  factory Charge.fromEntry(ChargeEntry entry, Home home, {Product product, List<Change> changes, List<ModelChange> modelChanges}) {
    return Charge(
      id: entry.id,
      expirationDate: entry.expirationDate == null ? null : localDateTimeFromDateTime(entry.expirationDate),
      notificationDate: entry.notificationDate == null ? null : localDateTimeFromDateTime(entry.notificationDate),
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
      expirationDate: expirationDate == null ? Value.absent() : Value(expirationDate.toDateTimeLocal()),
      notificationDate: notificationDate == null ? Value.absent() : Value(notificationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }

  List<Modification> getModifications(Charge charge) {
    List<Modification> modifications = [];
    if (expirationDate != charge.expirationDate) {
      modifications.add(Modification(fieldName: "expirationDate", from: expirationDate.toString(), to: charge.expirationDate.toString()));
    }
    if (notificationDate != charge.notificationDate) {
      modifications.add(Modification(fieldName: "notificationDate", from: notificationDate.toString(), to: charge.notificationDate.toString()));
    }
    return modifications;
  }
}
