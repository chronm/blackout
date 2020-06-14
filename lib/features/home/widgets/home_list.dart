import 'package:Blackout/features/home/bloc/home_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:flutter/material.dart';

class HomeList extends StatelessWidget {
  final List<HomeListable> cards;

  HomeList({Key key, this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cards.length == 0
          ? Center(child: Text(S.of(context).GENERAL_NOTHING_HERE))
          : ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                HomeListable listable = cards[index];

                List<Widget> trailing = <Widget>[];
                if (listable.tooFewAvailable) {
                  trailing.add(
                    Icon(Icons.trending_down),
                  );
                }
                if (listable.expired || listable.warn) {
                  trailing.add(
                    Icon(
                      Icons.event,
                      color: listable.status == ChargeStatus.expired ? Colors.redAccent : null,
                    ),
                  );
                }

                String status = listable.buildStatus(context);

                return Hero(
                  tag: listable.id,
                  flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                    child: SingleChildScrollView(
                      child: toHeroContext.widget,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      isThreeLine: status != null,
                      title: Text(listable.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(listable.scientificAmount)), status != null ? Text(status) : null].where((element) => element != null).toList(),
                      ),
                      trailing: Row(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () async {
                        if (listable is Group) {
                          sl<HomeBloc>().add(TapOnGroup(listable));
                        } else if (listable is Product) {
                          sl<HomeBloc>().add(TapOnProduct(listable));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
