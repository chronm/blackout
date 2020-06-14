import 'package:Blackout/features/blackout_drawer/blackout_drawer.dart';
import 'package:Blackout/features/group/bloc/group_bloc.dart';
import 'package:Blackout/features/group/widgets/group_dial.dart';
import 'package:Blackout/features/group/widgets/group_title.dart';
import 'package:Blackout/features/group/widgets/products_list.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart' show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Navigator, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupOverviewScreen extends StatefulWidget {
  const GroupOverviewScreen({Key key}) : super(key: key);

  @override
  _GroupOverviewScreenState createState() => _GroupOverviewScreenState();
}

class _GroupOverviewScreenState extends State<GroupOverviewScreen> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupBloc, GroupState>(
      bloc: sl<GroupBloc>(),
      listener: (context, state) async {
        if (state is GoToProduct) {
          await Navigator.push(context, RouteBuilder.build(Routes.ProductOverviewRoute));
          sl<GroupBloc>().add(LoadGroup(state.currentGroup));
        }
      },
      child: Scaffold(
        key: _scaffold,
        drawer: BlackoutDrawer(),
        body: ScrollableContainer(
          fullscreen: true,
          child: BlocBuilder<GroupBloc, GroupState>(
            bloc: sl<GroupBloc>(),
            builder: (context, state) {
              if (state is ShowGroup) {
                Group group = state.group;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GroupTitle(
                      scaffold: _scaffold,
                      group: group,
                      searchCallback: (value) {
                        setState(() {
                          searchString = value;
                        });
                      },
                    ),
                    HorizontalTextDivider(
                      text: S.of(context).PRODUCTS,
                    ),
                    ProductsList(
                      group: group,
                      products: group.products.where((product) => product.title.toLowerCase().contains(searchString)).toList(),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: const GroupDial(),
      ),
    );
  }
}
