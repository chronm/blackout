import 'package:flutter/cupertino.dart';

import '../util/batch_extension.dart';

abstract class HomeListable {
  String get title;

  String get scientificAmount;

  String get subtitleBestBeforeNotification;

  bool get expired;

  bool get warn;

  bool get tooFewAvailable;

  String get id;

  String buildStatus(BuildContext context);

  BatchStatus get status;
}
