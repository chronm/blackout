import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef void GroupCallback(Group group);

class GroupSelector extends StatefulWidget {
  final Group initialGroup;
  final List<Group> groups;
  final GroupCallback callback;
  final GroupBloc bloc = sl<GroupBloc>();

  GroupSelector({Key key, this.callback, this.initialGroup, this.groups}) : super(key: key);

  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  bool _checked;
  Group _group;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialGroup != null;
    _group = widget.initialGroup;
    _controller = TextEditingController(text: _group?.title ?? "");
  }

  void invokeCallback() {
    widget.callback(_checked ? _group : null);
    _controller.text = _group?.title ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Checkable(
      initialChecked: _checked,
      checkedCallback: (context) => Expanded(
        child: TypeAheadField<Group>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
          ),
          suggestionsCallback: (pattern) async {
            Home home = await widget.bloc.blackoutPreferences.getHome();
            return await widget.bloc.groupRepository.findAllByPatternAndHomeId(pattern, home.id);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.title),
            );
          },
          onSuggestionSelected: (group) {
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
