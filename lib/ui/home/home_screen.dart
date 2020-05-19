import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
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
        appBar: LoadingAppBar<HomeBloc, HomeState>(
          title: "Blackout",
          bloc: widget._bloc,
          searchCallback: (search) {
            setState(() {
              searchString = search.toLowerCase();
            });
          },
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: widget._bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedAll) {
              List<HomeListable> cards = state.cards.where((card) => card.title.toLowerCase().contains(searchString)).toList();

              return ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  HomeListable listable = cards[index];

                  List<Widget> trailing = <Widget>[];
                  if (listable.expiredOrNotification) {
                    trailing.add(
                      Icon(Icons.event),
                    );
                  }
                  if (listable.tooFewAvailable) {
                    trailing.add(
                      Icon(Icons.trending_down),
                    );
                  }

                  return Card(
                    child: ListTile(
                      title: Text(listable.title),
                      subtitle: Text(S.of(context).available(listable.subtitle)),
                      trailing: Column(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () async {
                        if (listable is Group) {
                          widget._bloc.add(TapOnGroup(listable));
                          await Navigator.push(context, RouteBuilder.build(Routes.groupOverviewRoute()));
                          widget._bloc.add(LoadAll());
                        } else if (listable is Product) {
                          widget._bloc.add(TapOnProduct(listable));
                          await Navigator.push(context, RouteBuilder.build(Routes.productOverviewRoute()));
                          widget._bloc.add(LoadAll());
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
