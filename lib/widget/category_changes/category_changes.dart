import 'package:Blackout/models/database_changelog.dart';
import 'package:flutter/material.dart';

class CategoryChanges extends StatelessWidget {
  final List<DatabaseChangelog> changes;

  CategoryChanges(this.changes, {Key key}) : super(key: key);

  String getTitle(DatabaseChangelog change) {
    switch (change.modification) {
      case ChangelogModification.create:
        return "Created";
      case ChangelogModification.delete:
        return "Deleted";
      case ChangelogModification.modify:
        return "Change ${change.fieldName} from ${change.from} to ${change.to}";
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
                title: Text(getTitle(changes[index])),
                subtitle: Text(
                    "${changes[index].modificationDate.toString()} - ${changes[index].user.name}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
