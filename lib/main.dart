import 'dart:core';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:time_machine/time_machine.dart';

import 'di/di.dart';
import 'features/blackout/blackout_app.dart';

enum DistributionStore {
  fdroid,
  amazon,
  none
}

GetIt sl = GetIt.instance;
bool emulator;
DistributionStore store;

Future<void> isEmulator() async {
  if (Platform.isAndroid) {
    emulator = !(await DeviceInfoPlugin().androidInfo).isPhysicalDevice;
  } else if (Platform.isIOS) {
    emulator = !(await DeviceInfoPlugin().iosInfo).isPhysicalDevice;
  }
  emulator = false;
}

Future<void> getStore() async {
  var rawDistributionStore = (await rootBundle.loadString('assets/distribution_store')).replaceAll("\n", "");
  store = DistributionStore.values.firstWhere((element) => element.toString() == "DistributionStore.$rawDistributionStore");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await isEmulator();
  await getStore();
  await TimeMachine.initialize({
    'rootBundle': rootBundle,
  });
  await prepareMain();

  runApp(BlackoutApp());
}
