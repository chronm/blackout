import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/name_text_field/name_text_field.dart';
import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:Blackout/widget/plural_name_widget/plural_name_widget.dart';
import 'package:Blackout/widget/refill_limit_widget/refill_limit_widget.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatefulWidget {
  final GroupBloc bloc = sl<GroupBloc>();
  final Group group;
  final List<ModelChange> changes;

  GroupDetailsScreen(this.group, this.changes, {Key key}) : super(key: key);

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  Group _group;
  Key _refillLimitKey;
  bool _errorInPeriod = false;
  bool _errorInRefillLimit = false;

  @override
  void initState() {
    super.initState();
    _refillLimitKey = GlobalKey();
    _group = widget.group.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FLAppBarTitle(
          title: S.of(context).modifyGroup,
          titleStyle: TextStyle(
            fontSize: 20,
          ),
          layout: FLAppBarTitleLayout.vertical,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _group.isValid() && !_errorInPeriod && !_errorInRefillLimit && _group != widget.group
                ? () {
                    widget.bloc.add(SaveGroup(_group));
                    Navigator.pop(context);
                  }
                : null,
          )
        ],
      ),
      body: ScrollableContainer(
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: NameTextField(
                  initialValue: _group.name,
                  callback: (value) {
                    setState(() {
                      _group.name = value;
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
            HorizontalTextDivider(text: S.of(context).changes),
          ]..addAll(
              widget.changes
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
    );
  }
}
