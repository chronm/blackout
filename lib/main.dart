import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/di/di.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/generated/l10n_extension.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_is_emulator/flutter_is_emulator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:time_machine/time_machine.dart';

GetIt sl = GetIt.instance;
bool isEmulator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator.then((value) => isEmulator = value);
  await TimeMachine.initialize({
    'rootBundle': rootBundle,
  });
  await prepareDi();
  runApp(BlackoutApp());
}

class BlackoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blackout",
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: S.delegate.resolution(fallback: Locale("en", "")),
      theme: ThemeData(
        brightness: Brightness.dark,
        toggleableActiveColor: Colors.redAccent,
        accentColor: Colors.redAccent,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  final MainBloc _bloc = sl<MainBloc>();

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._bloc.add(InitializeAppEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      bloc: widget._bloc,
      listener: (context, state) {
        if (state is GoToSetup) {
          Navigator.pushReplacement(context, RouteBuilder.build(Routes.setup));
        }
      },
      child: HomeScreen(),
    );
  }
}
