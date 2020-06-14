import 'package:Blackout/features/group/bloc/group_bloc.dart';
import 'package:Blackout/features/group/widgets/name_text_field.dart';
import 'package:Blackout/features/group/widgets/plural_name_widget.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:Blackout/widget/refill_limit_widget/refill_limit_widget.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flutter/material.dart';

typedef GroupSaveAction(Group group);

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
                    setState(() {
                      _group.name = value;
                      _errorInName = error;
                    });
                  },
                ),
                PluralNameWidget(
                  initialValue: _group.pluralName,
                  callback: (value) {
                    setState(() {
                      _group.pluralName = value;
                    });
                  },
                ),
                PeriodWidget(
                  initialPeriod: _group.warnInterval,
                  callback: (period, error) {
                    setState(() {
                      _group.warnInterval = period;
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
                          setState(() {
                            _group.refillLimit = amount;
                            _errorInRefillLimit = error;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    !widget.newGroup ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FlatButton(
                        color: Colors.redAccent,
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
                    ) : null,
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FlatButton(
                        color: Colors.redAccent,
                        child: Text(S.of(context).GENERAL_SAVE),
                        onPressed: _group.isValid() && !_errorInPeriod && !_errorInRefillLimit && !_errorInName && (_group != _oldGroup || widget.newGroup) ? () => widget.action(_group) : null,
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
