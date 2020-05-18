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

  factory Routes.productOverviewRoute() = ProductOverviewRoute;

  factory Routes.productDetailsRoute(
      {@required Product product,
      @required List<ModelChange> changes,
      @required List<Category> categories}) = ProductDetailsRoute;

  factory Routes.chargeOverviewRoute() = ChargeOverviewRoute;

  final _Routes _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(HomeRoute) homeRoute,
      @required R Function(SetupRoute) setupRoute,
      @required R Function(CategoryOverviewRoute) categoryOverviewRoute,
      @required R Function(CategoryDetailsRoute) categoryDetailsRoute,
      @required R Function(ProductOverviewRoute) productOverviewRoute,
      @required R Function(ProductDetailsRoute) productDetailsRoute,
      @required R Function(ChargeOverviewRoute) chargeOverviewRoute}) {
    assert(() {
      if (homeRoute == null ||
          setupRoute == null ||
          categoryOverviewRoute == null ||
          categoryDetailsRoute == null ||
          productOverviewRoute == null ||
          productDetailsRoute == null ||
          chargeOverviewRoute == null) {
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
      case _Routes.ProductOverviewRoute:
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        return chargeOverviewRoute(this as ChargeOverviewRoute);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required
          FutureOr<R> Function(HomeRoute) homeRoute,
      @required
          FutureOr<R> Function(SetupRoute) setupRoute,
      @required
          FutureOr<R> Function(CategoryOverviewRoute) categoryOverviewRoute,
      @required
          FutureOr<R> Function(CategoryDetailsRoute) categoryDetailsRoute,
      @required
          FutureOr<R> Function(ProductOverviewRoute) productOverviewRoute,
      @required
          FutureOr<R> Function(ProductDetailsRoute) productDetailsRoute,
      @required
          FutureOr<R> Function(ChargeOverviewRoute) chargeOverviewRoute}) {
    assert(() {
      if (homeRoute == null ||
          setupRoute == null ||
          categoryOverviewRoute == null ||
          categoryDetailsRoute == null ||
          productOverviewRoute == null ||
          productDetailsRoute == null ||
          chargeOverviewRoute == null) {
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
      case _Routes.ProductOverviewRoute:
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        return chargeOverviewRoute(this as ChargeOverviewRoute);
    }
  }

  R whenOrElse<R>(
      {R Function(HomeRoute) homeRoute,
      R Function(SetupRoute) setupRoute,
      R Function(CategoryOverviewRoute) categoryOverviewRoute,
      R Function(CategoryDetailsRoute) categoryDetailsRoute,
      R Function(ProductOverviewRoute) productOverviewRoute,
      R Function(ProductDetailsRoute) productDetailsRoute,
      R Function(ChargeOverviewRoute) chargeOverviewRoute,
      @required R Function(Routes) orElse}) {
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
      case _Routes.ProductOverviewRoute:
        if (productOverviewRoute == null) break;
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        if (productDetailsRoute == null) break;
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        if (chargeOverviewRoute == null) break;
        return chargeOverviewRoute(this as ChargeOverviewRoute);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(HomeRoute) homeRoute,
      FutureOr<R> Function(SetupRoute) setupRoute,
      FutureOr<R> Function(CategoryOverviewRoute) categoryOverviewRoute,
      FutureOr<R> Function(CategoryDetailsRoute) categoryDetailsRoute,
      FutureOr<R> Function(ProductOverviewRoute) productOverviewRoute,
      FutureOr<R> Function(ProductDetailsRoute) productDetailsRoute,
      FutureOr<R> Function(ChargeOverviewRoute) chargeOverviewRoute,
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
      case _Routes.ProductOverviewRoute:
        if (productOverviewRoute == null) break;
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        if (productDetailsRoute == null) break;
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        if (chargeOverviewRoute == null) break;
        return chargeOverviewRoute(this as ChargeOverviewRoute);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(HomeRoute) homeRoute,
      FutureOr<void> Function(SetupRoute) setupRoute,
      FutureOr<void> Function(CategoryOverviewRoute) categoryOverviewRoute,
      FutureOr<void> Function(CategoryDetailsRoute) categoryDetailsRoute,
      FutureOr<void> Function(ProductOverviewRoute) productOverviewRoute,
      FutureOr<void> Function(ProductDetailsRoute) productDetailsRoute,
      FutureOr<void> Function(ChargeOverviewRoute) chargeOverviewRoute}) {
    assert(() {
      if (homeRoute == null &&
          setupRoute == null &&
          categoryOverviewRoute == null &&
          categoryDetailsRoute == null &&
          productOverviewRoute == null &&
          productDetailsRoute == null &&
          chargeOverviewRoute == null) {
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
      case _Routes.ProductOverviewRoute:
        if (productOverviewRoute == null) break;
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        if (productDetailsRoute == null) break;
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        if (chargeOverviewRoute == null) break;
        return chargeOverviewRoute(this as ChargeOverviewRoute);
    }
  }

  @override
  List get props => const [];
}

@immutable
class HomeRoute extends Routes {
  const HomeRoute._() : super(_Routes.HomeRoute);

  factory HomeRoute() {
    _instance ??= const HomeRoute._();
    return _instance;
  }

  static HomeRoute _instance;
}

@immutable
class SetupRoute extends Routes {
  const SetupRoute._() : super(_Routes.SetupRoute);

  factory SetupRoute() {
    _instance ??= const SetupRoute._();
    return _instance;
  }

  static SetupRoute _instance;
}

@immutable
class CategoryOverviewRoute extends Routes {
  const CategoryOverviewRoute._() : super(_Routes.CategoryOverviewRoute);

  factory CategoryOverviewRoute() {
    _instance ??= const CategoryOverviewRoute._();
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
class ProductOverviewRoute extends Routes {
  const ProductOverviewRoute._() : super(_Routes.ProductOverviewRoute);

  factory ProductOverviewRoute() {
    _instance ??= const ProductOverviewRoute._();
    return _instance;
  }

  static ProductOverviewRoute _instance;
}

@immutable
class ProductDetailsRoute extends Routes {
  const ProductDetailsRoute(
      {@required this.product,
      @required this.changes,
      @required this.categories})
      : super(_Routes.ProductDetailsRoute);

  final Product product;

  final List<ModelChange> changes;

  final List<Category> categories;

  @override
  String toString() =>
      'ProductDetailsRoute(product:${this.product},changes:${this.changes},categories:${this.categories})';
  @override
  List get props => [product, changes, categories];
}

@immutable
class ChargeOverviewRoute extends Routes {
  const ChargeOverviewRoute._() : super(_Routes.ChargeOverviewRoute);

  factory ChargeOverviewRoute() {
    _instance ??= const ChargeOverviewRoute._();
    return _instance;
  }

  static ChargeOverviewRoute _instance;
}
