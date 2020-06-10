import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/blackout_drawer/blackout_drawer.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BuildContext,
        Card,
        Center,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        Drawer,
        DrawerHeader,
        EdgeInsets,
        Expanded,
        GlobalKey,
        Hero,
        Icon,
        Icons,
        Key,
        ListTile,
        ListView,
        MainAxisSize,
        Material,
        MediaQuery,
        Navigator,
        Row,
        Scaffold,
        ScaffoldState,
        SingleChildScrollView,
        State,
        StatefulWidget,
        Text,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

class ProductOverviewScreen extends StatefulWidget {
  final ProductBloc bloc = sl<ProductBloc>();
  final SpeedDialBloc speedDial = sl<SpeedDialBloc>();

  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      drawer: BlackoutDrawer(),
      body: ScrollableContainer(
        fullscreen: true,
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is ShowProduct) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TitleCard(
                    scaffold: _scaffold,
                    title: state.product.title,
                    tag: state.product.id,
                    trendingDown: state.product.tooFewAvailable ? S.of(context).GENERAL_LESS_THAN_AVAILABLE(state.product.scientificRefillLimit) : null,
                    available: S.of(context).GENERAL_AMOUNT_AVAILABLE(state.product.scientificAmount),
                    event: state.product.buildStatus(context),
                    groupName: state.product.group != null ? state.product.group.title : null,
                    modifyAction: () => widget.bloc.add(TapOnShowProductConfiguration(state.product, state.groups, context)),
                    changesAction: () => widget.bloc.add(TapOnShowProductChanges(state.product.modelChanges, context)),
                  ),
                  HorizontalTextDivider(
                    text: S.of(context).UNITS,
                  ),
                  Expanded(
                    child: state.product.charges.length == 0
                        ? Center(
                      child: Text(S.of(context).GENERAL_NOTHING_HERE),
                    )
                        : ListView.builder(
                      itemCount: state.product.charges.length,
                      itemBuilder: (context, index) {
                        Charge charge = state.product.charges[index];

                        List<Widget> trailing = <Widget>[];
                        if (charge.expired || charge.warn) {
                          trailing.add(
                            Icon(
                              Icons.event,
                              color: charge.status == ChargeStatus.expired ? Colors.redAccent : null,
                            ),
                          );
                        }

                        String status = charge.buildStatus(context);

                        return Hero(
                          tag: charge.id,
                          flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                            child: SingleChildScrollView(
                              child: toHeroContext.widget,
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              isThreeLine: status != null,
                              title: Text(S.of(context).UNIT_CREATED_AT(DateFormat.yMd().format(charge.creationDate.toDateTimeUnspecified())).capitalize()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(charge.scientificAmount)),
                                  status != null ? Text(status) : null,
                                ].where((element) => element != null).toList(),
                              ),
                              trailing: Row(
                                children: trailing,
                                mainAxisSize: MainAxisSize.min,
                              ),
                              onTap: () async {
                                widget.bloc.add(TapOnCharge(charge));
                                await Navigator.push(context, RouteBuilder.build(Routes.ChargeOverviewRoute));
                                widget.bloc.add(LoadProduct(state.product.id));
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
      floatingActionButton: BlocBuilder<ProductBloc, ProductState>(
        bloc: widget.bloc,
        builder: (context, state) {
          List<SpeedDialChild> children = [
            goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
          ];
          if (state is ShowProduct) {
            children.add(createChargeButton(() => widget.speedDial.add(TapOnCreateCharge(context, state.product))));
            children.add(createGroupButton(() => widget.speedDial.add(TapOnCreateGroup(context))));
          }
          return createSpeedDial(children);
        },
      ),
    );
  }
}
