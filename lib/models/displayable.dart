import 'package:Blackout/models/unit/unit.dart';

class DisplayableState {
  bool expiredOrNotification;
  bool tooFewAvailable;

  DisplayableState(this.expiredOrNotification, this.tooFewAvailable);
}

abstract class Displayable {
  String get title;
  double get amount;
  bool get expiredOrNotification;
  bool get tooFewAvailable;
  UnitEnum unit;

  String get scientificAmount => UnitConverter.toScientific(Amount(amount, Unit.fromSi(unit))).toString().trim();

  DisplayableState get state => DisplayableState(expiredOrNotification, tooFewAvailable);

  bool isValid();

  Displayable(UnitEnum unit) : unit = unit;
}
