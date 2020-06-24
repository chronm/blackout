import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Container,
        GlobalKey,
        Key,
        MainAxisSize,
        Navigator,
        Scaffold,
        ScaffoldState,
        State,
        StatefulWidget,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../routes.dart';
import '../../widget/horizontal_text_divider/horizontal_text_divider.dart';
import '../../widget/scrollable_container/scrollable_container.dart';
import '../blackout_drawer/blackout_drawer.dart';
import 'bloc/group_bloc.dart';
import 'widgets/group_dial.dart';
import 'widgets/group_title.dart';
import 'widgets/products_list.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupBloc, GroupState>(
      bloc: sl<GroupBloc>(),
      listener: (context, state) async {
        if (state is GoToProduct) {
          await Navigator.pushNamed(context, Routes.product);
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
                var group = state.group;
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
                      products: group.products
                          .where((product) => product.title
                              .toLowerCase()
                              .contains(searchString))
                          .toList(),
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
