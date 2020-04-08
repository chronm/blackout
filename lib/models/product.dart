import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Product extends Displayable {
  String id;
  String ean;
  Category category;
  String description;
  List<Item> items = [];
  Home home;
  double refillLimit;

  double get amount => items.map((i) => i.amount).reduce((a, b) => a + b);

  Product({this.id, this.ean, @required this.description, this.category, this.items, this.refillLimit, @required this.home});

  factory Product.fromEntry(ProductEntry entry, Home home, {Category category, List<Item> items}) {
    return Product(
      id: entry.id,
      ean: entry.ean,
      description: entry.description,
      refillLimit: entry.refillLimit,
      category: category,
      items: items,
      home: home,
    );
  }

  ProductTableCompanion toCompanion() {
    return ProductTableCompanion(
      id: Value(id),
      ean: Value(ean),
      description: Value(description),
      refillLimit: Value(refillLimit),
      categoryId: category != null ? Value(category.id) : Value(null),
      homeId: Value(home.id),
    );
  }

  @override
  String get title => description;

  @override
  bool get expiredOrNotification {
    return items.where((item) => item.notificationDate != null).any((item) => item.notificationDate <= LocalDateTime.now());
  }

  @override
  bool get tooFewAvailable {
    return amount <= refillLimit;
  }
}
