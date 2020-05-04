import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/util/listable_utils.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart';
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
