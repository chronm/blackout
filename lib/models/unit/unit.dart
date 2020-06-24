import '../../util/double_extension.dart';
import 'unitless.dart';
import 'weight.dart';

enum UnitEnum {
  weight,
  unitless,
}

class Amount {
  double value;
  Unit unit;

  Amount(this.value, this.unit);

  Amount.fromSi(double value, UnitEnum unitEnum) {
    unit = Unit.fromSi(unitEnum);
    value = value;
  }

  Amount.fromInput(String input, UnitEnum unitEnum) {
    unit = Unit.fromInput(input, unitEnum);
    value = unit.parseInput(input);
  }

  String toString() {
    return (value != null ? "${value.format()} ${unit.symbol}" : "").trim();
  }

  @override
  bool operator ==(dynamic other) {
    return UnitConverter.toScientific(this).value ==
        UnitConverter.toScientific(other).value;
  }

  bool operator <=(dynamic other) {
    return UnitConverter.toScientific(this).value <=
        UnitConverter.toScientific(other).value;
  }

  @override
  int get hashCode => super.hashCode;
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
    var value = amount.value * amount.unit.factor;
    return Amount(value, amount.unit.si);
  }

  static double _toSi(double value, Unit from) =>
      toSi(Amount(value, from)).value;

  static double _convertTo(double amount, Unit to) => amount / to.factor;

  static Amount toScientific(Amount amount) {
    if (amount.value == null) return amount;
    if (amount.value == 0) return amount;
    var units = amount.unit.units;
    if (units.length == 1) {
      return amount;
    }
    var value = _convertTo(amount.value, units[0]);
    var i = 0;
    while (i < amount.unit.units.length &&
        _convertTo(_toSi(value, units[i]), units[i + 1]) < 1000) {
      value = _convertTo(_toSi(value, units[i]), units[i + 1]);
      i++;
    }

    return Amount(value, units[i]);
  }
}
