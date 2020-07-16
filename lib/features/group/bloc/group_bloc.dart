import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../home/bloc/home_bloc.dart';
import '../../product/bloc/product_bloc.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;
  final BlackoutPreferences blackoutPreferences;

  GroupBloc(this.groupRepository, this.blackoutPreferences);

  @override
  GroupState get initialState => InitialGroupState();

  Group _group;

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is SaveGroup) {
      var user = await blackoutPreferences.getUser();
      _group = await groupRepository.save(event.group, user);
      sl<HomeBloc>().add(LoadAll());
      yield ShowGroup(_group);
    }
    if (event is UseGroup) {
      _group = event.group;
      yield ShowGroup(_group);
    }
    if (event is LoadGroup) {
      _group = await groupRepository.findOneByGroupId(event.groupId);
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(UseProduct(event.product));
      yield GoToProduct();
    }
    if (event is LoadGroups) {
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowGroups(groups);
      yield ShowGroup(_group);
    }
    if (event is TapOnDeleteGroup) {
      var user = await blackoutPreferences.getUser();
      _group = null;
      groupRepository.drop(event.group, user);
      sl<HomeBloc>().add(LoadAll());
      yield GoBack();
    }
    if (event is Redraw) {
      yield ShowGroup(_group);
    }
  }
}
