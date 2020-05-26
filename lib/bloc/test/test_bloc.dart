import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  @override
  TestState get initialState => InitialTestState();

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    // TODO: Add your event logic
  }
}
