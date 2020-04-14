import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/loading_search_bar/loading_search_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Column, Container, Icon, Icons, ListTile, ListView, MainAxisSize, Navigator, SafeArea, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final HomeBloc _bloc = sl<HomeBloc>();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: LoadingSearchBar<HomeBloc, HomeState>(
          title: "Blackout",
          bloc: widget._bloc,
          callback: (search) {
            setState(() {
              searchString = search.toLowerCase();
            });
          },
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: widget._bloc,
          listener: (context, state) {
            print(state);
            print("HomeScree");
          },
          builder: (context, state) {
            if (state is LoadedAll) {
              List<Displayable> cards = state.cards.where((card) => card.title.toLowerCase().contains(searchString)).toList();
              return ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  Displayable displayable = cards[index];

                  List<Widget> trailing = <Widget>[];
                  if (displayable.state.expiredOrNotification) {
                    trailing.add(
                      Icon(
                        Icons.event,
                      ),
                    );
                  }
                  if (displayable.state.tooFewAvailable) {
                    trailing.add(
                      Icon(
                        Icons.trending_down,
                      ),
                    );
                  }
                  return Card(
                    child: ListTile(
                      title: Text(
                        displayable.title,
                      ),
                      subtitle: Text(
                        S.of(context).available(displayable.scaledAmount),
                      ),
                      trailing: Column(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () {
                        if (displayable is Category) {
                          widget._bloc.add(TapOnCategory(displayable));
                          Navigator.push(context, RouteBuilder.build(Routes.categoryOverviewRoute()));
                        }
                      },
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
