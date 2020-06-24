import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Center,
        Column,
        CrossAxisAlignment,
        Expanded,
        Hero,
        Icon,
        Icons,
        Key,
        ListTile,
        ListView,
        MainAxisSize,
        Material,
        Row,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        required;
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/product.dart';
import '../../../util/charge_extension.dart';
import '../../../util/string_extension.dart';
import '../bloc/product_bloc.dart';

class ChargesList extends StatelessWidget {
  final Product product;

  const ChargesList({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: product.charges.length == 0
          ? Center(
              child: Text(S.of(context).GENERAL_NOTHING_HERE),
            )
          : ListView.builder(
              itemCount: product.charges.length,
              itemBuilder: (context, index) {
                var charge = product.charges[index];

                var trailing = <Widget>[];
                if (charge.expired || charge.warn) {
                  trailing.add(Icon(Icons.event,
                      color: charge.status == ChargeStatus.expired
                          ? Theme.of(context).accentColor
                          : null));
                }

                var status = charge.buildStatus(context);

                return Hero(
                  tag: charge.id,
                  flightShuttleBuilder: (context, animation, flightDirection,
                          fromHeroContext, toHeroContext) =>
                      Material(
                    child: SingleChildScrollView(
                      child: toHeroContext.widget,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      isThreeLine: status != null,
                      title: Text(S
                          .of(context)
                          .UNIT_CREATED_AT(DateFormat.yMd().format(
                              charge.creationDate.toDateTimeUnspecified()))
                          .capitalize()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(
                              charge.scientificAmount)),
                          status != null ? Text(status) : null,
                        ].where((element) => element != null).toList(),
                      ),
                      trailing: Row(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () => sl<ProductBloc>().add(TapOnCharge(charge)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
