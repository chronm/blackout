import 'package:Blackout/di/di.dart';
import 'package:Blackout/features/blackout/blackout_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_is_emulator/flutter_is_emulator.dart';
import 'package:get_it/get_it.dart';
import 'package:time_machine/time_machine.dart';

GetIt sl = GetIt.instance;
bool isEmulator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isEmulator = await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator;
  await TimeMachine.initialize({
    'rootBundle': rootBundle,
  });
  await prepareMain();

  runApp(BlackoutApp());
}