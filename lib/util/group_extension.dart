import '../models/group.dart';
import 'product_extension.dart';

extension GroupExtension on Group {
  double get amount => products.length != 0
      ? products.map((p) => p.amount).reduce((a, b) => a + b)
      : 0;
}
