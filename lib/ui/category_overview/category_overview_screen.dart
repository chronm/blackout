import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Container, Icon, Icons, Key, ListTile, ListView, Navigator, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter/widgets.dart' show BuildContext, Column, Container, Icon, Key, ListView, MainAxisSize, Navigator, State, StatefulWidget, Text, Widget;
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
        titleResolver: (state) => state is ShowCategory ? state.category.title : "",
        titleCallback: (state) {
          if (state is ShowCategory) {
            Navigator.push(context, RouteBuilder.build(Routes.categoryDetailsRoute(category: state.category, changes: state.category.modelChanges)));
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

                return Card(
                  child: ListTile(
                    title: Text(product.title),
                    subtitle: Text(S.of(context).available(product.subtitle)),
                    trailing: Column(
                      children: trailing,
                      mainAxisSize: MainAxisSize.min,
                    ),
                    onTap: () async {
                      widget._bloc.add(TapOnProduct(product));
                      await Navigator.push(context, RouteBuilder.build(Routes.productOverviewRoute()));
                      widget._bloc.add(LoadCategory(state.category.id));
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
