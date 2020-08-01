part of 'group_cubit.dart';

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

class GoToProduct extends GroupState {}

class GoBack extends GroupState {}
