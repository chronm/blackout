part of 'speed_dial_bloc.dart';

abstract class SpeedDialState {}

class InitialSpeedDialState extends SpeedDialState {}

class GoToHome extends SpeedDialState {}

class GoToProduct extends SpeedDialState {}

class ShowCreateProductInGroup extends SpeedDialState {
  final String currentGroup;
  final Home home;
  final List<Group> groups;
  final Group group;

  ShowCreateProductInGroup(this.home, this.groups, this.group, this.currentGroup);
}

class ShowCreateProduct extends SpeedDialState {
  final Home home;
  final List<Group> groups;
  final String ean;

  ShowCreateProduct(this.home, this.groups, this.ean);
}

class ShowCreateGroup extends SpeedDialState {
  final Home home;

  ShowCreateGroup(this.home);
}

class ShowCreateGroupForProduct extends SpeedDialState {
  final Home home;

  ShowCreateGroupForProduct(this.home);
}

class ShowCreateCharge extends SpeedDialState {
  final String currentProduct;
  final Product product;

  ShowCreateCharge(this.product, this.currentProduct);
}
