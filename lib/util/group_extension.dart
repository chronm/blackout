import 'package:Blackout/models/group.dart';
import 'package:Blackout/util/product_extension.dart';

extension GroupExtension on Group {
  double get amount => products.length != 0 ? products.map((p) => p.amount).reduce((a, b) => a + b) : 0;
}