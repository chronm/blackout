part of 'group_bloc.dart';

abstract class GroupState {}

class InitialGroupState extends GroupState {}

class ShowGroup extends GroupState {
  final Group group;

  ShowGroup(this.group);
}

class Loading extends GroupState implements LoadingState {}

class ShowGroups extends GroupState {
  final List<Group> groups;

  ShowGroups(this.groups);
}

class ShowGroupConfiguration extends GroupState {
  final Home home;

  ShowGroupConfiguration(this.home);

}
