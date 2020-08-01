part of 'group_cubit.dart';

abstract class GroupEvent {}

class Redraw extends GroupEvent {}

class UseGroup extends GroupEvent {
  final Group group;

  UseGroup(this.group);
}

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

class TapOnDeleteGroup extends GroupEvent {
  final Group group;

  TapOnDeleteGroup(this.group);
}
