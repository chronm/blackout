import 'package:Blackout/features/blackout_drawer/blackout_drawer.dart';
import 'package:Blackout/features/home/widgets/home_dial.dart';
import 'package:Blackout/features/home/widgets/home_list.dart';
import 'package:Blackout/features/home/widgets/home_search_bar.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/features/home/bloc/home_bloc.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart' show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Navigator, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: sl<HomeBloc>(),
      listener: (context, state) async {
        if (state is GoToProduct) {
          await Navigator.push(context, RouteBuilder.build(Routes.ProductOverviewRoute));
          sl<HomeBloc>().add(LoadAll());
        }
        if (state is GoToGroup) {
          await Navigator.push(context, RouteBuilder.build(Routes.GroupOverviewRoute));
          sl<HomeBloc>().add(LoadAll());
        }
      },
      child: Scaffold(
        key: _scaffold,
        drawer: BlackoutDrawer(),
        body: ScrollableContainer(
          fullscreen: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeSearchBar(
                scaffold: _scaffold,
                searchCallback: (searchString) {
                  setState(() {
                    this.searchString = searchString;
                  });
                },
              ),
              HorizontalTextDivider(
                text: S.of(context).HOME_PRODUCTS_AND_GROUPS,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                bloc: sl<HomeBloc>(),
                builder: (context, state) {
                  if (state is LoadedAll) {
                    return HomeList(
                      cards: state.cards.where((card) => card.title.toLowerCase().contains(searchString)).toList(),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const HomeDial(),
      ),
    );
  }
}
