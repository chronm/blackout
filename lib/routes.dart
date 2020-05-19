import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/ui/group_details/group_details_screen.dart';
import 'package:Blackout/ui/group_overview/group_overview_screen.dart';
import 'package:Blackout/ui/charge_details/charge_details_screen.dart';
import 'package:Blackout/ui/charge_overview/charge_overview_screen.dart';
import 'package:Blackout/ui/home/home_screen.dart';
import 'package:Blackout/ui/product_details/product_details_screen.dart';
import 'package:Blackout/ui/product_overview/product_overview_screen.dart';
import 'package:Blackout/ui/setup/setup_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:super_enum/super_enum.dart';

import 'models/group.dart';

part 'routes.g.dart';

class RouteBuilder {
  RouteBuilder._();

  static Routes currentRoute;

  static PageRouteBuilder build(Routes route) {
    currentRoute = route;
    return route.when(
      homeRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      setupRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SetupScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      groupOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GroupOverviewScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      groupDetailsRoute: (route) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GroupDetailsScreen(route.group, route.changes),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      productOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProductOverviewScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      productDetailsRoute: (route) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProductDetailsScreen(route.product, route.changes, route.groups),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      chargeOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChargeOverviewScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      chargeDetailsRoute: (route) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChargeDetailsScreen(route.charge),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
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
  GroupOverviewRoute,
  @Data(fields: [
    DataField<Group>('group'),
    DataField<List<ModelChange>>("changes"),
  ])
  GroupDetailsRoute,
  @object
  ProductOverviewRoute,
  @Data(fields: [
    DataField<Product>('product'),
    DataField<List<ModelChange>>("changes"),
    DataField<List<Group>>("groups"),
  ])
  ProductDetailsRoute,
  @object
  ChargeOverviewRoute,
  @Data(fields: [
    DataField<Charge>('charge'),
  ])
  ChargeDetailsRoute,
}
