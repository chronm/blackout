import 'unit.dart';

abstract class Volume extends Unit {
  static RegExp get regExp => RegExp(r"^(\d*([.,]*\d*))\s*(l|dl|ml)$");
  static List<Unit> get _units => [L(), Dl(), Ml()];
  List<Unit> get units => _units;
  UnitEnum get unitEnum => UnitEnum.weight;
  Unit get si => getSi();
  static Unit getSi() => _units[0];

  Volume(double factor, String symbol) : super(factor, symbol);

  static Unit parseSymbol(String input) {
    var match = regExp.firstMatch(input).group(3);
    return _units.firstWhere((unit) => unit.symbol == match);
  }

  double parseInput(String input) {
    var match = regExp.firstMatch(input).group(1);
    return double.parse(match);
  }
}

class L extends Volume {
  L() : super(1, "l");
}

class Dl extends Volume {
  Dl() : super(0.1, "dl");
}

class Ml extends Volume {
  Ml() : super(0.001, "ml");
}
