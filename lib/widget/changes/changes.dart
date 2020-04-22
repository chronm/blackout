import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:flutter/material.dart';

class Changes extends StatelessWidget {
  final List<ModelChange> changes;

  Changes(this.changes, {Key key}) : super(key: key);

  String getTitle(ModelChange change, BuildContext context) {
    switch (change.modification) {
      case ModelChangeType.create:
        return S.of(context).created;
      case ModelChangeType.delete:
        return S.of(context).deleted;
      case ModelChangeType.modify:
        return change.modifications.map((m) {
          if (m.from != "" && m.to == "") {
            return S.of(context).disabledField(m.fieldName, m.from);
          }
          if (m.from == "" && m.to != "") {
            return S.of(context).enabledField(m.fieldName, m.to);
          }
          return S.of(context).modifiedField(m.fieldName, m.from, m.to);
        }).join("\n");
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: changes.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(8.8),
              child: ListTile(
                title: Text(changes[index].toLocalizedString(context)),
                subtitle: Text("${changes[index].modificationDate.toString()} - ${changes[index].user.name}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
