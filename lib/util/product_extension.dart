import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/charge_extension.dart';

extension ProductExtension on Product {
  double get amount => charges.length != 0 ? charges.map((c) => c.amount).reduce((a, b) => a + b) : 0;
}
