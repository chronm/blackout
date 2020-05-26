import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show BuildContext, Navigator;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;
  final ModelChangeRepository modelChangeRepository;
  final BlackoutPreferences blackoutPreferences;
  final ProductBloc productBloc;

  GroupBloc(this.groupRepository, this.modelChangeRepository, this.blackoutPreferences, this.productBloc);

  @override
  GroupState get initialState => InitialGroupState();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is CreateGroup) {
      Home home = await blackoutPreferences.getHome();
      yield ShowGroup(Group(home: home, unit: UnitEnum.unitless, name: "", modelChanges: [], products: []));
    }
    if (event is SaveGroupAndReturn) {
      User user = await blackoutPreferences.getUser();
      Group group = await groupRepository.save(event.group, user);
      yield ShowGroup(group);
      sl<HomeBloc>().add(LoadAll());
      Navigator.pop(event.context);
    }
    if (event is LoadGroup) {
      Home home = await blackoutPreferences.getHome();
      Group group = await groupRepository.getOneByGroupIdAndHomeId(event.groupId, home.id);
      yield ShowGroup(group);
    }
    if (event is TapOnProduct) {
      productBloc.add(LoadProduct(event.product.id));
    }
    if (event is LoadGroups) {
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowGroups(groups);
    }
  }
}
