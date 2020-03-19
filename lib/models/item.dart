import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
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

  Item({this.id, this.expirationDate, this.notificationDate, @required this.product, this.changes, @required this.home});

  factory Item.fromEntry(ItemEntry entry, Home home, {Product product = null, List<Change> changes = null}) {
    return Item(
      id: entry.id,
      expirationDate: localDateTimeFromDateTime(entry.expirationDate),
      notificationDate: localDateTimeFromDateTime(entry.notificationDate),
      product: product,
      changes: changes,
      home: home,
    );
  }

  ItemTableCompanion toCompanion() {
    return ItemTableCompanion(
      id: Value(id),
      productId: Value(product.id),
      expirationDate: Value(expirationDate.toDateTimeLocal()),
      notificationDate: Value(notificationDate.toDateTimeLocal()),
      homeId: Value(home.id),
    );
  }
}
