import 'package:Blackout/ui/charge_overview/charge_overview_screen.dart';
import 'package:Blackout/ui/group_overview/group_overview_screen.dart';
import 'package:Blackout/ui/home/home_screen.dart';
import 'package:Blackout/ui/product_overview/product_overview_screen.dart';
import 'package:Blackout/ui/setup/setup_screen.dart';
import 'package:flutter/material.dart';

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
}
