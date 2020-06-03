import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Card,
        Center,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        Curves,
        EdgeInsets,
        Expanded,
        FontWeight,
        Hero,
        Icon,
        IconButton,
        Icons,
        InkWell,
        IntrinsicHeight,
        Key,
        ListTile,
        ListView,
        MainAxisSize,
        Material,
        MediaQuery,
        Navigator,
        OverlayEntry,
        Padding,
        Row,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        Spacer,
        Stack,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget,
        showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProductOverviewScreen extends StatefulWidget {
  final ProductBloc bloc = sl<ProductBloc>();
  final SpeedDialBloc speedDial = sl<SpeedDialBloc>();

  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: state.product.title,
                    tag: state.product.id,
                    trendingDown: state.product.tooFewAvailable ? "Less than 800 g available" : null,
                    event: state.product.expiredOrNotification ? "Notify Apr 25, 2020" : null,
                    available: S.of(context).available(state.product.subtitle),
                    groupName: state.product.group != null ? state.product.group.title : null,
                    modifyAction: () => widget.bloc.add(TapOnShowProductConfiguration(state.product, state.groups, context)),
                    changesAction: () => widget.bloc.add(TapOnShowProductChanges(state.product.modelChanges, context)),
                  ),
                  HorizontalTextDivider(
                    text: "Charges",
                  ),
                  Expanded(
                    child: state.product.charges.length == 0
                        ? Center(
                            child: Text("Nothing here"),
                          )
                        : ListView.builder(
                            itemCount: state.product.charges.length,
                            itemBuilder: (context, index) {
                              Charge charge = state.product.charges[0];

                              List<Widget> trailing = <Widget>[];
                              if (charge.expiredOrNotification) {
                                trailing.add(
                                  Icon(Icons.event),
                                );
                              }

                              return Hero(
                                tag: charge.id,
                                flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                                  child: SingleChildScrollView(
                                    child: toHeroContext.widget,
                                  ),
                                ),
                                child: Card(
                                  child: ListTile(
                                    title: Text(charge.buildTitle(context)),
                                    subtitle: Text(S.of(context).available(charge.subtitle)),
                                    trailing: Column(
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
          }
          return createSpeedDial(children);
        },
      ),
    );
  }
}
