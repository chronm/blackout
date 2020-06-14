import 'package:Blackout/features/group_overview/bloc/group_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:flutter/material.dart';

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
                Product product = products[index];

                List<Widget> trailing = <Widget>[];
                if (product.tooFewAvailable) {
                  trailing.add(const Icon(Icons.trending_down));
                }
                if (product.expired || product.warn) {
                  trailing.add(Icon(Icons.event, color: product.status == ChargeStatus.expired ? Colors.redAccent : null));
                }

                String status = product.buildStatus(context);

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
