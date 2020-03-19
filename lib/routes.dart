import 'package:Blackout/ui/home/home_screen.dart';
import 'package:Blackout/ui/setup/setup_screen.dart';
import 'package:flutter/material.dart';

typedef PageRouteBuilder PageRouteBuilderBuilder();

class RouteBuilder {
  RouteBuilder._();

  static Routes currentRoute;

  static final routes = <Routes, PageRouteBuilderBuilder>{
    Routes.home: () => PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        ),
    Routes.setup: () => PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => SetupScreen(),
          transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
        )
  };

  static PageRouteBuilder build(Routes route) {
    currentRoute = route;
    return routes[route]();
  }
}

enum Routes {
  home,
  setup,
}
