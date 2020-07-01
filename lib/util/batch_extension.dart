import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

import '../generated/l10n.dart';
import '../models/batch.dart';
import '../models/model_change.dart';
import '../models/unit/unit.dart';
import 'string_extension.dart';
import 'time_machine_extension.dart';

enum BatchStatus {
  none,
  warn,
  expired,
}

extension BatchExtension on Batch {
  LocalDate get creationDate {
    return modelChanges.firstWhere((element) => element.modification == ModelChangeType.create).modificationDate;
  }

  String get scientificAmount => UnitConverter.toScientific(Amount(amount, Unit.fromSi(product.group != null ? product.group.unit : product.unit))).toString();

  UnitEnum get unit => product.unit;

  double get amount => changes.length != 0 ? changes.map((c) => c.value).reduce((a, b) => a + b) : 0;

  bool get expired {
    return expirationDate != null ? expirationDate <= LocalDate.today() : false;
  }

  bool get warn {
    if (product.group?.warnInterval != null) {
      return expirationDate != null ? expirationDate.subtract(product.group.warnInterval) <= LocalDate.today() : false;
    }
    if (product.warnInterval != null) {
      return expirationDate != null ? expirationDate.subtract(product.warnInterval) <= LocalDate.today() : false;
    }
    return false;
  }

  BatchStatus get status {
    if (expired) return BatchStatus.expired;
    if (warn) return BatchStatus.warn;
    return BatchStatus.none;
  }

  String buildStatus(BuildContext context) {
    if (expired) {
      return S.of(context).GENERAL_EXPIRED_AGO(expirationDate.prettyPrintShortDifference(context)).capitalize();
    }
    if (warn) {
      return S.of(context).GENERAL_EXPIRES_IN(expirationDate.prettyPrintShortDifference(context)).capitalize();
    }
    if (expirationDate != null) {
      return S.of(context).GENERAL_EXPIRES_IN(expirationDate.prettyPrintShortDifference(context)).capitalize();
    } else {
      return null;
    }
  }
}
