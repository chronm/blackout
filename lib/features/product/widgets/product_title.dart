import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../../widget/model_changes_widget/model_changes_widget.dart';
import '../../../widget/title_card/title_card.dart';
import '../cubit/product_cubit.dart';
import 'product_configuration.dart';

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
            sl<ProductCubit>().saveProduct(product);
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
