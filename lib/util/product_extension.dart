import '../models/product.dart';
import 'batch_extension.dart';

extension ProductExtension on Product {
  double get amount => batches.length != 0 ? batches.map((c) => c.amount).reduce((a, b) => a + b) : 0;
}
