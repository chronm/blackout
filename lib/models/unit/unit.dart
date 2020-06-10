import 'package:Blackout/models/unit/unitless.dart';
import 'package:Blackout/models/unit/weight.dart';
import 'package:Blackout/util/double_extension.dart';

enum UnitEnum {
  weight,
  unitless,
}

class Amount {
  double value;
  Unit unit;

  Amount(this.value, this.unit);

  Amount.fromSi(double value, UnitEnum unitEnum) {
    this.unit = Unit.fromSi(unitEnum);
    this.value = value;
  }

  Amount.fromInput(String input, UnitEnum unitEnum) {
    this.unit = Unit.fromInput(input, unitEnum);
    this.value = unit.parseInput(input);
  }

  String toString() {
    return (value != null ? "${value.format()} ${unit.symbol}" : "").trim();
  }
}

abstract class Unit {
  UnitEnum get unitEnum;

  Unit get si;

  List<Unit> get units;

  double factor;
  String symbol;

  Unit(this.factor, this.symbol);

  double parseInput(String input);

  static Unit fromSi(UnitEnum unitEnum) {
    switch (unitEnum) {
      case UnitEnum.weight:
        return Weight.SI;
      case UnitEnum.unitless:
        return Unitless();
    }
    return null;
  }

  static Unit fromInput(String input, UnitEnum unitEnum) {
    switch (unitEnum) {
      case UnitEnum.weight:
        return Weight.parseSymbol(input);
      case UnitEnum.unitless:
        return Unitless();
    }
    return null;
  }
}

class UnitConverter {
  static Amount toSi(Amount amount) {
    double value = amount.value * amount.unit.factor;
    return Amount(value, amount.unit.si);
  }

  static double _toSi(double value, Unit from) => toSi(Amount(value, from)).value;

  static double _convertTo(double amount, Unit to) => amount / to.factor;

  static Amount toScientific(Amount amount) {
    if (amount.value == 0) return amount;
    List<Unit> units = amount.unit.units;
    if (units.length == 1) {
      return amount;
    }
    double value = _convertTo(amount.value, units[0]);
    int i = 0;
    while (i < amount.unit.units.length && _convertTo(_toSi(value, units[i]), units[i + 1]) < 1000) {
      value = _convertTo(_toSi(value, units[i]), units[i + 1]);
      i++;
    }

    return Amount(value, units[i]);
  }
}
