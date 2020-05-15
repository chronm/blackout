import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/listable_utils.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Container, Key, ListView, Navigator, Scaffold, State, StatefulWidget, Widget;
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
        titleResolver: (state) {
          if (state is ShowProduct) {
            return state.product.description;
          }
          return "";
        },
        titleCallback: (state) {
          if (state is ShowProduct) {
            Navigator.push(context, RouteBuilder.build(Routes.productDetailsRoute(product: state.product, changes: state.changes, categories: state.categories)));
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

                return buildItemListItem(
                  context,
                  item,
                  state.changes,
                  () {},
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
