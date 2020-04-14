import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/database_changelog.dart';
import 'package:Blackout/widget/category_changes/category_changes.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/name_text_field/name_text_field.dart';
import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:Blackout/widget/plural_name_widget/plural_name_widget.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryBloc bloc = sl<CategoryBloc>();
  final Category category;
  final List<DatabaseChangelog> changes;

  CategoryDetailsScreen(this.category, this.changes, {Key key}) : super(key: key);

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  Category category;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    category = widget.category.clone();
    _nameController.text = category.name;
    _nameController.addListener(() => category.name = _nameController.text);
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
            onPressed: category.isValid()
                ? () {
                    widget.bloc.add(SaveCategory(category));
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
                  initialValue: category.name,
                  callback: (name) {
                    setState(() {
                      category.name = name;
                    });
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: PluralNameWidget(
                  initialValue: category.pluralName,
                  callback: (pluralName) => category.pluralName = pluralName,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: PeriodWidget(
                  initialPeriod: category.warnInterval,
                  callback: (period) => category.warnInterval = period,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: UnitWidget(
                  initialUnit: category.unit,
                  unitCallback: (unit) {
                    setState(() {
                      category.unit = unit;
                    });
                  },
                  initialAmount: category.amount,
                  amountCallback: (amount) => category.refillLimit = amount,
                ),
              ),
            ),
            HorizontalTextDivider(text: "Changes"),
            CategoryChanges(widget.changes),
          ],
        ),
      ),
    );
  }
}
