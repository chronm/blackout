import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  GroupRepository groupRepository;
  ModelChangeRepository modelChangeRepository;
  BlackoutPreferences blackoutPreferences;
  GroupBloc groupBloc;
  ProductBloc productBloc;

  setUp(() {
    groupRepository = GroupRepositoryMock();
    modelChangeRepository = ModelChangeRepositoryMock();
    blackoutPreferences = BlackoutPreferencesMock();
    groupBloc = GroupBloc(groupRepository, modelChangeRepository, blackoutPreferences, productBloc);
  });

  test('Save group emits ShowGroup', () {
    when(blackoutPreferences.getUser()).thenAnswer((_) => Future.value(createDefaultUser()));
    when(groupRepository.save(argThat(isA<Group>()), argThat(isA<User>()))).thenAnswer((_) => Future.value(createDefaultGroup()..id = DEFAULT_CATEGORY_ID));
    when(modelChangeRepository.findAllByGroupId(DEFAULT_CATEGORY_ID, DEFAULT_HOME_ID)).thenAnswer((_) => Future.value([createDefaultModelChange(ModelChangeType.create, group: createDefaultGroup()..id = DEFAULT_CATEGORY_ID)]));

    expectLater(groupBloc, emitsInOrder([InitialGroupState(), isA<ShowGroup>()]));

    groupBloc.add(SaveGroupAndClose(createDefaultGroup()));
  });

  test('Load group, coming from HomeScreen emits ShowGroup', () {
    when(modelChangeRepository.findAllByGroupId(DEFAULT_CATEGORY_ID, DEFAULT_HOME_ID)).thenAnswer((_) => Future.value([createDefaultModelChange(ModelChangeType.create, group: createDefaultGroup()..id = DEFAULT_CATEGORY_ID)]));
    when(blackoutPreferences.getHome()).thenAnswer((realInvocation) => Future.value(createDefaultHome()));

    expectLater(groupBloc, emitsInOrder([InitialGroupState(), isA<ShowGroup>()]));

    groupBloc.add(LoadGroup(DEFAULT_CATEGORY_ID));
  });
}
