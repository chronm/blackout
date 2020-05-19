import 'package:Blackout/models/group.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';

typedef void GroupCallback(Group group);

class GroupSelector extends StatefulWidget {
  final Group initialGroup;
  final List<Group> groups;
  final GroupCallback callback;

  GroupSelector({Key key, this.callback, this.initialGroup, this.groups}) : super(key: key);

  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  bool _checked;
  Group _group;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialGroup != null;
    _group = widget.initialGroup;
  }

  void invokeCallback() {
    widget.callback(_checked ? _group : null);
  }

  @override
  Widget build(BuildContext context) {
    return Checkable(
      initialChecked: _checked,
      checkedCallback: (context) => Expanded(
        child: DropdownButtonFormField<Group>(
          value: _group,
          decoration: InputDecoration(
            labelText: "Group",
          ),
          isExpanded: true,
          items: widget.groups
              .map(
                (c) => DropdownMenuItem<Group>(
                  value: c,
                  child: Text(c.title),
                ),
              )
              .toList(),
          onChanged: (group) {
            setState(() {
              _group = group;
            });
            invokeCallback();
          },
        ),
      ),
      uncheckedCallback: (context) => Expanded(
        child: Text(
          "Group",
          textAlign: TextAlign.center,
        ),
      ),
      callback: (checked) {
        setState(() {
          _checked = checked;
        });
        invokeCallback();
      },
    );
  }
}
