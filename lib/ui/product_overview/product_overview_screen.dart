import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Column, Container, Icon, Icons, Key, ListTile, ListView, MainAxisSize, Navigator, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: LoadingAppBar<ProductBloc, ProductState>(
        bloc: widget.bloc,
        titleResolver: (state) => state is ShowProduct ? state.product.title : "",
        titleCallback: (state) {
          if (state is ShowProduct) {
            Navigator.push(context, RouteBuilder.build(Routes.ProductDetailsRoute));
          }
        },
        subtitleResolver: (state) {
          if (state is ShowProduct) {
            String hierarchy = state.product.hierarchy(context);
            if (hierarchy != null) {
              return hierarchy;
            }
          }
          return null;
        },
        returnAction: () => Navigator.pop(context),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is ShowProduct) {
            if (state.product.charges.length == 0) {
              return Center(
                child: Text("Nothing here"),
              );
            }
            return ListView.builder(
              itemCount: state.product.charges.length,
              itemBuilder: (context, index) {
                Charge charge = state.product.charges[index];

                List<Widget> trailing = <Widget>[];
                if (charge.expiredOrNotification) {
                  trailing.add(
                    Icon(Icons.event),
                  );
                }

                return Card(
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
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<SpeedDialBloc, SpeedDialState>(
        builder: (context, state) {
          if (state is ShowProduct) {
            return createSpeedDial([
              goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
              createChargeButton(() => widget.speedDial.add(TapOnCreateCharge(context, (state as ShowProduct).product))),
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
