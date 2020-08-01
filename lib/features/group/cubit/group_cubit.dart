import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../home/cubit/home_cubit.dart';
import '../../product/cubit/product_cubit.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupRepository groupRepository;
  final BlackoutPreferences blackoutPreferences;

  GroupCubit(this.groupRepository, this.blackoutPreferences) : super(InitialGroupState());

  Group _group;

  void saveGroup(Group group) async {
    var user = await blackoutPreferences.getUser();
    _group = await groupRepository.save(group, user);
    sl<HomeCubit>().loadAll();
    emit(ShowGroup(_group));
  }

  void useGroup(Group group) {
    _group = group;
    emit(ShowGroup(_group));
  }

  void loadGroup(String groupId) async {
    _group = await groupRepository.findOneByGroupId(groupId);
  }

  void tapOnProduct(Product product) {
    sl<ProductCubit>().useProduct(product);
    emit(GoToProduct());
  }

  void loadGroups() async {
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id);
    emit(ShowGroups(groups));
    emit(ShowGroup(_group));
  }

  void tapOnDeleteGroup(Group group) async {
    var user = await blackoutPreferences.getUser();
    _group = null;
    groupRepository.drop(group, user);
    sl<HomeCubit>().loadAll();
    emit(GoBack());
  }

  void redraw() {
    emit(ShowGroup(_group));
  }
}
