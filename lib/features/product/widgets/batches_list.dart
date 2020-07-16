import 'package:flutter/material.dart' show BuildContext, Card, Center, Column, CrossAxisAlignment, Expanded, Hero, Icon, Icons, Key, ListTile, ListView, MainAxisSize, Material, Row, SingleChildScrollView, StatelessWidget, Text, Theme, Widget, required;
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/product.dart';
import '../../../util/batch_extension.dart';
import '../../../util/string_extension.dart';
import '../bloc/product_bloc.dart';

class BatchesList extends StatelessWidget {
  final Product product;

  const BatchesList({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: product.batches.length == 0
          ? Center(
              child: Text(S.of(context).GENERAL_NOTHING_HERE),
            )
          : ListView.builder(
              itemCount: product.batches.length,
              itemBuilder: (context, index) {
                var batch = product.batches[index];

                var trailing = <Widget>[];
                if (batch.expired || batch.warn) {
                  trailing.add(Icon(Icons.event, color: batch.status == BatchStatus.expired ? Theme.of(context).accentColor : null));
                }

                var status = batch.buildStatus(context);
                var title = batch.expirationDate != null ? S.of(context).BATCH_GOOD_UNTIL(DateFormat.yMd().format(batch.expirationDate.toDateTimeUnspecified())) : S.of(context).BATCH_CREATED_AT(DateFormat.yMd().format(batch.creationDate.toDateTimeUnspecified()));

                return Hero(
                  tag: batch.id,
                  flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                    child: SingleChildScrollView(
                      child: toHeroContext.widget,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      isThreeLine: status != null,
                      title: Text(title.capitalize()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(batch.scientificAmount)),
                          status != null ? Text(status) : null,
                        ].where((element) => element != null).toList(),
                      ),
                      trailing: Row(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () => sl<ProductBloc>().add(TapOnBatch(batch)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
