import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/setup/setup_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  BlackoutPreferences blackoutPreferences;
  HomeBloc homeBloc;
  HomeRepository homeRepository;
  UserRepository userRepository;
  SetupBloc setupBloc;

  setUp(() {
    blackoutPreferences = BlackoutPreferencesMock();
    homeBloc = HomeBlocMock();
    homeRepository = HomeRepositoryMock();
    userRepository = UserRepositoryMock();
    setupBloc = SetupBloc(blackoutPreferences, homeBloc, homeRepository, userRepository);
  });

  test('Setup and create new home', () {
    when(homeRepository.save(any)).thenAnswer((_) => Future.value(createDefaultHome()));
    when(userRepository.save(any)).thenAnswer((_) => Future.value(createDefaultUser()));

    expectLater(setupBloc, emitsInOrder([InitialSetupState(), GoToHome()]));

    setupBloc.add(SetupAndCreateEvent(DEFAULT_USER_NAME, DEFAULT_HOME_NAME));
  });
}
