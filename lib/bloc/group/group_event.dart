part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {}

class LoadGroup extends GroupEvent {
  final String groupId;

  LoadGroup(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class SaveGroup extends GroupEvent {
  final Group group;

  SaveGroup(this.group);

  @override
  List<Object> get props => [group];
}

class TapOnProduct extends GroupEvent {
  final Product product;

  TapOnProduct(this.product);

  @override
  List<Object> get props => [product];
}
