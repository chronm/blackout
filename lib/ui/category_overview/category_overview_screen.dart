import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/listable_utils.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Container, Key, ListView, Navigator, Scaffold, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryOverviewScreen extends StatefulWidget {
  final CategoryBloc _bloc = sl<CategoryBloc>();

  CategoryOverviewScreen({Key key}) : super(key: key);

  @override
  _CategoryOverviewScreenState createState() => _CategoryOverviewScreenState();
}

class _CategoryOverviewScreenState extends State<CategoryOverviewScreen> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<CategoryBloc, CategoryState>(
        titleResolver: (state) {
          if (state is ShowCategory) {
            return state.category.title;
          }
          return "";
        },
        titleCallback: (state) {
          if (state is ShowCategory) {
            Navigator.push(context, RouteBuilder.build(Routes.categoryDetailsRoute(category: state.category, changes: state.changes)));
          }
        },
        bloc: widget._bloc,
        searchCallback: (search) {
          setState(() {
            searchString = search.toLowerCase();
          });
        },
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is ShowCategory) {
            List<Product> products = state.category.products.where((product) => product.title.toLowerCase().contains(searchString)).toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return buildProductListItem(
                  context,
                  product,
                  () async {
                    widget._bloc.add(TapOnProduct(product));
                    await Navigator.push(context, RouteBuilder.build(Routes.productOverviewRoute()));
                    widget._bloc.add(LoadCategory(state.category.id));
                  },
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
