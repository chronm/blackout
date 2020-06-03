part of 'group_bloc.dart';

abstract class GroupEvent {}

class LoadGroup extends GroupEvent {
  final String groupId;

  LoadGroup(this.groupId);
}

class SaveGroupAndClose extends GroupEvent {
  final Group group;
  final BuildContext context;

  SaveGroupAndClose(this.group, this.context);
}

class TapOnProduct extends GroupEvent {
  final Product product;
  final BuildContext context;
  final Group group;

  TapOnProduct(this.product, this.context, this.group);
}

class TapOnShowGroupConfiguration extends GroupEvent {
  final Group group;
  final BuildContext context;

  TapOnShowGroupConfiguration(this.group, this.context);
}

class TapOnShowGroupChanges extends GroupEvent {
  final List<ModelChange> changes;
  final BuildContext context;

  TapOnShowGroupChanges(this.changes, this.context);
}

class LoadGroups extends GroupEvent {}
