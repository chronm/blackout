// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ChargeEntry extends DataClass implements Insertable<ChargeEntry> {
  final String id;
  final String productId;
  final DateTime expirationDate;
  ChargeEntry({@required this.id, @required this.productId, this.expirationDate});
  factory ChargeEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ChargeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      expirationDate: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}expiration_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    return map;
  }

  ChargeTableCompanion toCompanion(bool nullToAbsent) {
    return ChargeTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productId: productId == null && nullToAbsent ? const Value.absent() : Value(productId),
      expirationDate: expirationDate == null && nullToAbsent ? const Value.absent() : Value(expirationDate),
    );
  }

  factory ChargeEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ChargeEntry(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      expirationDate: serializer.fromJson<DateTime>(json['expirationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'expirationDate': serializer.toJson<DateTime>(expirationDate),
    };
  }

  ChargeEntry copyWith({String id, String productId, DateTime expirationDate}) => ChargeEntry(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        expirationDate: expirationDate ?? this.expirationDate,
      );
  @override
  String toString() {
    return (StringBuffer('ChargeEntry(')..write('id: $id, ')..write('productId: $productId, ')..write('expirationDate: $expirationDate')..write(')')).toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(productId.hashCode, expirationDate.hashCode)));
  @override
  bool operator ==(dynamic other) => identical(this, other) || (other is ChargeEntry && other.id == this.id && other.productId == this.productId && other.expirationDate == this.expirationDate);
}

class ChargeTableCompanion extends UpdateCompanion<ChargeEntry> {
  final Value<String> id;
  final Value<String> productId;
  final Value<DateTime> expirationDate;
  const ChargeTableCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.expirationDate = const Value.absent(),
  });
  ChargeTableCompanion.insert({
    @required String id,
    @required String productId,
    this.expirationDate = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId);
  static Insertable<ChargeEntry> custom({
    Expression<String> id,
    Expression<String> productId,
    Expression<DateTime> expirationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (expirationDate != null) 'expiration_date': expirationDate,
    });
  }

  ChargeTableCompanion copyWith({Value<String> id, Value<String> productId, Value<DateTime> expirationDate}) {
    return ChargeTableCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    return map;
  }
}

class $ChargeTableTable extends ChargeTable with TableInfo<$ChargeTableTable, ChargeEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ChargeTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedTextColumn _productId;
  @override
  GeneratedTextColumn get productId => _productId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn('product_id', $tableName, false, $customConstraints: 'references ProductTable(id)');
  }

  final VerificationMeta _expirationDateMeta = const VerificationMeta('expirationDate');
  GeneratedDateTimeColumn _expirationDate;
  @override
  GeneratedDateTimeColumn get expirationDate => _expirationDate ??= _constructExpirationDate();
  GeneratedDateTimeColumn _constructExpirationDate() {
    return GeneratedDateTimeColumn(
      'expiration_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, productId, expirationDate];
  @override
  $ChargeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'charge_table';
  @override
  final String actualTableName = 'charge_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChargeEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('expiration_date')) {
      context.handle(_expirationDateMeta, expirationDate.isAcceptableOrUnknown(data['expiration_date'], _expirationDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChargeEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ChargeEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ChargeTableTable createAlias(String alias) {
    return $ChargeTableTable(_db, alias);
  }
}

class ProductEntry extends DataClass implements Insertable<ProductEntry> {
  final String id;
  final String ean;
  final String groupId;
  final String description;
  final String warnInterval;
  final String homeId;
  final double refillLimit;
  final int unit;
  ProductEntry({@required this.id, this.ean, this.groupId, @required this.description, this.warnInterval, @required this.homeId, this.refillLimit, this.unit});
  factory ProductEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return ProductEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ean: stringType.mapFromDatabaseResponse(data['${effectivePrefix}ean']),
      groupId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}group_id']),
      description: stringType.mapFromDatabaseResponse(data['${effectivePrefix}description']),
      warnInterval: stringType.mapFromDatabaseResponse(data['${effectivePrefix}warn_interval']),
      homeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
      refillLimit: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}refill_limit']),
      unit: intType.mapFromDatabaseResponse(data['${effectivePrefix}unit']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || ean != null) {
      map['ean'] = Variable<String>(ean);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || warnInterval != null) {
      map['warn_interval'] = Variable<String>(warnInterval);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    if (!nullToAbsent || refillLimit != null) {
      map['refill_limit'] = Variable<double>(refillLimit);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<int>(unit);
    }
    return map;
  }

  ProductTableCompanion toCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ean: ean == null && nullToAbsent ? const Value.absent() : Value(ean),
      groupId: groupId == null && nullToAbsent ? const Value.absent() : Value(groupId),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
      warnInterval: warnInterval == null && nullToAbsent ? const Value.absent() : Value(warnInterval),
      homeId: homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
      refillLimit: refillLimit == null && nullToAbsent ? const Value.absent() : Value(refillLimit),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  factory ProductEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductEntry(
      id: serializer.fromJson<String>(json['id']),
      ean: serializer.fromJson<String>(json['ean']),
      groupId: serializer.fromJson<String>(json['groupId']),
      description: serializer.fromJson<String>(json['description']),
      warnInterval: serializer.fromJson<String>(json['warnInterval']),
      homeId: serializer.fromJson<String>(json['homeId']),
      refillLimit: serializer.fromJson<double>(json['refillLimit']),
      unit: serializer.fromJson<int>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ean': serializer.toJson<String>(ean),
      'groupId': serializer.toJson<String>(groupId),
      'description': serializer.toJson<String>(description),
      'warnInterval': serializer.toJson<String>(warnInterval),
      'homeId': serializer.toJson<String>(homeId),
      'refillLimit': serializer.toJson<double>(refillLimit),
      'unit': serializer.toJson<int>(unit),
    };
  }

  ProductEntry copyWith({String id, String ean, String groupId, String description, String warnInterval, String homeId, double refillLimit, int unit}) => ProductEntry(
        id: id ?? this.id,
        ean: ean ?? this.ean,
        groupId: groupId ?? this.groupId,
        description: description ?? this.description,
        warnInterval: warnInterval ?? this.warnInterval,
        homeId: homeId ?? this.homeId,
        refillLimit: refillLimit ?? this.refillLimit,
        unit: unit ?? this.unit,
      );
  @override
  String toString() {
    return (StringBuffer('ProductEntry(')..write('id: $id, ')..write('ean: $ean, ')..write('groupId: $groupId, ')..write('description: $description, ')..write('warnInterval: $warnInterval, ')..write('homeId: $homeId, ')..write('refillLimit: $refillLimit, ')..write('unit: $unit')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(ean.hashCode, $mrjc(groupId.hashCode, $mrjc(description.hashCode, $mrjc(warnInterval.hashCode, $mrjc(homeId.hashCode, $mrjc(refillLimit.hashCode, unit.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductEntry && other.id == this.id && other.ean == this.ean && other.groupId == this.groupId && other.description == this.description && other.warnInterval == this.warnInterval && other.homeId == this.homeId && other.refillLimit == this.refillLimit && other.unit == this.unit);
}

class ProductTableCompanion extends UpdateCompanion<ProductEntry> {
  final Value<String> id;
  final Value<String> ean;
  final Value<String> groupId;
  final Value<String> description;
  final Value<String> warnInterval;
  final Value<String> homeId;
  final Value<double> refillLimit;
  final Value<int> unit;
  const ProductTableCompanion({
    this.id = const Value.absent(),
    this.ean = const Value.absent(),
    this.groupId = const Value.absent(),
    this.description = const Value.absent(),
    this.warnInterval = const Value.absent(),
    this.homeId = const Value.absent(),
    this.refillLimit = const Value.absent(),
    this.unit = const Value.absent(),
  });
  ProductTableCompanion.insert({
    @required String id,
    this.ean = const Value.absent(),
    this.groupId = const Value.absent(),
    @required String description,
    this.warnInterval = const Value.absent(),
    @required String homeId,
    this.refillLimit = const Value.absent(),
    this.unit = const Value.absent(),
  })  : id = Value(id),
        description = Value(description),
        homeId = Value(homeId);
  static Insertable<ProductEntry> custom({
    Expression<String> id,
    Expression<String> ean,
    Expression<String> groupId,
    Expression<String> description,
    Expression<String> warnInterval,
    Expression<String> homeId,
    Expression<double> refillLimit,
    Expression<int> unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ean != null) 'ean': ean,
      if (groupId != null) 'group_id': groupId,
      if (description != null) 'description': description,
      if (warnInterval != null) 'warn_interval': warnInterval,
      if (homeId != null) 'home_id': homeId,
      if (refillLimit != null) 'refill_limit': refillLimit,
      if (unit != null) 'unit': unit,
    });
  }

  ProductTableCompanion copyWith({Value<String> id, Value<String> ean, Value<String> groupId, Value<String> description, Value<String> warnInterval, Value<String> homeId, Value<double> refillLimit, Value<int> unit}) {
    return ProductTableCompanion(
      id: id ?? this.id,
      ean: ean ?? this.ean,
      groupId: groupId ?? this.groupId,
      description: description ?? this.description,
      warnInterval: warnInterval ?? this.warnInterval,
      homeId: homeId ?? this.homeId,
      refillLimit: refillLimit ?? this.refillLimit,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ean.present) {
      map['ean'] = Variable<String>(ean.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (warnInterval.present) {
      map['warn_interval'] = Variable<String>(warnInterval.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    if (refillLimit.present) {
      map['refill_limit'] = Variable<double>(refillLimit.value);
    }
    if (unit.present) {
      map['unit'] = Variable<int>(unit.value);
    }
    return map;
  }
}

class $ProductTableTable extends ProductTable with TableInfo<$ProductTableTable, ProductEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _eanMeta = const VerificationMeta('ean');
  GeneratedTextColumn _ean;
  @override
  GeneratedTextColumn get ean => _ean ??= _constructEan();
  GeneratedTextColumn _constructEan() {
    return GeneratedTextColumn('ean', $tableName, true, $customConstraints: 'unique');
  }

  final VerificationMeta _groupIdMeta = const VerificationMeta('groupId');
  GeneratedTextColumn _groupId;
  @override
  GeneratedTextColumn get groupId => _groupId ??= _constructGroupId();
  GeneratedTextColumn _constructGroupId() {
    return GeneratedTextColumn('group_id', $tableName, true, $customConstraints: 'null references GroupTable(id)');
  }

  final VerificationMeta _descriptionMeta = const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description => _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false, $customConstraints: 'unique');
  }

  final VerificationMeta _warnIntervalMeta = const VerificationMeta('warnInterval');
  GeneratedTextColumn _warnInterval;
  @override
  GeneratedTextColumn get warnInterval => _warnInterval ??= _constructWarnInterval();
  GeneratedTextColumn _constructWarnInterval() {
    return GeneratedTextColumn(
      'warn_interval',
      $tableName,
      true,
    );
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false, $customConstraints: 'references Home(id)');
  }

  final VerificationMeta _refillLimitMeta = const VerificationMeta('refillLimit');
  GeneratedRealColumn _refillLimit;
  @override
  GeneratedRealColumn get refillLimit => _refillLimit ??= _constructRefillLimit();
  GeneratedRealColumn _constructRefillLimit() {
    return GeneratedRealColumn(
      'refill_limit',
      $tableName,
      true,
    );
  }

  final VerificationMeta _unitMeta = const VerificationMeta('unit');
  GeneratedIntColumn _unit;
  @override
  GeneratedIntColumn get unit => _unit ??= _constructUnit();
  GeneratedIntColumn _constructUnit() {
    return GeneratedIntColumn(
      'unit',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, ean, groupId, description, warnInterval, homeId, refillLimit, unit];
  @override
  $ProductTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_table';
  @override
  final String actualTableName = 'product_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ean')) {
      context.handle(_eanMeta, ean.isAcceptableOrUnknown(data['ean'], _eanMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta, groupId.isAcceptableOrUnknown(data['group_id'], _groupIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('warn_interval')) {
      context.handle(_warnIntervalMeta, warnInterval.isAcceptableOrUnknown(data['warn_interval'], _warnIntervalMeta));
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta, homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    if (data.containsKey('refill_limit')) {
      context.handle(_refillLimitMeta, refillLimit.isAcceptableOrUnknown(data['refill_limit'], _refillLimitMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(_unitMeta, unit.isAcceptableOrUnknown(data['unit'], _unitMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(_db, alias);
  }
}

class GroupEntry extends DataClass implements Insertable<GroupEntry> {
  final String id;
  final String name;
  final String pluralName;
  final String warnInterval;
  final String homeId;
  final double refillLimit;
  final int unit;
  GroupEntry({@required this.id, @required this.name, this.pluralName, this.warnInterval, @required this.homeId, this.refillLimit, @required this.unit});
  factory GroupEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return GroupEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      pluralName: stringType.mapFromDatabaseResponse(data['${effectivePrefix}plural_name']),
      warnInterval: stringType.mapFromDatabaseResponse(data['${effectivePrefix}warn_interval']),
      homeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
      refillLimit: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}refill_limit']),
      unit: intType.mapFromDatabaseResponse(data['${effectivePrefix}unit']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || pluralName != null) {
      map['plural_name'] = Variable<String>(pluralName);
    }
    if (!nullToAbsent || warnInterval != null) {
      map['warn_interval'] = Variable<String>(warnInterval);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    if (!nullToAbsent || refillLimit != null) {
      map['refill_limit'] = Variable<double>(refillLimit);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<int>(unit);
    }
    return map;
  }

  GroupTableCompanion toCompanion(bool nullToAbsent) {
    return GroupTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      pluralName: pluralName == null && nullToAbsent ? const Value.absent() : Value(pluralName),
      warnInterval: warnInterval == null && nullToAbsent ? const Value.absent() : Value(warnInterval),
      homeId: homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
      refillLimit: refillLimit == null && nullToAbsent ? const Value.absent() : Value(refillLimit),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  factory GroupEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return GroupEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pluralName: serializer.fromJson<String>(json['pluralName']),
      warnInterval: serializer.fromJson<String>(json['warnInterval']),
      homeId: serializer.fromJson<String>(json['homeId']),
      refillLimit: serializer.fromJson<double>(json['refillLimit']),
      unit: serializer.fromJson<int>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'pluralName': serializer.toJson<String>(pluralName),
      'warnInterval': serializer.toJson<String>(warnInterval),
      'homeId': serializer.toJson<String>(homeId),
      'refillLimit': serializer.toJson<double>(refillLimit),
      'unit': serializer.toJson<int>(unit),
    };
  }

  GroupEntry copyWith({String id, String name, String pluralName, String warnInterval, String homeId, double refillLimit, int unit}) => GroupEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        pluralName: pluralName ?? this.pluralName,
        warnInterval: warnInterval ?? this.warnInterval,
        homeId: homeId ?? this.homeId,
        refillLimit: refillLimit ?? this.refillLimit,
        unit: unit ?? this.unit,
      );
  @override
  String toString() {
    return (StringBuffer('GroupEntry(')..write('id: $id, ')..write('name: $name, ')..write('pluralName: $pluralName, ')..write('warnInterval: $warnInterval, ')..write('homeId: $homeId, ')..write('refillLimit: $refillLimit, ')..write('unit: $unit')..write(')')).toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, $mrjc(pluralName.hashCode, $mrjc(warnInterval.hashCode, $mrjc(homeId.hashCode, $mrjc(refillLimit.hashCode, unit.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || (other is GroupEntry && other.id == this.id && other.name == this.name && other.pluralName == this.pluralName && other.warnInterval == this.warnInterval && other.homeId == this.homeId && other.refillLimit == this.refillLimit && other.unit == this.unit);
}

class GroupTableCompanion extends UpdateCompanion<GroupEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> pluralName;
  final Value<String> warnInterval;
  final Value<String> homeId;
  final Value<double> refillLimit;
  final Value<int> unit;
  const GroupTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pluralName = const Value.absent(),
    this.warnInterval = const Value.absent(),
    this.homeId = const Value.absent(),
    this.refillLimit = const Value.absent(),
    this.unit = const Value.absent(),
  });
  GroupTableCompanion.insert({
    @required String id,
    @required String name,
    this.pluralName = const Value.absent(),
    this.warnInterval = const Value.absent(),
    @required String homeId,
    this.refillLimit = const Value.absent(),
    @required int unit,
  })  : id = Value(id),
        name = Value(name),
        homeId = Value(homeId),
        unit = Value(unit);
  static Insertable<GroupEntry> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> pluralName,
    Expression<String> warnInterval,
    Expression<String> homeId,
    Expression<double> refillLimit,
    Expression<int> unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pluralName != null) 'plural_name': pluralName,
      if (warnInterval != null) 'warn_interval': warnInterval,
      if (homeId != null) 'home_id': homeId,
      if (refillLimit != null) 'refill_limit': refillLimit,
      if (unit != null) 'unit': unit,
    });
  }

  GroupTableCompanion copyWith({Value<String> id, Value<String> name, Value<String> pluralName, Value<String> warnInterval, Value<String> homeId, Value<double> refillLimit, Value<int> unit}) {
    return GroupTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pluralName: pluralName ?? this.pluralName,
      warnInterval: warnInterval ?? this.warnInterval,
      homeId: homeId ?? this.homeId,
      refillLimit: refillLimit ?? this.refillLimit,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pluralName.present) {
      map['plural_name'] = Variable<String>(pluralName.value);
    }
    if (warnInterval.present) {
      map['warn_interval'] = Variable<String>(warnInterval.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    if (refillLimit.present) {
      map['refill_limit'] = Variable<double>(refillLimit.value);
    }
    if (unit.present) {
      map['unit'] = Variable<int>(unit.value);
    }
    return map;
  }
}

class $GroupTableTable extends GroupTable with TableInfo<$GroupTableTable, GroupEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $GroupTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false, $customConstraints: 'unique');
  }

  final VerificationMeta _pluralNameMeta = const VerificationMeta('pluralName');
  GeneratedTextColumn _pluralName;
  @override
  GeneratedTextColumn get pluralName => _pluralName ??= _constructPluralName();
  GeneratedTextColumn _constructPluralName() {
    return GeneratedTextColumn('plural_name', $tableName, true, $customConstraints: 'unique');
  }

  final VerificationMeta _warnIntervalMeta = const VerificationMeta('warnInterval');
  GeneratedTextColumn _warnInterval;
  @override
  GeneratedTextColumn get warnInterval => _warnInterval ??= _constructWarnInterval();
  GeneratedTextColumn _constructWarnInterval() {
    return GeneratedTextColumn(
      'warn_interval',
      $tableName,
      true,
    );
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false, $customConstraints: 'references Home(id)');
  }

  final VerificationMeta _refillLimitMeta = const VerificationMeta('refillLimit');
  GeneratedRealColumn _refillLimit;
  @override
  GeneratedRealColumn get refillLimit => _refillLimit ??= _constructRefillLimit();
  GeneratedRealColumn _constructRefillLimit() {
    return GeneratedRealColumn(
      'refill_limit',
      $tableName,
      true,
    );
  }

  final VerificationMeta _unitMeta = const VerificationMeta('unit');
  GeneratedIntColumn _unit;
  @override
  GeneratedIntColumn get unit => _unit ??= _constructUnit();
  GeneratedIntColumn _constructUnit() {
    return GeneratedIntColumn(
      'unit',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, pluralName, warnInterval, homeId, refillLimit, unit];
  @override
  $GroupTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'group_table';
  @override
  final String actualTableName = 'group_table';
  @override
  VerificationContext validateIntegrity(Insertable<GroupEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('plural_name')) {
      context.handle(_pluralNameMeta, pluralName.isAcceptableOrUnknown(data['plural_name'], _pluralNameMeta));
    }
    if (data.containsKey('warn_interval')) {
      context.handle(_warnIntervalMeta, warnInterval.isAcceptableOrUnknown(data['warn_interval'], _warnIntervalMeta));
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta, homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    if (data.containsKey('refill_limit')) {
      context.handle(_refillLimitMeta, refillLimit.isAcceptableOrUnknown(data['refill_limit'], _refillLimitMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(_unitMeta, unit.isAcceptableOrUnknown(data['unit'], _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return GroupEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $GroupTableTable createAlias(String alias) {
    return $GroupTableTable(_db, alias);
  }
}

class ChangeEntry extends DataClass implements Insertable<ChangeEntry> {
  final String id;
  final String userId;
  final double value;
  final DateTime changeDate;
  final String chargeId;
  final String homeId;
  ChangeEntry({@required this.id, @required this.userId, @required this.value, @required this.changeDate, @required this.chargeId, @required this.homeId});
  factory ChangeEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ChangeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      value: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      changeDate: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}change_date']),
      chargeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}charge_id']),
      homeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || changeDate != null) {
      map['change_date'] = Variable<DateTime>(changeDate);
    }
    if (!nullToAbsent || chargeId != null) {
      map['charge_id'] = Variable<String>(chargeId);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
  }

  ChangeTableCompanion toCompanion(bool nullToAbsent) {
    return ChangeTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      value: value == null && nullToAbsent ? const Value.absent() : Value(value),
      changeDate: changeDate == null && nullToAbsent ? const Value.absent() : Value(changeDate),
      chargeId: chargeId == null && nullToAbsent ? const Value.absent() : Value(chargeId),
      homeId: homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
    );
  }

  factory ChangeEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ChangeEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      value: serializer.fromJson<double>(json['value']),
      changeDate: serializer.fromJson<DateTime>(json['changeDate']),
      chargeId: serializer.fromJson<String>(json['chargeId']),
      homeId: serializer.fromJson<String>(json['homeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'value': serializer.toJson<double>(value),
      'changeDate': serializer.toJson<DateTime>(changeDate),
      'chargeId': serializer.toJson<String>(chargeId),
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  ChangeEntry copyWith({String id, String userId, double value, DateTime changeDate, String chargeId, String homeId}) => ChangeEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        value: value ?? this.value,
        changeDate: changeDate ?? this.changeDate,
        chargeId: chargeId ?? this.chargeId,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('ChangeEntry(')..write('id: $id, ')..write('userId: $userId, ')..write('value: $value, ')..write('changeDate: $changeDate, ')..write('chargeId: $chargeId, ')..write('homeId: $homeId')..write(')')).toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(userId.hashCode, $mrjc(value.hashCode, $mrjc(changeDate.hashCode, $mrjc(chargeId.hashCode, homeId.hashCode))))));
  @override
  bool operator ==(dynamic other) => identical(this, other) || (other is ChangeEntry && other.id == this.id && other.userId == this.userId && other.value == this.value && other.changeDate == this.changeDate && other.chargeId == this.chargeId && other.homeId == this.homeId);
}

class ChangeTableCompanion extends UpdateCompanion<ChangeEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<double> value;
  final Value<DateTime> changeDate;
  final Value<String> chargeId;
  final Value<String> homeId;
  const ChangeTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.value = const Value.absent(),
    this.changeDate = const Value.absent(),
    this.chargeId = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  ChangeTableCompanion.insert({
    this.id = const Value.absent(),
    @required String userId,
    @required double value,
    @required DateTime changeDate,
    @required String chargeId,
    @required String homeId,
  })  : userId = Value(userId),
        value = Value(value),
        changeDate = Value(changeDate),
        chargeId = Value(chargeId),
        homeId = Value(homeId);
  static Insertable<ChangeEntry> custom({
    Expression<String> id,
    Expression<String> userId,
    Expression<double> value,
    Expression<DateTime> changeDate,
    Expression<String> chargeId,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (value != null) 'value': value,
      if (changeDate != null) 'change_date': changeDate,
      if (chargeId != null) 'charge_id': chargeId,
      if (homeId != null) 'home_id': homeId,
    });
  }

  ChangeTableCompanion copyWith({Value<String> id, Value<String> userId, Value<double> value, Value<DateTime> changeDate, Value<String> chargeId, Value<String> homeId}) {
    return ChangeTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      changeDate: changeDate ?? this.changeDate,
      chargeId: chargeId ?? this.chargeId,
      homeId: homeId ?? this.homeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (changeDate.present) {
      map['change_date'] = Variable<DateTime>(changeDate.value);
    }
    if (chargeId.present) {
      map['charge_id'] = Variable<String>(chargeId.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    return map;
  }
}

class $ChangeTableTable extends ChangeTable with TableInfo<$ChangeTableTable, ChangeEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ChangeTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => Uuid().v4();
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedRealColumn _value;
  @override
  GeneratedRealColumn get value => _value ??= _constructValue();
  GeneratedRealColumn _constructValue() {
    return GeneratedRealColumn(
      'value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _changeDateMeta = const VerificationMeta('changeDate');
  GeneratedDateTimeColumn _changeDate;
  @override
  GeneratedDateTimeColumn get changeDate => _changeDate ??= _constructChangeDate();
  GeneratedDateTimeColumn _constructChangeDate() {
    return GeneratedDateTimeColumn(
      'change_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _chargeIdMeta = const VerificationMeta('chargeId');
  GeneratedTextColumn _chargeId;
  @override
  GeneratedTextColumn get chargeId => _chargeId ??= _constructChargeId();
  GeneratedTextColumn _constructChargeId() {
    return GeneratedTextColumn('charge_id', $tableName, false, $customConstraints: 'references ChargeTable(id)');
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false, $customConstraints: 'references Home(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, userId, value, changeDate, chargeId, homeId];
  @override
  $ChangeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'change_table';
  @override
  final String actualTableName = 'change_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChangeEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(_valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('change_date')) {
      context.handle(_changeDateMeta, changeDate.isAcceptableOrUnknown(data['change_date'], _changeDateMeta));
    } else if (isInserting) {
      context.missing(_changeDateMeta);
    }
    if (data.containsKey('charge_id')) {
      context.handle(_chargeIdMeta, chargeId.isAcceptableOrUnknown(data['charge_id'], _chargeIdMeta));
    } else if (isInserting) {
      context.missing(_chargeIdMeta);
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta, homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChangeEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ChangeEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ChangeTableTable createAlias(String alias) {
    return $ChangeTableTable(_db, alias);
  }
}

class ModelChangeEntry extends DataClass implements Insertable<ModelChangeEntry> {
  final String id;
  final DateTime modificationDate;
  final String userId;
  final String groupId;
  final String productId;
  final String chargeId;
  final int direction;
  final String homeId;
  ModelChangeEntry({@required this.id, @required this.modificationDate, @required this.userId, this.groupId, this.productId, this.chargeId, @required this.direction, @required this.homeId});
  factory ModelChangeEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return ModelChangeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      modificationDate: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}modification_date']),
      userId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      groupId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}group_id']),
      productId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      chargeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}charge_id']),
      direction: intType.mapFromDatabaseResponse(data['${effectivePrefix}direction']),
      homeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || modificationDate != null) {
      map['modification_date'] = Variable<DateTime>(modificationDate);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || chargeId != null) {
      map['charge_id'] = Variable<String>(chargeId);
    }
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<int>(direction);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
  }

  ModelChangeTableCompanion toCompanion(bool nullToAbsent) {
    return ModelChangeTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      modificationDate: modificationDate == null && nullToAbsent ? const Value.absent() : Value(modificationDate),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      groupId: groupId == null && nullToAbsent ? const Value.absent() : Value(groupId),
      productId: productId == null && nullToAbsent ? const Value.absent() : Value(productId),
      chargeId: chargeId == null && nullToAbsent ? const Value.absent() : Value(chargeId),
      direction: direction == null && nullToAbsent ? const Value.absent() : Value(direction),
      homeId: homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
    );
  }

  factory ModelChangeEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ModelChangeEntry(
      id: serializer.fromJson<String>(json['id']),
      modificationDate: serializer.fromJson<DateTime>(json['modificationDate']),
      userId: serializer.fromJson<String>(json['userId']),
      groupId: serializer.fromJson<String>(json['groupId']),
      productId: serializer.fromJson<String>(json['productId']),
      chargeId: serializer.fromJson<String>(json['chargeId']),
      direction: serializer.fromJson<int>(json['direction']),
      homeId: serializer.fromJson<String>(json['homeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'modificationDate': serializer.toJson<DateTime>(modificationDate),
      'userId': serializer.toJson<String>(userId),
      'groupId': serializer.toJson<String>(groupId),
      'productId': serializer.toJson<String>(productId),
      'chargeId': serializer.toJson<String>(chargeId),
      'direction': serializer.toJson<int>(direction),
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  ModelChangeEntry copyWith({String id, DateTime modificationDate, String userId, String groupId, String productId, String chargeId, int direction, String homeId}) => ModelChangeEntry(
        id: id ?? this.id,
        modificationDate: modificationDate ?? this.modificationDate,
        userId: userId ?? this.userId,
        groupId: groupId ?? this.groupId,
        productId: productId ?? this.productId,
        chargeId: chargeId ?? this.chargeId,
        direction: direction ?? this.direction,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('ModelChangeEntry(')
          ..write('id: $id, ')
          ..write('modificationDate: $modificationDate, ')
          ..write('userId: $userId, ')
          ..write('groupId: $groupId, ')
          ..write('productId: $productId, ')
          ..write('chargeId: $chargeId, ')
          ..write('direction: $direction, ')
          ..write('homeId: $homeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(modificationDate.hashCode, $mrjc(userId.hashCode, $mrjc(groupId.hashCode, $mrjc(productId.hashCode, $mrjc(chargeId.hashCode, $mrjc(direction.hashCode, homeId.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ModelChangeEntry &&
          other.id == this.id &&
          other.modificationDate == this.modificationDate &&
          other.userId == this.userId &&
          other.groupId == this.groupId &&
          other.productId == this.productId &&
          other.chargeId == this.chargeId &&
          other.direction == this.direction &&
          other.homeId == this.homeId);
}

class ModelChangeTableCompanion extends UpdateCompanion<ModelChangeEntry> {
  final Value<String> id;
  final Value<DateTime> modificationDate;
  final Value<String> userId;
  final Value<String> groupId;
  final Value<String> productId;
  final Value<String> chargeId;
  final Value<int> direction;
  final Value<String> homeId;
  const ModelChangeTableCompanion({
    this.id = const Value.absent(),
    this.modificationDate = const Value.absent(),
    this.userId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.productId = const Value.absent(),
    this.chargeId = const Value.absent(),
    this.direction = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  ModelChangeTableCompanion.insert({
    @required String id,
    @required DateTime modificationDate,
    @required String userId,
    this.groupId = const Value.absent(),
    this.productId = const Value.absent(),
    this.chargeId = const Value.absent(),
    @required int direction,
    @required String homeId,
  })  : id = Value(id),
        modificationDate = Value(modificationDate),
        userId = Value(userId),
        direction = Value(direction),
        homeId = Value(homeId);
  static Insertable<ModelChangeEntry> custom({
    Expression<String> id,
    Expression<DateTime> modificationDate,
    Expression<String> userId,
    Expression<String> groupId,
    Expression<String> productId,
    Expression<String> chargeId,
    Expression<int> direction,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (modificationDate != null) 'modification_date': modificationDate,
      if (userId != null) 'user_id': userId,
      if (groupId != null) 'group_id': groupId,
      if (productId != null) 'product_id': productId,
      if (chargeId != null) 'charge_id': chargeId,
      if (direction != null) 'direction': direction,
      if (homeId != null) 'home_id': homeId,
    });
  }

  ModelChangeTableCompanion copyWith({Value<String> id, Value<DateTime> modificationDate, Value<String> userId, Value<String> groupId, Value<String> productId, Value<String> chargeId, Value<int> direction, Value<String> homeId}) {
    return ModelChangeTableCompanion(
      id: id ?? this.id,
      modificationDate: modificationDate ?? this.modificationDate,
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      productId: productId ?? this.productId,
      chargeId: chargeId ?? this.chargeId,
      direction: direction ?? this.direction,
      homeId: homeId ?? this.homeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (modificationDate.present) {
      map['modification_date'] = Variable<DateTime>(modificationDate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (chargeId.present) {
      map['charge_id'] = Variable<String>(chargeId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<int>(direction.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    return map;
  }
}

class $ModelChangeTableTable extends ModelChangeTable with TableInfo<$ModelChangeTableTable, ModelChangeEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ModelChangeTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modificationDateMeta = const VerificationMeta('modificationDate');
  GeneratedDateTimeColumn _modificationDate;
  @override
  GeneratedDateTimeColumn get modificationDate => _modificationDate ??= _constructModificationDate();
  GeneratedDateTimeColumn _constructModificationDate() {
    return GeneratedDateTimeColumn(
      'modification_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _groupIdMeta = const VerificationMeta('groupId');
  GeneratedTextColumn _groupId;
  @override
  GeneratedTextColumn get groupId => _groupId ??= _constructGroupId();
  GeneratedTextColumn _constructGroupId() {
    return GeneratedTextColumn('group_id', $tableName, true, $customConstraints: 'null references GroupTable(id)');
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedTextColumn _productId;
  @override
  GeneratedTextColumn get productId => _productId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn('product_id', $tableName, true, $customConstraints: 'null references ProductTable(id)');
  }

  final VerificationMeta _chargeIdMeta = const VerificationMeta('chargeId');
  GeneratedTextColumn _chargeId;
  @override
  GeneratedTextColumn get chargeId => _chargeId ??= _constructChargeId();
  GeneratedTextColumn _constructChargeId() {
    return GeneratedTextColumn('charge_id', $tableName, true, $customConstraints: 'null references ChargeTable(id)');
  }

  final VerificationMeta _directionMeta = const VerificationMeta('direction');
  GeneratedIntColumn _direction;
  @override
  GeneratedIntColumn get direction => _direction ??= _constructDirection();
  GeneratedIntColumn _constructDirection() {
    return GeneratedIntColumn(
      'direction',
      $tableName,
      false,
    );
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false, $customConstraints: 'references Home(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, modificationDate, userId, groupId, productId, chargeId, direction, homeId];
  @override
  $ModelChangeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'model_change_table';
  @override
  final String actualTableName = 'model_change_table';
  @override
  VerificationContext validateIntegrity(Insertable<ModelChangeEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('modification_date')) {
      context.handle(_modificationDateMeta, modificationDate.isAcceptableOrUnknown(data['modification_date'], _modificationDateMeta));
    } else if (isInserting) {
      context.missing(_modificationDateMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta, groupId.isAcceptableOrUnknown(data['group_id'], _groupIdMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    }
    if (data.containsKey('charge_id')) {
      context.handle(_chargeIdMeta, chargeId.isAcceptableOrUnknown(data['charge_id'], _chargeIdMeta));
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta, direction.isAcceptableOrUnknown(data['direction'], _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta, homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ModelChangeEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ModelChangeEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ModelChangeTableTable createAlias(String alias) {
    return $ModelChangeTableTable(_db, alias);
  }
}

class UserEntry extends DataClass implements Insertable<UserEntry> {
  final String id;
  final String name;
  final bool active;
  UserEntry({@required this.id, @required this.name, @required this.active});
  factory UserEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return UserEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      active: boolType.mapFromDatabaseResponse(data['${effectivePrefix}active']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || active != null) {
      map['active'] = Variable<bool>(active);
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      active: active == null && nullToAbsent ? const Value.absent() : Value(active),
    );
  }

  factory UserEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'active': serializer.toJson<bool>(active),
    };
  }

  UserEntry copyWith({String id, String name, bool active}) => UserEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
      );
  @override
  String toString() {
    return (StringBuffer('UserEntry(')..write('id: $id, ')..write('name: $name, ')..write('active: $active')..write(')')).toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, active.hashCode)));
  @override
  bool operator ==(dynamic other) => identical(this, other) || (other is UserEntry && other.id == this.id && other.name == this.name && other.active == this.active);
}

class UserTableCompanion extends UpdateCompanion<UserEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> active;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.active = const Value.absent(),
  });
  UserTableCompanion.insert({
    @required String id,
    @required String name,
    @required bool active,
  })  : id = Value(id),
        name = Value(name),
        active = Value(active);
  static Insertable<UserEntry> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<bool> active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (active != null) 'active': active,
    });
  }

  UserTableCompanion copyWith({Value<String> id, Value<String> name, Value<bool> active}) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }
}

class $UserTableTable extends UserTable with TableInfo<$UserTableTable, UserEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _activeMeta = const VerificationMeta('active');
  GeneratedBoolColumn _active;
  @override
  GeneratedBoolColumn get active => _active ??= _constructActive();
  GeneratedBoolColumn _constructActive() {
    return GeneratedBoolColumn(
      'active',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, active];
  @override
  $UserTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_table';
  @override
  final String actualTableName = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active'], _activeMeta));
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(_db, alias);
  }
}

class HomeEntry extends DataClass implements Insertable<HomeEntry> {
  final String id;
  final String name;
  final bool active;
  HomeEntry({@required this.id, @required this.name, @required this.active});
  factory HomeEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return HomeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      active: boolType.mapFromDatabaseResponse(data['${effectivePrefix}active']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || active != null) {
      map['active'] = Variable<bool>(active);
    }
    return map;
  }

  HomeTableCompanion toCompanion(bool nullToAbsent) {
    return HomeTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      active: active == null && nullToAbsent ? const Value.absent() : Value(active),
    );
  }

  factory HomeEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HomeEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'active': serializer.toJson<bool>(active),
    };
  }

  HomeEntry copyWith({String id, String name, bool active}) => HomeEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
      );
  @override
  String toString() {
    return (StringBuffer('HomeEntry(')..write('id: $id, ')..write('name: $name, ')..write('active: $active')..write(')')).toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, active.hashCode)));
  @override
  bool operator ==(dynamic other) => identical(this, other) || (other is HomeEntry && other.id == this.id && other.name == this.name && other.active == this.active);
}

class HomeTableCompanion extends UpdateCompanion<HomeEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> active;
  const HomeTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.active = const Value.absent(),
  });
  HomeTableCompanion.insert({
    @required String id,
    @required String name,
    @required bool active,
  })  : id = Value(id),
        name = Value(name),
        active = Value(active);
  static Insertable<HomeEntry> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<bool> active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (active != null) 'active': active,
    });
  }

  HomeTableCompanion copyWith({Value<String> id, Value<String> name, Value<bool> active}) {
    return HomeTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }
}

class $HomeTableTable extends HomeTable with TableInfo<$HomeTableTable, HomeEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $HomeTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _activeMeta = const VerificationMeta('active');
  GeneratedBoolColumn _active;
  @override
  GeneratedBoolColumn get active => _active ??= _constructActive();
  GeneratedBoolColumn _constructActive() {
    return GeneratedBoolColumn(
      'active',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, active];
  @override
  $HomeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'home_table';
  @override
  final String actualTableName = 'home_table';
  @override
  VerificationContext validateIntegrity(Insertable<HomeEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active'], _activeMeta));
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HomeEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HomeEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HomeTableTable createAlias(String alias) {
    return $HomeTableTable(_db, alias);
  }
}

class ModificationEntry extends DataClass implements Insertable<ModificationEntry> {
  final String id;
  final String modelChangeId;
  final String fieldName;
  final String from;
  final String to;
  ModificationEntry({@required this.id, @required this.modelChangeId, @required this.fieldName, this.from, this.to});
  factory ModificationEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ModificationEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      modelChangeId: stringType.mapFromDatabaseResponse(data['${effectivePrefix}model_change_id']),
      fieldName: stringType.mapFromDatabaseResponse(data['${effectivePrefix}field_name']),
      from: stringType.mapFromDatabaseResponse(data['${effectivePrefix}from']),
      to: stringType.mapFromDatabaseResponse(data['${effectivePrefix}to']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || modelChangeId != null) {
      map['model_change_id'] = Variable<String>(modelChangeId);
    }
    if (!nullToAbsent || fieldName != null) {
      map['field_name'] = Variable<String>(fieldName);
    }
    if (!nullToAbsent || from != null) {
      map['from'] = Variable<String>(from);
    }
    if (!nullToAbsent || to != null) {
      map['to'] = Variable<String>(to);
    }
    return map;
  }

  ModificationTableCompanion toCompanion(bool nullToAbsent) {
    return ModificationTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      modelChangeId: modelChangeId == null && nullToAbsent ? const Value.absent() : Value(modelChangeId),
      fieldName: fieldName == null && nullToAbsent ? const Value.absent() : Value(fieldName),
      from: from == null && nullToAbsent ? const Value.absent() : Value(from),
      to: to == null && nullToAbsent ? const Value.absent() : Value(to),
    );
  }

  factory ModificationEntry.fromJson(Map<String, dynamic> json, {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ModificationEntry(
      id: serializer.fromJson<String>(json['id']),
      modelChangeId: serializer.fromJson<String>(json['modelChangeId']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      from: serializer.fromJson<String>(json['from']),
      to: serializer.fromJson<String>(json['to']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'modelChangeId': serializer.toJson<String>(modelChangeId),
      'fieldName': serializer.toJson<String>(fieldName),
      'from': serializer.toJson<String>(from),
      'to': serializer.toJson<String>(to),
    };
  }

  ModificationEntry copyWith({String id, String modelChangeId, String fieldName, String from, String to}) => ModificationEntry(
        id: id ?? this.id,
        modelChangeId: modelChangeId ?? this.modelChangeId,
        fieldName: fieldName ?? this.fieldName,
        from: from ?? this.from,
        to: to ?? this.to,
      );
  @override
  String toString() {
    return (StringBuffer('ModificationEntry(')..write('id: $id, ')..write('modelChangeId: $modelChangeId, ')..write('fieldName: $fieldName, ')..write('from: $from, ')..write('to: $to')..write(')')).toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, $mrjc(modelChangeId.hashCode, $mrjc(fieldName.hashCode, $mrjc(from.hashCode, to.hashCode)))));
  @override
  bool operator ==(dynamic other) => identical(this, other) || (other is ModificationEntry && other.id == this.id && other.modelChangeId == this.modelChangeId && other.fieldName == this.fieldName && other.from == this.from && other.to == this.to);
}

class ModificationTableCompanion extends UpdateCompanion<ModificationEntry> {
  final Value<String> id;
  final Value<String> modelChangeId;
  final Value<String> fieldName;
  final Value<String> from;
  final Value<String> to;
  const ModificationTableCompanion({
    this.id = const Value.absent(),
    this.modelChangeId = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
  });
  ModificationTableCompanion.insert({
    @required String id,
    @required String modelChangeId,
    @required String fieldName,
    this.from = const Value.absent(),
    this.to = const Value.absent(),
  })  : id = Value(id),
        modelChangeId = Value(modelChangeId),
        fieldName = Value(fieldName);
  static Insertable<ModificationEntry> custom({
    Expression<String> id,
    Expression<String> modelChangeId,
    Expression<String> fieldName,
    Expression<String> from,
    Expression<String> to,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (modelChangeId != null) 'model_change_id': modelChangeId,
      if (fieldName != null) 'field_name': fieldName,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
    });
  }

  ModificationTableCompanion copyWith({Value<String> id, Value<String> modelChangeId, Value<String> fieldName, Value<String> from, Value<String> to}) {
    return ModificationTableCompanion(
      id: id ?? this.id,
      modelChangeId: modelChangeId ?? this.modelChangeId,
      fieldName: fieldName ?? this.fieldName,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (modelChangeId.present) {
      map['model_change_id'] = Variable<String>(modelChangeId.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (from.present) {
      map['from'] = Variable<String>(from.value);
    }
    if (to.present) {
      map['to'] = Variable<String>(to.value);
    }
    return map;
  }
}

class $ModificationTableTable extends ModificationTable with TableInfo<$ModificationTableTable, ModificationEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ModificationTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modelChangeIdMeta = const VerificationMeta('modelChangeId');
  GeneratedTextColumn _modelChangeId;
  @override
  GeneratedTextColumn get modelChangeId => _modelChangeId ??= _constructModelChangeId();
  GeneratedTextColumn _constructModelChangeId() {
    return GeneratedTextColumn('model_change_id', $tableName, false, $customConstraints: 'references ModelChangeTable(id)');
  }

  final VerificationMeta _fieldNameMeta = const VerificationMeta('fieldName');
  GeneratedTextColumn _fieldName;
  @override
  GeneratedTextColumn get fieldName => _fieldName ??= _constructFieldName();
  GeneratedTextColumn _constructFieldName() {
    return GeneratedTextColumn(
      'field_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fromMeta = const VerificationMeta('from');
  GeneratedTextColumn _from;
  @override
  GeneratedTextColumn get from => _from ??= _constructFrom();
  GeneratedTextColumn _constructFrom() {
    return GeneratedTextColumn(
      'from',
      $tableName,
      true,
    );
  }

  final VerificationMeta _toMeta = const VerificationMeta('to');
  GeneratedTextColumn _to;
  @override
  GeneratedTextColumn get to => _to ??= _constructTo();
  GeneratedTextColumn _constructTo() {
    return GeneratedTextColumn(
      'to',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, modelChangeId, fieldName, from, to];
  @override
  $ModificationTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'modification_table';
  @override
  final String actualTableName = 'modification_table';
  @override
  VerificationContext validateIntegrity(Insertable<ModificationEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('model_change_id')) {
      context.handle(_modelChangeIdMeta, modelChangeId.isAcceptableOrUnknown(data['model_change_id'], _modelChangeIdMeta));
    } else if (isInserting) {
      context.missing(_modelChangeIdMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(_fieldNameMeta, fieldName.isAcceptableOrUnknown(data['field_name'], _fieldNameMeta));
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('from')) {
      context.handle(_fromMeta, from.isAcceptableOrUnknown(data['from'], _fromMeta));
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to'], _toMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ModificationEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ModificationEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ModificationTableTable createAlias(String alias) {
    return $ModificationTableTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ChargeTableTable _chargeTable;
  $ChargeTableTable get chargeTable => _chargeTable ??= $ChargeTableTable(this);
  $ProductTableTable _productTable;
  $ProductTableTable get productTable => _productTable ??= $ProductTableTable(this);
  $GroupTableTable _groupTable;
  $GroupTableTable get groupTable => _groupTable ??= $GroupTableTable(this);
  $ChangeTableTable _changeTable;
  $ChangeTableTable get changeTable => _changeTable ??= $ChangeTableTable(this);
  $ModelChangeTableTable _modelChangeTable;
  $ModelChangeTableTable get modelChangeTable => _modelChangeTable ??= $ModelChangeTableTable(this);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  $HomeTableTable _homeTable;
  $HomeTableTable get homeTable => _homeTable ??= $HomeTableTable(this);
  $ModificationTableTable _modificationTable;
  $ModificationTableTable get modificationTable => _modificationTable ??= $ModificationTableTable(this);
  ChargeRepository _chargeRepository;
  ChargeRepository get chargeRepository => _chargeRepository ??= ChargeRepository(this as Database);
  ProductRepository _productRepository;
  ProductRepository get productRepository => _productRepository ??= ProductRepository(this as Database);
  GroupRepository _groupRepository;
  GroupRepository get groupRepository => _groupRepository ??= GroupRepository(this as Database);
  ChangeRepository _changeRepository;
  ChangeRepository get changeRepository => _changeRepository ??= ChangeRepository(this as Database);
  ModelChangeRepository _modelChangeRepository;
  ModelChangeRepository get modelChangeRepository => _modelChangeRepository ??= ModelChangeRepository(this as Database);
  UserRepository _userRepository;
  UserRepository get userRepository => _userRepository ??= UserRepository(this as Database);
  HomeRepository _homeRepository;
  HomeRepository get homeRepository => _homeRepository ??= HomeRepository(this as Database);
  ModificationRepository _modificationRepository;
  ModificationRepository get modificationRepository => _modificationRepository ??= ModificationRepository(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [chargeTable, productTable, groupTable, changeTable, modelChangeTable, userTable, homeTable, modificationTable];
}
