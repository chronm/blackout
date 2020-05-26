import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Container, Icon, Icons, Key, ListTile, ListView, Navigator, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter/widgets.dart' show BuildContext, Column, Container, Icon, Key, ListView, MainAxisSize, Navigator, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class GroupOverviewScreen extends StatefulWidget {
  final GroupBloc bloc = sl<GroupBloc>();
  final SpeedDialBloc speedDial = sl<SpeedDialBloc>();

  GroupOverviewScreen({Key key}) : super(key: key);

  @override
  _GroupOverviewScreenState createState() => _GroupOverviewScreenState();
}

class _GroupOverviewScreenState extends State<GroupOverviewScreen> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<GroupBloc, GroupState>(
        titleResolver: (state) => state is ShowGroup ? state.group.title : "",
        titleCallback: (state) {
          if (state is ShowGroup) {
            Navigator.push(context, RouteBuilder.build(Routes.GroupDetailsRoute));
          }
        },
        subtitleResolver: (state) {
          return null;
        },
        bloc: widget.bloc,
        searchCallback: (search) {
          setState(() {
            searchString = search.toLowerCase();
          });
        },
        returnAction: () => Navigator.pop(context),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is ShowGroup) {
            if (state.group.products.length == 0) {
              return Center(
                child: Text(
                  "Nothing here",
                ),
              );
            }
            List<Product> products = state.group.products.where((product) => product.title.toLowerCase().contains(searchString)).toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                List<Widget> trailing = <Widget>[];
                if (product.expiredOrNotification) {
                  trailing.add(
                    Icon(
                      Icons.event,
                    ),
                  );
                }
                if (product.tooFewAvailable) {
                  trailing.add(
                    Icon(
                      Icons.trending_down,
                    ),
                  );
                }

                return Card(
                  child: ListTile(
                    title: Text(product.title),
                    subtitle: Text(S.of(context).available(product.subtitle)),
                    trailing: Column(
                      children: trailing,
                      mainAxisSize: MainAxisSize.min,
                    ),
                    onTap: () async {
                      widget.bloc.add(TapOnProduct(product));
                      await Navigator.push(context, RouteBuilder.build(Routes.ProductOverviewRoute));
                      widget.bloc.add(LoadGroup(state.group.id));
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: createSpeedDial([
        goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
        createProductButton(() => widget.speedDial.add(TapOnCreateProduct(context))),
      ]),
    );
  }
}
