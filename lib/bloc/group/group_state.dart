part of 'group_bloc.dart';

abstract class GroupState extends Equatable {}

class InitialGroupState extends GroupState {
  @override
  List<Object> get props => [];
}

class ShowGroup extends GroupState {
  final Group group;

  ShowGroup(this.group);

  @override
  List<Object> get props => [group];
}

class Loading extends GroupState implements LoadingState {
  @override
  List<Object> get props => [];
}
