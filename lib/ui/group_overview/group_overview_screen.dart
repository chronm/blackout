import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/blackout_drawer/blackout_drawer.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Colors, Column, Container, CrossAxisAlignment, Expanded, GlobalKey, Hero, Icon, Icons, Key, ListTile, ListView, MainAxisSize, Material, Row, Scaffold, ScaffoldState, SingleChildScrollView, State, StatefulWidget, Text, Widget;
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
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      drawer: BlackoutDrawer(),
      body: ScrollableContainer(
        fullscreen: true,
        child: BlocBuilder<GroupBloc, GroupState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is ShowGroup) {
              List<Product> products = state.group.products.where((product) => product.title.toLowerCase().contains(searchString)).toList();
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TitleCard(
                    scaffold: _scaffold,
                    title: state.group.title,
                    tag: state.group.id,
                    trendingDown: state.group.tooFewAvailable ? S.of(context).GENERAL_LESS_THAN_AVAILABLE(state.group.scientificRefillLimit) : null,
                    available: S.of(context).GENERAL_AMOUNT_AVAILABLE(state.group.scientificAmount),
                    event: state.group.buildStatus(context),
                    modifyAction: () => widget.bloc.add(TapOnShowGroupConfiguration(state.group, context)),
                    changesAction: () => widget.bloc.add(TapOnShowGroupChanges(state.group.modelChanges, context)),
                    callback: (value) {
                      setState(() {
                        searchString = value;
                      });
                    },
                  ),
                  HorizontalTextDivider(
                    text: S.of(context).PRODUCTS,
                  ),
                  Expanded(
                    child: state.group.products.length == 0
                        ? Center(
                      child: Text(S.of(context).GENERAL_NOTHING_HERE),
                    )
                        : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];

                        List<Widget> trailing = <Widget>[];
                        if (product.tooFewAvailable) {
                          trailing.add(
                            Icon(
                              Icons.trending_down,
                            ),
                          );
                        }
                        if (product.expired || product.warn) {
                          trailing.add(
                            Icon(
                              Icons.event,
                              color: product.status == ChargeStatus.expired ? Colors.redAccent : null,
                            ),
                          );
                        }

                        String status = product.buildStatus(context);

                        return Hero(
                          tag: product.id,
                          flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                            child: SingleChildScrollView(
                              child: toHeroContext.widget,
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              isThreeLine: status != null,
                              title: Text(product.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(product.scientificAmount)),
                                  status != null ? Text(status) : null,
                                ].where((element) => element != null).toList(),
                              ),
                              trailing: Row(
                                children: trailing,
                                mainAxisSize: MainAxisSize.min,
                              ),
                              onTap: () {
                                widget.bloc.add(TapOnProduct(product, context, state.group));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: BlocBuilder<GroupBloc, GroupState>(
        bloc: widget.bloc,
        builder: (context, state) {
          List<SpeedDialChild> children = [
            goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
          ];
          if (state is ShowGroup) {
            children.add(createProductButton(() => widget.speedDial.add(TapOnCreateProduct(context, state.group))));
          }
          return createSpeedDial(children);
        },
      ),
    );
  }
}
