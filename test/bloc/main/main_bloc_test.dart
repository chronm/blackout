import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  BlackoutPreferences blackoutPreferences;
  HomeBloc homeBloc;
  MainBloc mainBloc;

  setUp(() {
    blackoutPreferences = BlackoutPreferencesMock();
    homeBloc = HomeBlocMock();
    mainBloc = MainBloc(blackoutPreferences, homeBloc);
  });

  test('Emit GoToHome when user and home already exists', () {
    when(blackoutPreferences.getUser()).thenAnswer((_) => Future.value(createDefaultUser()));
    when(blackoutPreferences.getHome()).thenAnswer((_) => Future.value(createDefaultHome()));

    expectLater(mainBloc, emitsInOrder([InitialMainState(), GoToHome()]));

    mainBloc.add(InitializeAppEvent());
  });

  test('Emit GoToSetup when user not exists', () {
    when(blackoutPreferences.getUser()).thenAnswer((_) => Future.value(null));

    expectLater(mainBloc, emitsInOrder([InitialMainState(), GoToSetup()]));

    mainBloc.add(InitializeAppEvent());
  });

  test('Emit GoToSetup when home not exists', () {
    when(blackoutPreferences.getUser()).thenAnswer((_) => Future.value(createDefaultUser()));
    when(blackoutPreferences.getUser()).thenAnswer((_) => Future.value(null));

    expectLater(mainBloc, emitsInOrder([InitialMainState(), GoToSetup()]));

    mainBloc.add(InitializeAppEvent());
  });
}
