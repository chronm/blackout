import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/home_listable.dart';
import '../../../models/product.dart';
import '../../../util/batch_extension.dart';
import '../bloc/home_bloc.dart';

class HomeList extends StatelessWidget {
  final List<HomeListable> cards;

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
                var listable = cards[index];

                var trailing = <Widget>[];
                if (listable.tooFewAvailable) {
                  trailing.add(const Icon(Icons.trending_down));
                }
                if (listable.expired || listable.warn) {
                  trailing.add(Icon(Icons.event, color: listable.status == BatchStatus.expired ? Theme.of(context).accentColor : null));
                }

                var status = listable.buildStatus(context);

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
