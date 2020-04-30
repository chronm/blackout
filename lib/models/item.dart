import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Item {
  String id;
  Product product;
  LocalDateTime expirationDate;
  LocalDateTime notificationDate;
  List<Change> changes = [];
  Home home;

  double get amount => changes.map((c) => c.value).reduce((a, b) => a + b);

  LocalDateTime get expirationOrNotificationDate {
    return expirationDate ?? notificationDate;
  }

  String get scientificAmount {
    if (product.category != null) {
      return UnitConverter.toScientific(Amount(amount, Unit.fromSi(product.category.unit))).toString().trim();
    }
    return UnitConverter.toScientific(Amount(amount, Unit.fromSi(product.unit))).toString().trim();
  }

  Item({this.id, this.expirationDate, this.notificationDate, @required this.product, this.changes, @required this.home});

  factory Item.fromEntry(ItemEntry entry, Home home, {Product product = null, List<Change> changes = null}) {
    return Item(
      id: entry.id,
      expirationDate: entry.expirationDate == null ? null : localDateTimeFromDateTime(entry.expirationDate),
      notificationDate: entry.notificationDate == null ? null : localDateTimeFromDateTime(entry.notificationDate),
      product: product,
      changes: changes,
      home: home,
    );
  }

  ItemTableCompanion toCompanion() {
    return ItemTableCompanion(
      id: Value(id),
      productId: Value(product.id),
      expirationDate: expirationDate == null ? Value.absent() : Value(expirationDate.toDateTimeLocal()),
      notificationDate: notificationDate == null ? Value.absent() : Value(notificationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }

  bool get expiredOrNotification {
    bool isExpired = false;
    if (product.category?.warnInterval != null) {
      isExpired = expirationDate.subtract(product.category.warnInterval) < LocalDateTime.now();
    }

    bool notification = notificationDate != null ? notificationDate <= LocalDateTime.now() : false;

    return isExpired || notification;
  }
}
