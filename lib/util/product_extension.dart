import '../models/product.dart';
import 'charge_extension.dart';

extension ProductExtension on Product {
  double get amount => charges.length != 0 ? charges.map((c) => c.amount).reduce((a, b) => a + b) : 0;
}
