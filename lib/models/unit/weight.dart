import 'unit.dart';

abstract class Weight extends Unit {
  static RegExp get regExp => RegExp(r"^(\d*([.,]*\d*))\s*(t|kg|g|mg)$");
  static List<Unit> get _units => [T(), Kg(), G(), Mg()];
  List<Unit> get units => _units;
  UnitEnum get unitEnum => UnitEnum.weight;
  Unit get si => getSi();
  static Unit getSi() => _units[1];

  Weight(double factor, String symbol) : super(factor, symbol);

  static Unit parseSymbol(String input) {
    var match = regExp.firstMatch(input).group(3);
    return _units.firstWhere((unit) => unit.symbol == match);
  }

  double parseInput(String input) {
    var match = regExp.firstMatch(input).group(1);
    return double.parse(match);
  }
}

class T extends Weight {
  T() : super(1000, "t");
}

class Kg extends Weight {
  Kg() : super(1, "kg");
}

class G extends Weight {
  G() : super(0.001, "g");
}

class Mg extends Weight {
  Mg() : super(0.000001, "mg");
}
