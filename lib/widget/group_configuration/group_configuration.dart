import 'package:Blackout/models/group.dart';
import 'package:Blackout/widget/name_text_field/name_text_field.dart';
import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:Blackout/widget/plural_name_widget/plural_name_widget.dart';
import 'package:Blackout/widget/refill_limit_widget/refill_limit_widget.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flutter/material.dart';

typedef GroupSaveAction(Group group);

class GroupConfiguration extends StatefulWidget {
  final Group group;
  final bool newGroup;
  final GroupSaveAction action;

  GroupConfiguration({Key key, this.group, this.newGroup = false, this.action}) : super(key: key);

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
      insetPadding: EdgeInsets.all(16.0),
      child: Material(
        child: ScrollableContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.8),
                    child: NameTextField(
                      initialValue: _group.name,
                      callback: (value, error) {
                        setState(() {
                          _group.name = value;
                          _errorInName = error;
                        });
                      },
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.8),
                    child: PluralNameWidget(
                      initialValue: _group.pluralName,
                      callback: (value) {
                        setState(() {
                          _group.pluralName = value;
                        });
                      },
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.8),
                    child: PeriodWidget(
                      initialPeriod: _group.warnInterval,
                      callback: (period, error) {
                        setState(() {
                          _group.warnInterval = period;
                          _errorInPeriod = error;
                        });
                      },
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.8),
                          child: UnitWidget(
                            initialUnit: _group.unit,
                            callback: (unit) {
                              setState(() {
                                _group.unit = unit;
                                _refillLimitKey = GlobalKey();
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.8),
                            child: RefillLimitWidget(
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.8),
                  child: FlatButton(
                    color: Colors.redAccent,
                    child: Text("save"),
                    onPressed: _group.isValid() && !_errorInPeriod && !_errorInRefillLimit && !_errorInName && (_group != _oldGroup || widget.newGroup) ? () => widget.action(_group) : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
