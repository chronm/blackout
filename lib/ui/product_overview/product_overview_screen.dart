import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

class ProductOverviewScreen extends StatefulWidget {
  final ProductBloc _bloc = sl<ProductBloc>();

  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<ProductBloc, ProductState>(
        bloc: widget._bloc,
        titleResolver: (state) {
          if (state is ShowProduct) {
            return state.product.description;
          }
          return "";
        },
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is ShowProduct) {
            return ListView.builder(
              itemCount: state.product.items.length,
              itemBuilder: (context, index) {
                Item item = state.product.items[index];
                ModelChange creation = state.changes.firstWhere((c) => c.modification == ModelChangeType.create);
                String subtitle;
                String modificationDate = creation.modificationDate.prettyPrintShortDifference(context);
                if (item.expirationDate != null) {
                  String expirationDate = item.expirationDate.prettyPrintShortDifference(context);
                  if (LocalDateTime.now() >= item.expirationDate) {
                    subtitle = "${S.of(context).createdAt(modificationDate).capitalize()} - ${S.of(context).expired(expirationDate).capitalize()}";
                  } else {
                    subtitle = "${S.of(context).createdAt(modificationDate).capitalize()} - ${S.of(context).expires(expirationDate).capitalize()}";
                  }
                } else {
                  if (item.notificationDate != null) {
                    String notificationDate = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(item.notificationDate.toDateTimeLocal());
                    subtitle = "${S.of(context).createdAt(modificationDate).capitalize()} - ${S.of(context).notify(notificationDate).capitalize()}";
                  } else {
                    subtitle = S.of(context).createdAt(modificationDate).capitalize();
                  }
                }

                return Card(
                  child: ListTile(
                    title: Text(S.of(context).available(item.scientificAmount)),
                    subtitle: Text(subtitle),
                    trailing: item.expiredOrNotification
                        ? Icon(
                            Icons.event,
                          )
                        : null,
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
