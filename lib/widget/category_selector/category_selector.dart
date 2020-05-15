import 'package:Blackout/models/category.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';

typedef void CategoryCallback(Category category);

class CategorySelector extends StatefulWidget {
  final Category initialCategory;
  final List<Category> categories;
  final CategoryCallback callback;

  CategorySelector({Key key, this.callback, this.initialCategory, this.categories}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  bool _checked;
  Category _category;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialCategory != null;
    _category = widget.initialCategory;
  }

  void invokeCallback() {
    widget.callback(_checked ? _category : null);
  }

  @override
  Widget build(BuildContext context) {
    return Checkable(
      initialChecked: _checked,
      checkedCallback: (context) => Expanded(
        child: DropdownButtonFormField<Category>(
          value: _category,
          decoration: InputDecoration(
            labelText: "Category",
          ),
          isExpanded: true,
          items: widget.categories
              .map(
                (c) => DropdownMenuItem<Category>(
                  value: c,
                  child: Text(c.title),
                ),
              )
              .toList(),
          onChanged: (category) {
            setState(() {
              _category = category;
            });
            invokeCallback();
          },
        ),
      ),
      uncheckedCallback: (context) => Expanded(
        child: Text(
          "Category",
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
