part of 'group_bloc.dart';

abstract class GroupEvent {}

class LoadGroup extends GroupEvent {
  final String groupId;

  LoadGroup(this.groupId);
}

class LoadGroups extends GroupEvent {}

class SaveGroup extends GroupEvent {
  final Group group;

  SaveGroup(this.group);
}

class TapOnProduct extends GroupEvent {
  final Product product;
  final Group group;

  TapOnProduct(this.product, this.group);
}