import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/features/charge_overview/charge_overview_screen.dart';
import 'package:Blackout/features/group_overview/group_overview_screen.dart';
import 'package:Blackout/features/home/home_screen.dart';
import 'package:Blackout/features/product_overview/product_overview_screen.dart';
import 'package:Blackout/features/settings/settings_screen.dart';
import 'package:Blackout/features/setup/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

class RouteBuilder {
  RouteBuilder._();

  static Routes currentRoute;

  static PageRouteBuilder build(Routes route) {
    currentRoute = route;
    switch (route) {
      case Routes.HomeRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
      case Routes.SetupRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SetupScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
      case Routes.GroupOverviewRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => GroupOverviewScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
      case Routes.ProductOverviewRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ProductOverviewScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
      case Routes.ChargeOverviewRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ChargeOverviewScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
      case Routes.SettingsRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SettingsScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
      case Routes.Changelog:
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
            String locale = S.delegate.isSupported(Localizations.localeOf(context)) ? Localizations.localeOf(context).languageCode : "en";

            return WhatsNewPage.changelog(
              title: Text(S.of(context).CHANGELOG),
              buttonText: Text(S.of(context).CHANGELOG_OKAY),
              path: "documentation/changelog_$locale.md",
              onButtonPressed: () {
                  Navigator.pop(context);
              },
            );
          },
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        );
    }
    return null;
  }
}

enum Routes {
  HomeRoute,
  SetupRoute,
  GroupOverviewRoute,
  ProductOverviewRoute,
  ChargeOverviewRoute,
  SettingsRoute,
  Changelog,
}
