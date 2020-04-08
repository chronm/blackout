import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';

class Category extends Displayable {
  String id;
  String name;
  String pluralName;
  Period warnInterval;
  List<Product> products = <Product>[];
  Home home;
  double refillLimit;

  double get amount => products.map((p) => p.amount).reduce((a, b) => a + b);

  String get scaledAmount => unit.toScientific(amount).toString();

  @override
  String get title => amount > 1 ? pluralName : name;

  @override
  bool get expiredOrNotification {
    return products.any((product) => product.expiredOrNotification);
  }

  @override
  bool get tooFewAvailable {
    return (amount < refillLimit) || products.any((product) => product.tooFewAvailable);
  }

  Category({this.id, @required this.name, this.pluralName, this.warnInterval, this.refillLimit, @required Unit unit, List<Product> products = const [], @required this.home})
      : products = products,
        super(unit);

  factory Category.fromEntry(CategoryEntry categoryEntry, Home home, {List<Product> products}) {
    return Category(
      id: categoryEntry.id,
      name: categoryEntry.name,
      pluralName: categoryEntry.pluralName,
      refillLimit: categoryEntry.refillLimit,
      unit: Unit.values[categoryEntry.unit],
      warnInterval: periodFromISO8601String(categoryEntry.warnInterval),
      products: products,
      home: home,
    );
  }

  CategoryTableCompanion toCompanion() {
    return CategoryTableCompanion(
      id: Value(id),
      name: Value(name),
      pluralName: Value(pluralName),
      refillLimit: Value(refillLimit),
      warnInterval: Value(warnInterval.toString()),
      homeId: Value(home.id),
      unit: Value(Unit.values.indexOf(unit.unit)),
    );
  }
}
