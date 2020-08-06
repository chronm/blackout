part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class Loading extends HomeState {}

class LoadedAll extends HomeState {
  final List<HomeCard> cards;

  LoadedAll(this.cards);
}

class GoToProduct extends HomeState {}

class GoToGroup extends HomeState {}

class ShowChangelog extends HomeState {}

class AskForUpdate extends HomeState {}

class UpdateAvailable extends HomeState {
  final DistributionStore store;

  UpdateAvailable(this.store);
}
