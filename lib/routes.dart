import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/ui/category_details/category_details_screen.dart';
import 'package:Blackout/ui/category_overview/category_overview_screen.dart';
import 'package:Blackout/ui/home/home_screen.dart';
import 'package:Blackout/ui/product_details/product_details_screen.dart';
import 'package:Blackout/ui/product_overview/product_overview_screen.dart';
import 'package:Blackout/ui/item_overview/item_overview_screen.dart';
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
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      setupRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SetupScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      categoryOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CategoryOverviewScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      categoryDetailsRoute: (route) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CategoryDetailsScreen(route.category, route.changes),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      productOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProductOverviewScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
      productDetailsRoute: (route) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProductDetailsScreen(route.product, route.changes, route.categories),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child)
      ),
      itemOverviewRoute: (_) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ItemOverviewScreen(),
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
  CategoryOverviewRoute,
  @Data(fields: [
    DataField<Category>('category'),
    DataField<List<ModelChange>>("changes"),
  ])
  CategoryDetailsRoute,
  @object
  ProductOverviewRoute,
  @Data(fields: [
    DataField<Product>('product'),
    DataField<List<ModelChange>>("changes"),
    DataField<List<Category>>("categories"),
  ])
  ProductDetailsRoute,
  @object
  ItemOverviewRoute,
}
