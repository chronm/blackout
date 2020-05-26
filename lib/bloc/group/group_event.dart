part of 'group_bloc.dart';

abstract class GroupEvent {}

class CreateGroup extends GroupEvent {}

class LoadGroup extends GroupEvent {
  final String groupId;

  LoadGroup(this.groupId);
}

class SaveGroupAndReturn extends GroupEvent {
  final Group group;
  final BuildContext context;

  SaveGroupAndReturn(this.group, this.context);
}

class TapOnProduct extends GroupEvent {
  final Product product;

  TapOnProduct(this.product);
}

class LoadGroups extends GroupEvent {}
