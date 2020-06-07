import 'package:Blackout/util/charge_extension.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeListable {
  String get title;

  String get scientificAmount;

  String get subtitleBestBeforeNotification;

  bool get expired;

  bool get warn;

  bool get tooFewAvailable;

  String get id;

  String buildStatus(BuildContext context);

  ChargeStatus get status;
}
