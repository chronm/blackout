import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../../widget/period_widget/period_widget.dart';
import '../../../widget/refill_limit_widget/refill_limit_widget.dart';
import '../../../widget/scrollable_container/scrollable_container.dart';
import '../../../widget/unit_widget/unit_widget.dart';
import '../bloc/product_bloc.dart';
import 'description_text_field.dart';
import 'ean_field.dart';
import 'group_selector.dart';

typedef ProductSaveAction = Function(Product product);

class ProductConfiguration extends StatefulWidget {
  final Product product;
  final List<Group> groups;
  final bool newProduct;
  final ProductSaveAction action;

  const ProductConfiguration({
    Key key,
    @required this.product,
    @required this.groups,
    @required this.action,
    this.newProduct = false,
  }) : super(key: key);

  @override
  _ProductConfigurationState createState() => _ProductConfigurationState();
}

class _ProductConfigurationState extends State<ProductConfiguration> {
  Product _oldProduct;
  Product _product;
  bool _errorInDescription = false;
  bool _errorInEan = false;
  bool _errorInRefillLimit = false;
  bool _errorInPeriod = false;
  Key _refillLimitKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _product = widget.product.clone();
    _oldProduct = _product.clone();
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
              mainAxisSize: MainAxisSize.min,
              children: [
                DescriptionTextField(
                  initialValue: widget.product.description,
                  callback: (value, error) {
                    _product.description = value;
                    setState(() {
                      _errorInDescription = error;
                    });
                  },
                ),
                GroupSelector(
                  initialGroup: _product.group,
                  groups: widget.groups,
                  callback: (value) {
                    setState(() {
                      _product.group = value;
                    });
                  },
                ),
                _product.group == null
                    ? PeriodWidget(
                        initialPeriod: _product.warnInterval,
                        callback: (period, error) {
                          setState(() {
                            _errorInPeriod = error;
                            _product.warnInterval = period;
                          });
                        },
                      )
                    : null,
                _product.group == null
                    ? IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            UnitWidget(
                              initialUnit: _product.unit,
                              callback: (unit) {
                                setState(() {
                                  _product.unit = unit;
                                  _refillLimitKey = GlobalKey();
                                });
                              },
                            ),
                            RefillLimitWidget(
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
                          ],
                        ),
                      )
                    : null,
                EanField(
                  initialEan: _product.ean,
                  callback: (value, error) {
                    setState(() {
                      _product.ean = value;
                      _errorInEan = error;
                    });
                  },
                ),
                Row(
                  children: [
                    !widget.newProduct ? Padding(
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
                                    sl<ProductBloc>().add(TapOnDeleteProduct(widget.product));
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
                        color: Theme.of(context).accentColor,
                        child: Text(S.of(context).GENERAL_SAVE),
                        onPressed: _product.isValid() && !_errorInDescription && !_errorInPeriod && !_errorInEan && !_errorInRefillLimit && (_product != _oldProduct || widget.newProduct) ? () => widget.action(_product) : null,
                      ),
                    ),
                  ].where((element) => element != null).toList(),
                ),
              ].where((element) => element != null).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
