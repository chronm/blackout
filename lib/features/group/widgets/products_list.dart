import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../../util/charge_extension.dart';
import '../bloc/group_bloc.dart';

class ProductsList extends StatelessWidget {
  final Group group;
  final List<Product> products;

  const ProductsList({
    Key key,
    @required this.group,
    @required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: products.length == 0
          ? Center(
              child: Text(S.of(context).GENERAL_NOTHING_HERE),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];

                var trailing = <Widget>[];
                if (product.tooFewAvailable) {
                  trailing.add(const Icon(Icons.trending_down));
                }
                if (product.expired || product.warn) {
                  trailing.add(Icon(Icons.event, color: product.status == ChargeStatus.expired ? Theme.of(context).accentColor : null));
                }

                var status = product.buildStatus(context);

                return Hero(
                  tag: product.id,
                  flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                    child: SingleChildScrollView(
                      child: toHeroContext.widget,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      isThreeLine: status != null,
                      title: Text(product.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(product.scientificAmount)),
                          status != null ? Text(status) : null,
                        ].where((element) => element != null).toList(),
                      ),
                      trailing: Row(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () => sl<GroupBloc>().add(TapOnProduct(product, group)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
