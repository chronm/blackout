import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../product/bloc/product_bloc.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;
  final BlackoutPreferences blackoutPreferences;

  GroupBloc(this.groupRepository, this.blackoutPreferences);

  @override
  GroupState get initialState => InitialGroupState();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is SaveGroup) {
      var user = await blackoutPreferences.getUser();
      var group = await groupRepository.save(event.group, user);
      yield ShowGroup(group);
    }
    if (event is LoadGroup) {
      var group = await groupRepository.findOneByGroupId(event.groupId);
      yield ShowGroup(group);
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(LoadProduct(event.product.id));
      yield GoToProduct(event.group.id);
    }
    if (event is LoadGroups) {
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowGroups(groups);
    }
    if (event is TapOnDeleteGroup) {
      var user = await blackoutPreferences.getUser();
      groupRepository.drop(event.group, user);
    }
  }
}
