import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/widget/loading_search_bar/loading_search_bar.dart';
import 'package:flutter/material.dart';
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
      appBar: LoadingSearchBar<CategoryBloc, CategoryState>(
        titleResolver: (state) {
          if (state is ShowCategory) {
            return state.category.title;
          }
          return "";
        },
        titleCallback: () {
          print("asdf");
        },
        bloc: widget._bloc,
        callback: (search) {
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
                if (product.state.expiredOrNotification) {
                  trailing.add(
                    Icon(
                      Icons.event,
                    ),
                  );
                }
                if (product.state.tooFewAvailable) {
                  trailing.add(
                    Icon(
                      Icons.trending_down,
                    ),
                  );
                }

                return Card(
                  child: ListTile(
                    title: Text(
                      product.title,
                    ),
                    subtitle: Text(
                      S.of(context).available(product.scaledAmount),
                    ),
                    trailing: Column(
                      children: trailing,
                      mainAxisSize: MainAxisSize.min,
                    ),
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
