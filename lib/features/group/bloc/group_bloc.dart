import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/features/product/bloc/product_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      User user = await blackoutPreferences.getUser();
      Group group = await groupRepository.save(event.group, user);
      yield ShowGroup(group);
    }
    if (event is LoadGroup) {
      Group group = await groupRepository.findOneByGroupId(event.groupId);
      yield ShowGroup(group);
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(LoadProduct(event.product.id));
      yield GoToProduct(event.group.id);
    }
    if (event is LoadGroups) {
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowGroups(groups);
    }
  }
}
