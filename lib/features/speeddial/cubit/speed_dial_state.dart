part of 'speed_dial_cubit.dart';

abstract class SpeedDialState {}

class InitialSpeedDialState extends SpeedDialState {}

class GoToHome extends SpeedDialState {}

class GoToProduct extends SpeedDialState {}

class GoToCreateProductInGroup extends SpeedDialState {
  final Home home;
  final List<Group> groups;
  final Group group;

  GoToCreateProductInGroup(this.home, this.groups, this.group);
}

class GoToCreateProduct extends SpeedDialState {
  final Home home;
  final List<Group> groups;
  final String ean;

  GoToCreateProduct(this.home, this.groups, this.ean);
}

class GoToCreateGroup extends SpeedDialState {
  final Home home;

  GoToCreateGroup(this.home);
}

class GoToCreateGroupForProduct extends SpeedDialState {
  final Home home;

  GoToCreateGroupForProduct(this.home);
}

class GoToCreateBatch extends SpeedDialState {
  final Product product;

  GoToCreateBatch(this.product);
}
