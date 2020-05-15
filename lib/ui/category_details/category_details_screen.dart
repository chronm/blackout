import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/name_text_field/name_text_field.dart';
import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:Blackout/widget/plural_name_widget/plural_name_widget.dart';
import 'package:Blackout/widget/refill_limit_widget/refill_limit_widget.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryBloc bloc = sl<CategoryBloc>();
  final Category category;
  final List<ModelChange> changes;

  CategoryDetailsScreen(this.category, this.changes, {Key key}) : super(key: key);

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  Category _category;
  Key _refillLimitKey;
  bool _errorInPeriod = false;
  bool _errorInRefillLimit = false;

  @override
  void initState() {
    super.initState();
    _refillLimitKey = GlobalKey();
    _category = widget.category.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).modifyCategory),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _category.isValid() && !_errorInPeriod && !_errorInRefillLimit && _category != widget.category
                ? () {
                    widget.bloc.add(SaveCategory(_category));
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
                  initialValue: _category.name,
                  callback: (value) {
                    setState(() {
                      _category.name = value;
                    });
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: PluralNameWidget(
                  initialValue: _category.pluralName,
                  callback: (value) {
                    setState(() {
                      _category.pluralName = value;
                    });
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: PeriodWidget(
                  initialPeriod: _category.warnInterval,
                  callback: (period, error) {
                    setState(() {
                      _category.warnInterval = period;
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
                        initialUnit: _category.unit,
                        callback: (unit) {
                          setState(() {
                            _category.unit = unit;
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
                          initialUnit: _category.unit,
                          initialRefillLimit: _category.refillLimit,
                          callback: (amount, error) {
                            setState(() {
                              _category.refillLimit = amount;
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
