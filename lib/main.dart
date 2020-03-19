import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/di/di.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/generated/l10n_extension.dart';
import 'package:Blackout/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        toggleableActiveColor: Colors.limeAccent,
        accentColor: Colors.limeAccent,
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
      listener: (context, state) {},
      child: HomeScreen(),
    );
  }
}
