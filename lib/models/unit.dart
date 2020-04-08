import 'package:Blackout/util/double_extension.dart';

BaseUnit baseUnitfromUnit(Unit unit) {
  if (unit == Unit.weight) {
    return Weight.g;
  }
  if (unit == Unit.unitless) {
    return Unitless();
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

  ScaledAmount toScientific(double amount);
}

class Unitless extends BaseUnit {
  String symbol = "";
  Unit get unit => Unit.unitless;

  Unitless();

  ScaledAmount toScientific(double amount) {
    return ScaledAmount(amount, this);
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
    while (convertTo(toSI(amount, weight), weight.previous) < 1000) {
      amount = convertTo(toSI(amount, weight), weight.previous);
      weight = weight.previous;
    }

    return ScaledAmount(amount, weight);
  }

  double convertTo(double amount, Weight to) => amount / to.factor;

  double toSI(double amount, Weight from) => amount * from.factor;

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
