import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart';

class ChangesWidget extends StatelessWidget {
  final List<ModelChange> changes;

  const ChangesWidget({Key key, this.changes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Material(
        child: ScrollableContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: changes
                  .map(
                    (c) => Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.8),
                        child: ListTile(
                          title: Text(c.toLocalizedString(context)),
                          subtitle: Text("${c.modificationDate.toString()} - ${c.user.name}"),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
