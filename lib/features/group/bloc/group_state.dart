part of 'group_bloc.dart';

abstract class GroupState {}

class InitialGroupState extends GroupState {}

class ShowGroup extends GroupState {
  final Group group;

  ShowGroup(this.group);
}

class ShowGroups extends GroupState {
  final List<Group> groups;

  ShowGroups(this.groups);
}

class GoToProduct extends GroupState {
  final String currentGroup;

  GoToProduct(this.currentGroup);
}

class Loading extends GroupState {}