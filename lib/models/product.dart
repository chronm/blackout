import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:moor/moor.dart';

class Product extends Displayable {
  String id;
  String ean;
  Category category;
  String description;
  List<Item> items = [];
  Home home;

  double get amount => items.map((i) => i.amount).reduce((a, b) => a + b);

  Product({this.id, this.ean, @required this.description, this.category, this.items, @required this.home});

  factory Product.fromEntry(ProductEntry entry, Home home, {Category category, List<Item> items}) {
    return Product(
      id: entry.id,
      ean: entry.ean,
      description: entry.description,
      category: category,
      items: items,
      home: home,
    );
  }

  ProductTableCompanion toCompanion() {
    return ProductTableCompanion(
      id: Value(id),
      ean: Value(ean),
      categoryId: category != null ? Value(category.id) : Value(null),
      description: Value(description),
      homeId: Value(home.id),
    );
  }

  @override
  String get title => description;
}
