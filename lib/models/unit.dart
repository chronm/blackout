import 'package:Blackout/util/double_extension.dart';

BaseUnit baseUnitFromUnit(Unit unit) {
  if (unit == Unit.weight) {
    return Weight.g;
  }
  if (unit == Unit.unitless) {
    return Unitless();
  }
  return null;
}

Type baseUnitTypeFromUnit(Unit unit) {
  switch (unit) {
    case Unit.weight:
      return Weight;
    case Unit.unitless:
      return Unitless;
  }
}

enum Unit {
  weight,
  unitless,
}

class ScaledAmount {
  double amount;
  BaseUnit unit;

  ScaledAmount(this.amount, this.unit);

  String toString() {
    return "${amount.format()} ${unit.symbol}";
  }
}

abstract class BaseUnit {
  String get symbol;

  Unit get unit;

  double toSI(double amount);

  ScaledAmount toScientific(double amount);
}

class Unitless extends BaseUnit {
  String symbol = "";

  Unit get unit => Unit.unitless;

  Unitless();

  ScaledAmount toScientific(double amount) {
    return ScaledAmount(amount, this);
  }

  double toSI(double amount) {
    return amount;
  }
}

class Weight extends BaseUnit {
  double factor;
  Weight previous;
  String symbol;

  Unit get unit => Unit.weight;

  Weight(this.factor, this.previous, this.symbol);

  static Weight t = Weight(1000, kg, "t");
  static Weight kg = Weight(1, g, "kg");
  static Weight g = Weight(0.001, mg, "g");
  static Weight mg = Weight(0.000001, null, "mg");

  ScaledAmount toScientific(double amount) {
    Weight weight = t;
    amount = convertTo(amount, t);
    while (convertTo(_toSI(amount, weight), weight.previous) < 1000) {
      amount = convertTo(_toSI(amount, weight), weight.previous);
      weight = weight.previous;
    }

    return ScaledAmount(amount, weight);
  }

  double convertTo(double amount, Weight to) => amount / to.factor;

  double _toSI(double amount, Weight from) => amount * from.factor;

  double toSI(double amount) => _toSI(amount, this);

  static fromString(String unit) {
    switch (unit) {
      case "t":
        return Weight.t;
      case "kg":
        return Weight.kg;
      case "g":
        return Weight.g;
      case "mg":
        return Weight.mg;
    }
  }
}
