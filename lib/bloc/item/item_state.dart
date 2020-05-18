part of 'item_bloc.dart';

abstract class ItemState extends Equatable {}

class InitialItemState extends ItemState {
  @override
  List<Object> get props => [];
}

class ShowItem extends ItemState {
  final Item item;

  ShowItem(this.item);

  @override
  List<Object> get props => [item];
}
