import 'dart:io';

import 'package:Blackout/di/di.dart';
import 'package:Blackout/features/blackout/blackout_app.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:time_machine/time_machine.dart';

GetIt sl = GetIt.instance;
bool emulator;

Future<bool> isEmulator() async {
  if (Platform.isAndroid) {
    return !(await DeviceInfoPlugin().androidInfo).isPhysicalDevice;
  } else if (Platform.isIOS) {
    return !(await DeviceInfoPlugin().iosInfo).isPhysicalDevice;
  }
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  emulator = await isEmulator();
  await TimeMachine.initialize({
    'rootBundle': rootBundle,
  });
  await prepareMain();

  runApp(BlackoutApp());
}
