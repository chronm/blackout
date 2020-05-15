import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/listable_utils.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Container, ListView, Navigator, SafeArea, Scaffold, State, StatefulWidget, Widget;
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
              List<Listable> cards = state.cards.where((card) => card.title.toLowerCase().contains(searchString)).toList();
              return ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  Listable listable = cards[index];

                  return buildListableListItem(
                    context,
                    listable,
                    () async {
                      if (listable is Category) {
                        widget._bloc.add(TapOnCategory(listable));
                        await Navigator.push(context, RouteBuilder.build(Routes.categoryOverviewRoute()));
                        widget._bloc.add(LoadAll());
                      } else if (listable is Product) {
                        widget._bloc.add(TapOnProduct(listable));
                        await Navigator.push(context, RouteBuilder.build(Routes.productOverviewRoute()));
                        widget._bloc.add(LoadAll());
                      }
                    },
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
