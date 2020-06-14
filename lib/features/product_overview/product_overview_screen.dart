import 'package:Blackout/features/blackout_drawer/blackout_drawer.dart';
import 'package:Blackout/features/product_overview/widgets/charges_list.dart';
import 'package:Blackout/features/product_overview/widgets/product_dial.dart';
import 'package:Blackout/features/product_overview/widgets/product_title.dart';
import 'package:Blackout/features/speeddial/bloc/speed_dial_bloc.dart';
import 'package:Blackout/features/speeddial/speeddial.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/features/product_overview/bloc/product_bloc.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart'
    show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Navigator, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      bloc: sl<ProductBloc>(),
      listener: (context, state) async {
        if (state is GoToCharge) {
          await Navigator.push(context, RouteBuilder.build(Routes.ChargeOverviewRoute));
          sl<ProductBloc>().add(LoadProduct(state.currentProduct));
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
                Product product = state.product;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ProductTitle(
                      scaffold: _scaffold,
                      product: product,
                      groups: state.groups,
                    ),
                    HorizontalTextDivider(
                      text: S.of(context).UNITS,
                    ),
                    ChargesList(
                      product: product,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: ProductDial(),
      ),
    );
  }
}
