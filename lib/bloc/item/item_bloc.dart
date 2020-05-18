import 'dart:async';

import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'item_event.dart';

part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ModelChangeRepository modelChangeRepository;
  final ChangeRepository changeRepository;
  final ItemRepository itemRepository;
  final BlackoutPreferences blackoutPreferences;

  ItemBloc(this.changeRepository, this.itemRepository, this.blackoutPreferences, this.modelChangeRepository);

  @override
  ItemState get initialState => InitialItemState();

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is SaveItem) {
      User user = await blackoutPreferences.getUser();
      Item item = await itemRepository.save(event.item, user);
      yield ShowItem(item);
    }
    if (event is LoadItem) {
      Home home = await blackoutPreferences.getHome();
      Item item = await itemRepository.getOneByItemIdAndHomeId(event.itemId, home.id);
      yield ShowItem(item);
    }
  }
}
