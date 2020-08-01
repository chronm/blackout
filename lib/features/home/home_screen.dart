import 'package:flutter/material.dart' show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Navigator, Scaffold, ScaffoldState, State, StatefulWidget, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../routes.dart';
import '../../widget/horizontal_text_divider/horizontal_text_divider.dart';
import '../../widget/scrollable_container/scrollable_container.dart';
import '../blackout_drawer/blackout_drawer.dart';
import 'cubit/home_cubit.dart';
import 'widgets/ask_for_update.dart';
import 'widgets/home_dial.dart';
import 'widgets/home_list.dart';
import 'widgets/home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      cubit: sl<HomeCubit>(),
      listener: (context, state) async {
        if (state is AskForUpdate) {
          var doUpdate = await showDialog<bool>(
            context: context,
            builder: (_) => const AskForUpdateDialog(),
          );
          if (doUpdate) sl<HomeCubit>().doUpdate();
        }
        if (state is ShowChangelog) {
          Navigator.pushNamed(context, Routes.changelog);
        }
        if (state is GoToProduct) {
          await Navigator.pushNamed(context, Routes.product);
          sl<HomeCubit>().redraw();
        }
        if (state is GoToGroup) {
          await Navigator.pushNamed(context, Routes.group);
          sl<HomeCubit>().redraw();
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
              BlocBuilder<HomeCubit, HomeState>(
                cubit: sl<HomeCubit>(),
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
