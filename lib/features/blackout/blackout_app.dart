import 'package:Blackout/features/blackout/widgets/ask_for_import_database.dart';
import 'package:Blackout/features/blackout/widgets/ask_for_storage_rationale.dart';
import 'package:Blackout/features/blackout/widgets/ask_for_redirect_to_settings.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/generated/l10n_extension.dart';
import 'package:Blackout/features/blackout/bloc/blackout_bloc.dart';
import 'package:flutter/material.dart' show Brightness, BuildContext, Colors, Container, Key, Locale, MaterialApp, Navigator, State, StatefulWidget, ThemeData, Widget, WidgetsBinding, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class BlackoutApp extends StatefulWidget {
  const BlackoutApp({Key key}): super(key: key);

  @override
  _BlackoutAppState createState() => _BlackoutAppState();
}

class _BlackoutAppState extends State<BlackoutApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<BlackoutBloc>().add(InitializeApp());
    });
  }

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
      home: BlocListener<BlackoutBloc, BlackoutState>(
        bloc: sl<BlackoutBloc>(),
        listener: (context, state) async {
          switch (state.runtimeType) {
            case AskForStorageRationale:
              await showDialog<bool>(
                context: context,
                builder: (_) => const AskForStorageRationaleDialog(),
              );
              sl<BlackoutBloc>().add(CheckPermissions());
              break;
            case AskForRedirectToSettings:
              bool forward = await showDialog<bool>(
                context: context,
                builder: (_) => const AskForRedirectToSettingsDialog(),
              );
              if (forward) await openAppSettings();
              sl<BlackoutBloc>().add(EndApp());
              break;
            case AskForImportDatabase:
              bool import = await showDialog<bool>(
                context: context,
                builder: (_) => const AskForImportDatabaseDialog(),
              );
              import ? sl<BlackoutBloc>().add(ImportDatabase()) : sl<BlackoutBloc>().add(DropDatabaseAndSetup());
              break;
            case GoToSetup:
              Navigator.pushReplacement(context, RouteBuilder.build(Routes.SetupRoute));
              break;
            case GoToHome:
              Navigator.pushReplacement(context, RouteBuilder.build(Routes.HomeRoute));
              break;
            case ShowChangelog:
              Navigator.push(context, RouteBuilder.build(Routes.Changelog));
              break;
          }
        },
        child: Container(),
      ),
    );
  }
}
