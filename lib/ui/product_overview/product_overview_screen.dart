import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/item.dart';
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
            Navigator.push(context, RouteBuilder.build(Routes.productDetailsRoute(product: state.product, changes: state.product.modelChanges, categories: state.categories)));
          }
        },
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is ShowProduct) {
            return ListView.builder(
              itemCount: state.product.items.length,
              itemBuilder: (context, index) {
                Item item = state.product.items[index];

                List<Widget> trailing = <Widget>[];
                if (item.expiredOrNotification) {
                  trailing.add(
                    Icon(Icons.event),
                  );
                }

                return Card(
                  child: ListTile(
                    title: Text(item.buildTitle(context)),
                    subtitle: Text(S.of(context).available(item.subtitle)),
                    trailing: Column(
                      children: trailing,
                      mainAxisSize: MainAxisSize.min,
                    ),
                    onTap: () async {
                      widget._bloc.add(TapOnItem(item));
                      await Navigator.push(context, RouteBuilder.build(Routes.itemOverviewRoute()));
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
