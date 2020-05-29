import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Column, Container, EdgeInsets, Expanded, Hero, Icon, Icons, Key, ListTile, ListView, MainAxisSize, Material, MediaQuery, Navigator, Padding, Scaffold, SingleChildScrollView, SizedBox, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    title: state.group.title,
                    tag: state.group.id,
                    event: state.group.expiredOrNotification != null ? "Notify Apr 25, 2020" : null,
                    trendingDown: state.group.tooFewAvailable != null ? "Less than xx available" : null,
                    available: S.of(context).available(state.group.subtitle),
                    modifyAction: () => Navigator.push(context, RouteBuilder.build(Routes.GroupDetailsRoute)),
                    callback: (value) {
                      setState(() {
                        searchString = value;
                      });
                    },
                  ),
                  HorizontalTextDivider(
                    text: "Products",
                  ),
                  Expanded(
                    child: state.group.products.length == 0
                        ? Center(
                            child: Text("Nothing here"),
                          )
                        : ListView.builder(
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

                              return Hero(
                                tag: product.id,
                                flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                                  child: SingleChildScrollView(
                                    child: toHeroContext.widget,
                                  ),
                                ),
                                child: Card(
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
          if (state is ShowGroup) {
            return createSpeedDial([
              goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
              createProductButton(() => widget.speedDial.add(TapOnCreateProduct(context, state.group))),
            ]);
          }
          return createSpeedDial([
            goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
          ]);
        }
      ),
    );
  }
}
