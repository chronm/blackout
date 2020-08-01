import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/home_card.dart';
import '../../../models/product.dart';
import '../../../util/batch_extension.dart';
import '../cubit/home_cubit.dart';

class HomeList extends StatelessWidget {
  final List<HomeCard> cards;

  const HomeList({
    Key key,
    @required this.cards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cards.length == 0
          ? Center(child: Text(S.of(context).GENERAL_NOTHING_HERE))
          : ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                var card = cards[index];

                var trailing = <Widget>[];
                if (card.tooFewAvailable) {
                  trailing.add(const Icon(Icons.trending_down));
                }
                if (card.expired || card.warn) {
                  trailing.add(Icon(Icons.event, color: card.status == BatchStatus.expired ? Theme.of(context).accentColor : null));
                }

                var status = card.buildStatus(context);

                return Hero(
                  tag: card.id,
                  flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                    child: SingleChildScrollView(
                      child: toHeroContext.widget,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      isThreeLine: status != null,
                      title: Text(card.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(card.scientificAmount)), status != null ? Text(status) : null].where((element) => element != null).toList(),
                      ),
                      trailing: Row(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () async {
                        if (card is Group) {
                          sl<HomeCubit>().tapOnGroup(card);
                        } else if (card is Product) {
                          sl<HomeCubit>().tapOnProduct(card);
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
