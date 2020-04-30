import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBlocMock();
  });

  testWidgets('Throw AssertionError when title and titleResolver null', (WidgetTester tester) async {
    expectLater(
        () async => await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  appBar: LoadingAppBar<HomeBloc, HomeState>(
                    bloc: homeBloc,
                    searchCallback: (_) {},
                  ),
                ),
              ),
            ),
        throwsAssertionError);
  });

  testWidgets('Provide title directly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: LoadingAppBar<HomeBloc, HomeState>(
            bloc: homeBloc,
            searchCallback: (_) {},
            title: "title",
          ),
        ),
      ),
    );

    expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == "title"), findsOneWidget);
  });

  testWidgets('Get title from callback', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: LoadingAppBar<HomeBloc, HomeState>(
            bloc: homeBloc,
            searchCallback: (_) {},
            titleResolver: (_) {
              return "title";
            },
          ),
        ),
      ),
    );

    expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == "title"), findsOneWidget);
  });

  testWidgets('Tap on title', (WidgetTester tester) async {
    bool state = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: LoadingAppBar<HomeBloc, HomeState>(
            bloc: homeBloc,
            searchCallback: (_) {},
            title: "title",
            titleCallback: (_) => state = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));

    expect(state, isTrue);
  });

  testWidgets('Switch state to loading', (WidgetTester tester) async {
    whenListen<HomeEvent, HomeState>(homeBloc, Stream<HomeState>.fromIterable(([HomeInitialState(), Loading()])));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: LoadingAppBar<HomeBloc, HomeState>(
            bloc: homeBloc,
            searchCallback: (_) {},
            title: "title",
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('Change to searching, enter text and change back', (WidgetTester tester) async {
    String searchString;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: LoadingAppBar<HomeBloc, HomeState>(
            bloc: homeBloc,
            searchCallback: (value) => searchString = value,
            title: "title",
          ),
        ),
      ),
    );

    await tester.pump();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), "someText");

    expect(searchString, equals("someText"));

    await tester.tap(find.byIcon(Icons.close));
    expect(searchString, equals(""));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);
  });
}
