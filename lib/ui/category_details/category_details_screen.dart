import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/model_change.dart';
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
  final List<ModelChange> changes;

  CategoryDetailsScreen(this.category, this.changes, {Key key}) : super(key: key);

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  Category category;
  TextEditingController _nameController = TextEditingController();
  bool valid = true;

  @override
  void initState() {
    super.initState();
    category = widget.category.clone();
    _nameController.text = category.name;
    _nameController.addListener(() => category.name = _nameController.text.trim());
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
            onPressed: category.isValid() && valid && category != widget.category
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
                  callback: (period) {
                    if (period != null) {
                      category.warnInterval = period;
                      setState(() {
                        valid = true;
                      });
                    } else {
                      setState(() {
                        valid = false;
                      });
                    }
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: UnitWidget(
                  initialUnit: category.unit,
                  unitCallback: (unit, amount, checked) {
                    setState(() {
                      category.unit = unit;
                      category.refillLimit = checked ? amount : null;
                      if (amount != null || checked == false) {
                        valid = true;
                      } else {
                        valid = false;
                      }
                    });
                  },
                  initialRefillLimit: category.refillLimit,
                ),
              ),
            ),
            HorizontalTextDivider(text: "Changes"),
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
