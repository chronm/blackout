import 'package:Blackout/models/unit/unit.dart';

abstract class HomeListable {
  String get title;

  String get subtitle;

  bool get expiredOrNotification;

  bool get tooFewAvailable;

  String get id;
}
