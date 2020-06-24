import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/charge.dart';

class ChangesList extends StatelessWidget {
  final Charge charge;

  const ChangesList({
    Key key,
    @required this.charge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: charge.changes.length == 0
          ? Center(
              child: Text(S.of(context).GENERAL_NOTHING_HERE),
            )
          : ListView.builder(
              itemCount: charge.changes.length,
              itemBuilder: (context, index) {
                var change = charge.changes[index];

                return Card(
                  child: ListTile(
                    title: Text(change.buildTitle(context)),
                    subtitle: Text(change.subtitle),
                  ),
                );
              },
            ),
    );
  }
}
