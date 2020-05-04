import 'package:Blackout/models/unit/unit.dart';

abstract class Listable {
  String get title;
  double get amount;
  bool get expiredOrNotification;
  bool get tooFewAvailable;
  UnitEnum get unit;
  String get scientificAmount;
}
