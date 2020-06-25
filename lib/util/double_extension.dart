import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String format() {
    return NumberFormat.decimalPattern().format(double.parse(toStringAsFixed(2)));
  }
}
