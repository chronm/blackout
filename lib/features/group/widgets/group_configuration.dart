import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../widget/period_widget/period_widget.dart';
import '../../../widget/refill_limit_widget/refill_limit_widget.dart';
import '../../../widget/scrollable_container/scrollable_container.dart';
import '../../../widget/unit_widget/unit_widget.dart';
import '../bloc/group_bloc.dart';
import 'name_text_field.dart';
import 'plural_name_widget.dart';

typedef GroupSaveAction = Function(Group group);

class GroupConfiguration extends StatefulWidget {
  final Group group;
  final bool newGroup;
  final GroupSaveAction action;

  const GroupConfiguration({
    Key key,
    @required this.group,
    @required this.action,
    this.newGroup = false,
  }) : super(key: key);

  @override
  _GroupConfigurationState createState() => _GroupConfigurationState();
}

class _GroupConfigurationState extends State<GroupConfiguration> {
  Group _oldGroup;
  Group _group;
  Key _refillLimitKey = GlobalKey();
  bool _errorInPeriod = false;
  bool _errorInRefillLimit = false;
  bool _errorInName = false;
  bool _errorInPluralName = false;

  @override
  void initState() {
    super.initState();
    _group = widget.group.clone();
    _oldGroup = widget.group.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      child: Material(
        child: ScrollableContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                NameTextField(
                  initialValue: _group.name,
                  callback: (value, error) {
                    _group.name = value;
                    setState(() {
                      _errorInName = error;
                    });
                  },
                ),
                PluralNameWidget(
                  initialValue: _group.pluralName,
                  callback: (value, error) {
                    _group.pluralName = value;
                    setState(() {
                      _errorInPluralName = error;
                    });
                  },
                ),
                PeriodWidget(
                  initialPeriod: _group.warnInterval,
                  callback: (period, error) {
                    _group.warnInterval = period;
                    setState(() {
                      _errorInPeriod = error;
                    });
                  },
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      UnitWidget(
                        initialUnit: _group.unit,
                        callback: (unit) {
                          setState(() {
                            _group.unit = unit;
                            _refillLimitKey = GlobalKey();
                          });
                        },
                      ),
                      RefillLimitWidget(
                        key: _refillLimitKey,
                        initialUnit: _group.unit,
                        initialRefillLimit: _group.refillLimit,
                        callback: (amount, error) {
                          _group.refillLimit = amount;
                          setState(() {
                            _errorInRefillLimit = error;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    !widget.newGroup
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FlatButton(
                              color: Theme.of(context).accentColor,
                              child: Text(S.of(context).GENERAL_DELETE),
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(S.of(context).GENERAL_DELETE_CONFIRMATION),
                                    actions: [
                                      FlatButton(
                                        child: Text(S.of(context).GENERAL_DELETE_CONFIRMATION_NO),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(S.of(context).GENERAL_DELETE_CONFIRMATION_YES),
                                        onPressed: () {
                                          sl<GroupBloc>().add(TapOnDeleteGroup(widget.group));
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : null,
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FlatButton(
                        color: Theme.of(context).accentColor,
                        child: Text(S.of(context).GENERAL_SAVE),
                        onPressed: _group.isValid() && !_errorInPluralName && !_errorInPeriod && !_errorInRefillLimit && !_errorInName && (_group != _oldGroup || widget.newGroup) ? () => widget.action(_group) : null,
                      ),
                    ),
                  ].where((element) => element != null).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
