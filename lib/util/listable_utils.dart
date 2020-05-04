import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/listable.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

List<Widget> getTrailing(Listable listable) {
  List<Widget> trailing = <Widget>[];
  if (listable.expiredOrNotification) {
    trailing.add(
      Icon(
        Icons.event,
      ),
    );
  }
  if (listable.tooFewAvailable) {
    trailing.add(
      Icon(
        Icons.trending_down,
      ),
    );
  }
  return trailing;
}

Widget buildListableListItem(BuildContext context, Listable listable, GestureTapCallback callback) {
  return Card(
    child: ListTile(
      title: Text(listable.title),
      subtitle: Text(S.of(context).available(listable.scientificAmount)),
      trailing: Column(
        children: getTrailing(listable),
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: callback,
    ),
  );
}

Widget buildProductListItem(BuildContext context, Product product, GestureTapCallback callback) {
  return buildListableListItem(context, product, callback);
}

Widget buildItemListItem(BuildContext context, Item item, List<ModelChange> changes, GestureTapCallback callback) {
  String subtitle;
  ModelChange creation = changes.firstWhere((c) => c.modification == ModelChangeType.create);
  String creationDate = creation.modificationDate.prettyPrintShortDifference(context);
  if (item.expirationDate != null) {
    String expirationDate = item.expirationDate.prettyPrintShortDifference(context);
    if (LocalDateTime.now() >= item.expirationDate) {
      subtitle = "${S.of(context).createdAt(creationDate).capitalize()} - ${S.of(context).expired(expirationDate).capitalize()}";
    } else {
      subtitle = "${S.of(context).createdAt(creationDate).capitalize()} - ${S.of(context).expires(expirationDate).capitalize()}";
    }
  } else {
    if (item.notificationDate != null) {
      String notificationDate = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(item.notificationDate.toDateTimeLocal());
      subtitle = "${S.of(context).createdAt(creationDate).capitalize()} - ${S.of(context).notify(notificationDate).capitalize()}";
    } else {
      subtitle = S.of(context).createdAt(creationDate).capitalize();
    }
  }

  return Card(
    child: ListTile(
      title: Text(S.of(context).available(item.title)),
      subtitle: Text(subtitle),
      trailing: Column(
        children: getTrailing(item),
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: callback,
    ),
  );
}
