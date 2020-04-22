// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Routes extends Equatable {
  const Routes(this._type);

  factory Routes.homeRoute() = HomeRoute;

  factory Routes.setupRoute() = SetupRoute;

  factory Routes.categoryOverviewRoute() = CategoryOverviewRoute;

  factory Routes.categoryDetailsRoute(
      {@required Category category,
      @required List<ModelChange> changes}) = CategoryDetailsRoute;

  factory Routes.productRoute() = ProductRoute;

  factory Routes.itemRoute() = ItemRoute;

  final _Routes _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required
          FutureOr<R> Function(HomeRoute) homeRoute,
      @required
          FutureOr<R> Function(SetupRoute) setupRoute,
      @required
          FutureOr<R> Function(CategoryOverviewRoute) categoryOverviewRoute,
      @required
          FutureOr<R> Function(CategoryDetailsRoute) categoryDetailsRoute,
      @required
          FutureOr<R> Function(ProductRoute) productRoute,
      @required
          FutureOr<R> Function(ItemRoute) itemRoute}) {
    assert(() {
      if (homeRoute == null ||
          setupRoute == null ||
          categoryOverviewRoute == null ||
          categoryDetailsRoute == null ||
          productRoute == null ||
          itemRoute == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Routes.HomeRoute:
        return homeRoute(this as HomeRoute);
      case _Routes.SetupRoute:
        return setupRoute(this as SetupRoute);
      case _Routes.CategoryOverviewRoute:
        return categoryOverviewRoute(this as CategoryOverviewRoute);
      case _Routes.CategoryDetailsRoute:
        return categoryDetailsRoute(this as CategoryDetailsRoute);
      case _Routes.ProductRoute:
        return productRoute(this as ProductRoute);
      case _Routes.ItemRoute:
        return itemRoute(this as ItemRoute);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(HomeRoute) homeRoute,
      FutureOr<R> Function(SetupRoute) setupRoute,
      FutureOr<R> Function(CategoryOverviewRoute) categoryOverviewRoute,
      FutureOr<R> Function(CategoryDetailsRoute) categoryDetailsRoute,
      FutureOr<R> Function(ProductRoute) productRoute,
      FutureOr<R> Function(ItemRoute) itemRoute,
      @required FutureOr<R> Function(Routes) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Routes.HomeRoute:
        if (homeRoute == null) break;
        return homeRoute(this as HomeRoute);
      case _Routes.SetupRoute:
        if (setupRoute == null) break;
        return setupRoute(this as SetupRoute);
      case _Routes.CategoryOverviewRoute:
        if (categoryOverviewRoute == null) break;
        return categoryOverviewRoute(this as CategoryOverviewRoute);
      case _Routes.CategoryDetailsRoute:
        if (categoryDetailsRoute == null) break;
        return categoryDetailsRoute(this as CategoryDetailsRoute);
      case _Routes.ProductRoute:
        if (productRoute == null) break;
        return productRoute(this as ProductRoute);
      case _Routes.ItemRoute:
        if (itemRoute == null) break;
        return itemRoute(this as ItemRoute);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(HomeRoute) homeRoute,
      FutureOr<void> Function(SetupRoute) setupRoute,
      FutureOr<void> Function(CategoryOverviewRoute) categoryOverviewRoute,
      FutureOr<void> Function(CategoryDetailsRoute) categoryDetailsRoute,
      FutureOr<void> Function(ProductRoute) productRoute,
      FutureOr<void> Function(ItemRoute) itemRoute}) {
    assert(() {
      if (homeRoute == null &&
          setupRoute == null &&
          categoryOverviewRoute == null &&
          categoryDetailsRoute == null &&
          productRoute == null &&
          itemRoute == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Routes.HomeRoute:
        if (homeRoute == null) break;
        return homeRoute(this as HomeRoute);
      case _Routes.SetupRoute:
        if (setupRoute == null) break;
        return setupRoute(this as SetupRoute);
      case _Routes.CategoryOverviewRoute:
        if (categoryOverviewRoute == null) break;
        return categoryOverviewRoute(this as CategoryOverviewRoute);
      case _Routes.CategoryDetailsRoute:
        if (categoryDetailsRoute == null) break;
        return categoryDetailsRoute(this as CategoryDetailsRoute);
      case _Routes.ProductRoute:
        if (productRoute == null) break;
        return productRoute(this as ProductRoute);
      case _Routes.ItemRoute:
        if (itemRoute == null) break;
        return itemRoute(this as ItemRoute);
    }
  }

  @override
  List get props => const [];
}

@immutable
class HomeRoute extends Routes {
  const HomeRoute._() : super(_Routes.HomeRoute);

  factory HomeRoute() {
    _instance ??= HomeRoute._();
    return _instance;
  }

  static HomeRoute _instance;
}

@immutable
class SetupRoute extends Routes {
  const SetupRoute._() : super(_Routes.SetupRoute);

  factory SetupRoute() {
    _instance ??= SetupRoute._();
    return _instance;
  }

  static SetupRoute _instance;
}

@immutable
class CategoryOverviewRoute extends Routes {
  const CategoryOverviewRoute._() : super(_Routes.CategoryOverviewRoute);

  factory CategoryOverviewRoute() {
    _instance ??= CategoryOverviewRoute._();
    return _instance;
  }

  static CategoryOverviewRoute _instance;
}

@immutable
class CategoryDetailsRoute extends Routes {
  const CategoryDetailsRoute({@required this.category, @required this.changes})
      : super(_Routes.CategoryDetailsRoute);

  final Category category;

  final List<ModelChange> changes;

  @override
  String toString() =>
      'CategoryDetailsRoute(category:${this.category},changes:${this.changes})';
  @override
  List get props => [category, changes];
}

@immutable
class ProductRoute extends Routes {
  const ProductRoute._() : super(_Routes.ProductRoute);

  factory ProductRoute() {
    _instance ??= ProductRoute._();
    return _instance;
  }

  static ProductRoute _instance;
}

@immutable
class ItemRoute extends Routes {
  const ItemRoute._() : super(_Routes.ItemRoute);

  factory ItemRoute() {
    _instance ??= ItemRoute._();
    return _instance;
  }

  static ItemRoute _instance;
}
