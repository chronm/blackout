import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(c.toLocalizedString(context)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.date_range),

                                  Text("${DateFormat.yMd().format(c.modificationDate.toDateTimeUnspecified())}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.person),
                                  Text("${c.user.name}"),
                                ],
                              ),
                            ],
                          ),
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
