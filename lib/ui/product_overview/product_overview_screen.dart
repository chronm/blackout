import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Column, Container, Icon, Icons, Key, ListTile, ListView, MainAxisSize, Navigator, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOverviewScreen extends StatefulWidget {
  final ProductBloc _bloc = sl<ProductBloc>();

  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<ProductBloc, ProductState>(
        bloc: widget._bloc,
        titleResolver: (state) => state is ShowProduct ? state.product.title : "",
        titleCallback: (state) {
          if (state is ShowProduct) {
            Navigator.push(context, RouteBuilder.build(Routes.productDetailsRoute(product: state.product, changes: state.product.modelChanges, groups: state.groups)));
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
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is ShowProduct) {
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
                      widget._bloc.add(TapOnCharge(charge));
                      await Navigator.push(context, RouteBuilder.build(Routes.chargeOverviewRoute()));
                      widget._bloc.add(LoadProduct(state.product.id));
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
