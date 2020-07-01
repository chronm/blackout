import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/batch.dart';

class ChangesList extends StatelessWidget {
  final Batch batch;

  const ChangesList({
    Key key,
    @required this.batch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: batch.changes.length == 0
          ? Center(
              child: Text(S.of(context).GENERAL_NOTHING_HERE),
            )
          : ListView.builder(
              itemCount: batch.changes.length,
              itemBuilder: (context, index) {
                var change = batch.changes[index];

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
