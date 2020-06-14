import 'package:Blackout/features/product/bloc/product_bloc.dart';
import 'package:Blackout/features/product/widgets/product_configuration.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/widget/model_changes_widget/model_changes_widget.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final Product product;
  final List<Group> groups;

  ProductTitle({
    Key key,
    @required this.scaffold,
    @required this.product,
    @required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleCard(
      scaffold: scaffold,
      title: product.title,
      tag: product.id,
      trendingDown: product.tooFewAvailable ? S.of(context).GENERAL_LESS_THAN_AVAILABLE(product.scientificRefillLimit) : null,
      available: S.of(context).GENERAL_AMOUNT_AVAILABLE(product.scientificAmount),
      event: product.buildStatus(context),
      groupName: product.group != null ? product.group.title : null,
      modifyAction: () => showDialog(
        context: context,
        builder: (context) => ProductConfiguration(
          product: product,
          groups: groups,
          action: (product) {
            Navigator.pop(context);
            sl<ProductBloc>().add(SaveProduct(product));
          },
        ),
      ),
      changesAction: () => showDialog(
        context: context,
        builder: (context) => ModelChangesWidget(changes: product.modelChanges),
      ),
    );
  }
}
