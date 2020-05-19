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

  factory Routes.groupOverviewRoute() = GroupOverviewRoute;

  factory Routes.groupDetailsRoute(
      {@required Group group,
      @required List<ModelChange> changes}) = GroupDetailsRoute;

  factory Routes.productOverviewRoute() = ProductOverviewRoute;

  factory Routes.productDetailsRoute(
      {@required Product product,
      @required List<ModelChange> changes,
      @required List<Group> groups}) = ProductDetailsRoute;

  factory Routes.chargeOverviewRoute() = ChargeOverviewRoute;

  factory Routes.chargeDetailsRoute({@required Charge charge}) =
      ChargeDetailsRoute;

  final _Routes _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(HomeRoute) homeRoute,
      @required R Function(SetupRoute) setupRoute,
      @required R Function(GroupOverviewRoute) groupOverviewRoute,
      @required R Function(GroupDetailsRoute) groupDetailsRoute,
      @required R Function(ProductOverviewRoute) productOverviewRoute,
      @required R Function(ProductDetailsRoute) productDetailsRoute,
      @required R Function(ChargeOverviewRoute) chargeOverviewRoute,
      @required R Function(ChargeDetailsRoute) chargeDetailsRoute}) {
    assert(() {
      if (homeRoute == null ||
          setupRoute == null ||
          groupOverviewRoute == null ||
          groupDetailsRoute == null ||
          productOverviewRoute == null ||
          productDetailsRoute == null ||
          chargeOverviewRoute == null ||
          chargeDetailsRoute == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Routes.HomeRoute:
        return homeRoute(this as HomeRoute);
      case _Routes.SetupRoute:
        return setupRoute(this as SetupRoute);
      case _Routes.GroupOverviewRoute:
        return groupOverviewRoute(this as GroupOverviewRoute);
      case _Routes.GroupDetailsRoute:
        return groupDetailsRoute(this as GroupDetailsRoute);
      case _Routes.ProductOverviewRoute:
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        return chargeOverviewRoute(this as ChargeOverviewRoute);
      case _Routes.ChargeDetailsRoute:
        return chargeDetailsRoute(this as ChargeDetailsRoute);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required
          FutureOr<R> Function(HomeRoute) homeRoute,
      @required
          FutureOr<R> Function(SetupRoute) setupRoute,
      @required
          FutureOr<R> Function(GroupOverviewRoute) groupOverviewRoute,
      @required
          FutureOr<R> Function(GroupDetailsRoute) groupDetailsRoute,
      @required
          FutureOr<R> Function(ProductOverviewRoute) productOverviewRoute,
      @required
          FutureOr<R> Function(ProductDetailsRoute) productDetailsRoute,
      @required
          FutureOr<R> Function(ChargeOverviewRoute) chargeOverviewRoute,
      @required
          FutureOr<R> Function(ChargeDetailsRoute) chargeDetailsRoute}) {
    assert(() {
      if (homeRoute == null ||
          setupRoute == null ||
          groupOverviewRoute == null ||
          groupDetailsRoute == null ||
          productOverviewRoute == null ||
          productDetailsRoute == null ||
          chargeOverviewRoute == null ||
          chargeDetailsRoute == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Routes.HomeRoute:
        return homeRoute(this as HomeRoute);
      case _Routes.SetupRoute:
        return setupRoute(this as SetupRoute);
      case _Routes.GroupOverviewRoute:
        return groupOverviewRoute(this as GroupOverviewRoute);
      case _Routes.GroupDetailsRoute:
        return groupDetailsRoute(this as GroupDetailsRoute);
      case _Routes.ProductOverviewRoute:
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        return chargeOverviewRoute(this as ChargeOverviewRoute);
      case _Routes.ChargeDetailsRoute:
        return chargeDetailsRoute(this as ChargeDetailsRoute);
    }
  }

  R whenOrElse<R>(
      {R Function(HomeRoute) homeRoute,
      R Function(SetupRoute) setupRoute,
      R Function(GroupOverviewRoute) groupOverviewRoute,
      R Function(GroupDetailsRoute) groupDetailsRoute,
      R Function(ProductOverviewRoute) productOverviewRoute,
      R Function(ProductDetailsRoute) productDetailsRoute,
      R Function(ChargeOverviewRoute) chargeOverviewRoute,
      R Function(ChargeDetailsRoute) chargeDetailsRoute,
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
      case _Routes.GroupOverviewRoute:
        if (groupOverviewRoute == null) break;
        return groupOverviewRoute(this as GroupOverviewRoute);
      case _Routes.GroupDetailsRoute:
        if (groupDetailsRoute == null) break;
        return groupDetailsRoute(this as GroupDetailsRoute);
      case _Routes.ProductOverviewRoute:
        if (productOverviewRoute == null) break;
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        if (productDetailsRoute == null) break;
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        if (chargeOverviewRoute == null) break;
        return chargeOverviewRoute(this as ChargeOverviewRoute);
      case _Routes.ChargeDetailsRoute:
        if (chargeDetailsRoute == null) break;
        return chargeDetailsRoute(this as ChargeDetailsRoute);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(HomeRoute) homeRoute,
      FutureOr<R> Function(SetupRoute) setupRoute,
      FutureOr<R> Function(GroupOverviewRoute) groupOverviewRoute,
      FutureOr<R> Function(GroupDetailsRoute) groupDetailsRoute,
      FutureOr<R> Function(ProductOverviewRoute) productOverviewRoute,
      FutureOr<R> Function(ProductDetailsRoute) productDetailsRoute,
      FutureOr<R> Function(ChargeOverviewRoute) chargeOverviewRoute,
      FutureOr<R> Function(ChargeDetailsRoute) chargeDetailsRoute,
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
      case _Routes.GroupOverviewRoute:
        if (groupOverviewRoute == null) break;
        return groupOverviewRoute(this as GroupOverviewRoute);
      case _Routes.GroupDetailsRoute:
        if (groupDetailsRoute == null) break;
        return groupDetailsRoute(this as GroupDetailsRoute);
      case _Routes.ProductOverviewRoute:
        if (productOverviewRoute == null) break;
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        if (productDetailsRoute == null) break;
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        if (chargeOverviewRoute == null) break;
        return chargeOverviewRoute(this as ChargeOverviewRoute);
      case _Routes.ChargeDetailsRoute:
        if (chargeDetailsRoute == null) break;
        return chargeDetailsRoute(this as ChargeDetailsRoute);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(HomeRoute) homeRoute,
      FutureOr<void> Function(SetupRoute) setupRoute,
      FutureOr<void> Function(GroupOverviewRoute) groupOverviewRoute,
      FutureOr<void> Function(GroupDetailsRoute) groupDetailsRoute,
      FutureOr<void> Function(ProductOverviewRoute) productOverviewRoute,
      FutureOr<void> Function(ProductDetailsRoute) productDetailsRoute,
      FutureOr<void> Function(ChargeOverviewRoute) chargeOverviewRoute,
      FutureOr<void> Function(ChargeDetailsRoute) chargeDetailsRoute}) {
    assert(() {
      if (homeRoute == null &&
          setupRoute == null &&
          groupOverviewRoute == null &&
          groupDetailsRoute == null &&
          productOverviewRoute == null &&
          productDetailsRoute == null &&
          chargeOverviewRoute == null &&
          chargeDetailsRoute == null) {
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
      case _Routes.GroupOverviewRoute:
        if (groupOverviewRoute == null) break;
        return groupOverviewRoute(this as GroupOverviewRoute);
      case _Routes.GroupDetailsRoute:
        if (groupDetailsRoute == null) break;
        return groupDetailsRoute(this as GroupDetailsRoute);
      case _Routes.ProductOverviewRoute:
        if (productOverviewRoute == null) break;
        return productOverviewRoute(this as ProductOverviewRoute);
      case _Routes.ProductDetailsRoute:
        if (productDetailsRoute == null) break;
        return productDetailsRoute(this as ProductDetailsRoute);
      case _Routes.ChargeOverviewRoute:
        if (chargeOverviewRoute == null) break;
        return chargeOverviewRoute(this as ChargeOverviewRoute);
      case _Routes.ChargeDetailsRoute:
        if (chargeDetailsRoute == null) break;
        return chargeDetailsRoute(this as ChargeDetailsRoute);
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
class GroupOverviewRoute extends Routes {
  const GroupOverviewRoute._() : super(_Routes.GroupOverviewRoute);

  factory GroupOverviewRoute() {
    _instance ??= const GroupOverviewRoute._();
    return _instance;
  }

  static GroupOverviewRoute _instance;
}

@immutable
class GroupDetailsRoute extends Routes {
  const GroupDetailsRoute({@required this.group, @required this.changes})
      : super(_Routes.GroupDetailsRoute);

  final Group group;

  final List<ModelChange> changes;

  @override
  String toString() =>
      'GroupDetailsRoute(group:${this.group},changes:${this.changes})';
  @override
  List get props => [group, changes];
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
      @required this.groups})
      : super(_Routes.ProductDetailsRoute);

  final Product product;

  final List<ModelChange> changes;

  final List<Group> groups;

  @override
  String toString() =>
      'ProductDetailsRoute(product:${this.product},changes:${this.changes},groups:${this.groups})';
  @override
  List get props => [product, changes, groups];
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

@immutable
class ChargeDetailsRoute extends Routes {
  const ChargeDetailsRoute({@required this.charge})
      : super(_Routes.ChargeDetailsRoute);

  final Charge charge;

  @override
  String toString() => 'ChargeDetailsRoute(charge:${this.charge})';
  @override
  List get props => [charge];
}
