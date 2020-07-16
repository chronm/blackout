import 'package:flutter/material.dart' show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Navigator, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../routes.dart';
import '../../widget/horizontal_text_divider/horizontal_text_divider.dart';
import '../../widget/scrollable_container/scrollable_container.dart';
import '../blackout_drawer/blackout_drawer.dart';
import 'bloc/product_bloc.dart';
import 'widgets/batches_list.dart';
import 'widgets/product_dial.dart';
import 'widgets/product_title.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      bloc: sl<ProductBloc>(),
      listener: (context, state) async {
        if (state is GoToBatch) {
          await Navigator.pushNamed(context, Routes.batch);
          sl<ProductBloc>().add(Redraw());
        }
        if (state is GoBack) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        key: _scaffold,
        drawer: BlackoutDrawer(),
        body: ScrollableContainer(
          fullscreen: true,
          child: BlocBuilder<ProductBloc, ProductState>(
            bloc: sl<ProductBloc>(),
            builder: (context, state) {
              if (state is ShowProduct) {
                var product = state.product;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ProductTitle(
                      scaffold: _scaffold,
                      product: product,
                      groups: state.groups,
                    ),
                    HorizontalTextDivider(
                      text: S.of(context).BATCHES,
                    ),
                    BatchesList(
                      product: product,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: const ProductDial(),
      ),
    );
  }
}
