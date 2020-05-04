import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/detailable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/listable.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/storageable.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Item extends Listable implements Detailable<Item>, Storageable<Item, ItemTableCompanion> {
  String id;
  Product product;
  LocalDateTime expirationDate;
  LocalDateTime notificationDate;
  List<Change> changes = [];
  Home home;

  Item({this.id, this.expirationDate, this.notificationDate, @required this.product, this.changes, @required this.home});

  @override
  String get title => scientificAmount;

  @override
  UnitEnum get unit => product.unit;

  @override
  double get amount => changes.map((c) => c.value).reduce((a, b) => a + b);

  @override
  String get scientificAmount {
    if (product.category != null) {
      return UnitConverter.toScientific(Amount(amount, Unit.fromSi(product.category.unit))).toString().trim();
    }
    return UnitConverter.toScientific(Amount(amount, Unit.fromSi(product.unit))).toString().trim();
  }

  bool get expiredOrNotification {
    bool isExpired = false;
    if (product.category?.warnInterval != null) {
      isExpired = expirationDate.subtract(product.category.warnInterval) < LocalDateTime.now();
    }

    bool notification = notificationDate != null ? notificationDate <= LocalDateTime.now() : false;

    return isExpired || notification;
  }

  @override
  bool get tooFewAvailable => false;

  LocalDateTime get expirationOrNotificationDate {
    return expirationDate ?? notificationDate;
  }

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

  @override
  ItemTableCompanion toCompanion() {
    return ItemTableCompanion(
      id: Value(id),
      productId: Value(product.id),
      expirationDate: expirationDate == null ? Value.absent() : Value(expirationDate.toDateTimeLocal()),
      notificationDate: notificationDate == null ? Value.absent() : Value(notificationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }

  @override
  Item clone() {
    // TODO: implement clone
    throw UnimplementedError();
  }

  @override
  List<Modification> getModifications(Item from) {
    // TODO: implement getModifications
    throw UnimplementedError();
  }

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }
}
