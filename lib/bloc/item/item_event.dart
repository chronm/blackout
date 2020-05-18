part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {}

class LoadItem extends ItemEvent {
  final String itemId;

  LoadItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class SaveItem extends ItemEvent {
  final Item item;

  SaveItem(this.item);

  @override
  List<Object> get props => [item];
}
