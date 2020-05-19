import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/widget/group_selector/group_selector.dart';
import 'package:Blackout/widget/description_text_field/description_text_field.dart';
import 'package:Blackout/widget/ean_field/ean_field.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/refill_limit_widget/refill_limit_widget.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductBloc bloc = sl<ProductBloc>();
  final Product product;
  final List<ModelChange> changes;
  final List<Group> groups;

  ProductDetailsScreen(this.product, this.changes, this.groups, {Key key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Product _product;
  bool _errorInEan = false;
  bool _errorInRefillLimit = false;
  Key _refillLimitKey;

  @override
  void initState() {
    super.initState();
    _refillLimitKey = GlobalKey();
    _product = widget.product.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FLAppBarTitle(
          title: S.of(context).modifyProduct,
          titleStyle: TextStyle(
            fontSize: 20,
          ),
          subtitle: widget.product.hierarchy(context),
          subtitleStyle: TextStyle(
            fontSize: 15,
          ),
          layout: FLAppBarTitleLayout.vertical,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _product.isValid() && !_errorInEan && !_errorInRefillLimit && _product != widget.product
                ? () {
                    widget.bloc.add(SaveProduct(_product));
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
                child: DescriptionTextField(
                  initialValue: _product.description,
                  callback: (value) {
                    setState(() {
                      _product.description = value;
                    });
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: GroupSelector(
                  initialGroup: _product.group,
                  groups: widget.groups,
                  callback: (value) {
                    setState(() {
                      _product.group = value;
                    });
                  },
                ),
              ),
            ),
            _product.group == null
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.8),
                            child: UnitWidget(
                              initialUnit: _product.unit,
                              callback: (unit) {
                                setState(() {
                                  _product.unit = unit;
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
                                initialUnit: _product.unit,
                                initialRefillLimit: _product.refillLimit,
                                callback: (amount, error) {
                                  setState(() {
                                    _product.refillLimit = amount;
                                    setState(() {
                                      _errorInRefillLimit = error;
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 59.0,
                              child: Center(
                                child: Text(
                                  S.of(context).minimumAmount,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.8),
                child: EanField(
                  initialEan: _product.ean,
                  callback: (value, error) {
                    setState(() {
                      _product.ean = value;
                      setState(() {
                        _errorInEan = error;
                      });
                    });
                  },
                ),
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
