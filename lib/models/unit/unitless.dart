import 'package:Blackout/models/unit/unit.dart';

class Unitless extends Unit {
  Unitless() : super(1, "");

  static RegExp get regExp => RegExp(r"((\d*[.,])*(\d*))");

  @override
  double parseInput(String input) {
    var match = regExp.firstMatch(input).group(1);
    return double.parse(match);
  }

  @override
  UnitEnum get unitEnum => UnitEnum.unitless;

  @override
  List<Unit> get units => [this];

  @override
  Unit get si => this;
}
