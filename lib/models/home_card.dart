import 'package:flutter/material.dart';

import '../util/batch_extension.dart';

abstract class HomeCard {
  String get title;

  String get scientificAmount;

  bool get expired;

  bool get warn;

  bool get tooFewAvailable;

  String get id;

  String buildStatus(BuildContext context);

  BatchStatus get status;
}
