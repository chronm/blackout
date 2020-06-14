import 'package:Blackout/features/product_overview/bloc/product_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Colors, Column, CrossAxisAlignment, Expanded, Hero, Icon, Icons, Key, ListTile, ListView, MainAxisSize, Material, Navigator, Row, SingleChildScrollView, StatelessWidget, Text, Widget, required;
import 'package:intl/intl.dart';

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
                Charge charge = product.charges[index];

                List<Widget> trailing = <Widget>[];
                if (charge.expired || charge.warn) {
                  trailing.add(Icon(Icons.event, color: charge.status == ChargeStatus.expired ? Colors.redAccent : null));
                }

                String status = charge.buildStatus(context);

                return Hero(
                  tag: charge.id,
                  flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                    child: SingleChildScrollView(
                      child: toHeroContext.widget,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      isThreeLine: status != null,
                      title: Text(S.of(context).UNIT_CREATED_AT(DateFormat.yMd().format(charge.creationDate.toDateTimeUnspecified())).capitalize()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(charge.scientificAmount)),
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
