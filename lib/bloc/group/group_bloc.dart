import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/changes_widget/changes_widget.dart';
import 'package:Blackout/widget/group_configuration/group_configuration.dart';
import 'package:flutter/material.dart' show BuildContext, Navigator, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;
  final ModelChangeRepository modelChangeRepository;
  final BlackoutPreferences blackoutPreferences;

  GroupBloc(this.groupRepository, this.modelChangeRepository, this.blackoutPreferences);

  @override
  GroupState get initialState => InitialGroupState();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is SaveGroupAndClose) {
      User user = await blackoutPreferences.getUser();
      Group group = await groupRepository.save(event.group, user);
      Navigator.pop(event.context, group);
      yield ShowGroup(group);
    }
    if (event is LoadGroup) {
      Group group = await groupRepository.findOneByGroupId(event.groupId);
      yield ShowGroup(group);
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(LoadProduct(event.product.id));
      await Navigator.push(event.context, RouteBuilder.build(Routes.ProductOverviewRoute));
      Group group = await groupRepository.findOneByGroupId(event.group.id);
      yield ShowGroup(group);
    }
    if (event is LoadGroups) {
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowGroups(groups);
    }
    if (event is TapOnShowGroupConfiguration) {
      showDialog(
        context: event.context,
        builder: (context) => GroupConfiguration(
          group: event.group,
          action: (group) => this.add(SaveGroupAndClose(group, context)),
        ),
      );
    }
    if (event is TapOnShowGroupChanges) {
      showDialog(
        context: event.context,
        builder: (context) => ChangesWidget(changes: event.changes),
      );
    }
  }
}
