import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/ui/category_details/category_details_screen.dart';
import 'package:Blackout/ui/category_overview/category_overview_screen.dart';
import 'package:Blackout/ui/home/home_screen.dart';
import 'package:Blackout/ui/setup/setup_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:super_enum/super_enum.dart';

import 'models/category.dart';

part 'routes.g.dart';

class RouteBuilder {
  RouteBuilder._();

  static Routes currentRoute;

  static PageRouteBuilder build(Routes route) {
    currentRoute = route;
    return route.when(
      homeRoute: (_) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      setupRoute: (_) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => SetupScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      categoryOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => CategoryOverviewScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      categoryDetailsRoute: (route) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => CategoryDetailsScreen(route.category, route.changes),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      productRoute: (_) {},
      itemRoute: (_) {},
    );
  }
}

@superEnum
enum _Routes {
  @object
  HomeRoute,
  @object
  SetupRoute,
  @object
  CategoryOverviewRoute,
  @Data(fields: [
    DataField<Category>('category'),
    DataField<List<ModelChange>>("changes"),
  ])
  CategoryDetailsRoute,
  @object
  ProductRoute,
  @object
  ItemRoute,
}
