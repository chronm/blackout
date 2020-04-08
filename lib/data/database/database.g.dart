// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ItemEntry extends DataClass implements Insertable<ItemEntry> {
  final String id;
  final String productId;
  final DateTime expirationDate;
  final DateTime notificationDate;
  final String homeId;
  ItemEntry(
      {@required this.id,
      @required this.productId,
      this.expirationDate,
      this.notificationDate,
      @required this.homeId});
  factory ItemEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ItemEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      expirationDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}expiration_date']),
      notificationDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}notification_date']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
    );
  }
  factory ItemEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemEntry(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      expirationDate: serializer.fromJson<DateTime>(json['expirationDate']),
      notificationDate: serializer.fromJson<DateTime>(json['notificationDate']),
      homeId: serializer.fromJson<String>(json['homeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'expirationDate': serializer.toJson<DateTime>(expirationDate),
      'notificationDate': serializer.toJson<DateTime>(notificationDate),
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  @override
  ItemTableCompanion createCompanion(bool nullToAbsent) {
    return ItemTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      expirationDate: expirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expirationDate),
      notificationDate: notificationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationDate),
      homeId:
          homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
    );
  }

  ItemEntry copyWith(
          {String id,
          String productId,
          DateTime expirationDate,
          DateTime notificationDate,
          String homeId}) =>
      ItemEntry(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        expirationDate: expirationDate ?? this.expirationDate,
        notificationDate: notificationDate ?? this.notificationDate,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('ItemEntry(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('notificationDate: $notificationDate, ')
          ..write('homeId: $homeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          productId.hashCode,
          $mrjc(expirationDate.hashCode,
              $mrjc(notificationDate.hashCode, homeId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ItemEntry &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.expirationDate == this.expirationDate &&
          other.notificationDate == this.notificationDate &&
          other.homeId == this.homeId);
}

class ItemTableCompanion extends UpdateCompanion<ItemEntry> {
  final Value<String> id;
  final Value<String> productId;
  final Value<DateTime> expirationDate;
  final Value<DateTime> notificationDate;
  final Value<String> homeId;
  const ItemTableCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.notificationDate = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  ItemTableCompanion.insert({
    @required String id,
    @required String productId,
    this.expirationDate = const Value.absent(),
    this.notificationDate = const Value.absent(),
    @required String homeId,
  })  : id = Value(id),
        productId = Value(productId),
        homeId = Value(homeId);
  ItemTableCompanion copyWith(
      {Value<String> id,
      Value<String> productId,
      Value<DateTime> expirationDate,
      Value<DateTime> notificationDate,
      Value<String> homeId}) {
    return ItemTableCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      expirationDate: expirationDate ?? this.expirationDate,
      notificationDate: notificationDate ?? this.notificationDate,
      homeId: homeId ?? this.homeId,
    );
  }
}

class $ItemTableTable extends ItemTable
    with TableInfo<$ItemTableTable, ItemEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ItemTableTable(this._db, [this._alias]);
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
    return GeneratedTextColumn('product_id', $tableName, false,
        $customConstraints: 'references ProductTable(id)');
  }

  final VerificationMeta _expirationDateMeta =
      const VerificationMeta('expirationDate');
  GeneratedDateTimeColumn _expirationDate;
  @override
  GeneratedDateTimeColumn get expirationDate =>
      _expirationDate ??= _constructExpirationDate();
  GeneratedDateTimeColumn _constructExpirationDate() {
    return GeneratedDateTimeColumn(
      'expiration_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _notificationDateMeta =
      const VerificationMeta('notificationDate');
  GeneratedDateTimeColumn _notificationDate;
  @override
  GeneratedDateTimeColumn get notificationDate =>
      _notificationDate ??= _constructNotificationDate();
  GeneratedDateTimeColumn _constructNotificationDate() {
    return GeneratedDateTimeColumn(
      'notification_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false,
        $customConstraints: 'references Home(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, expirationDate, notificationDate, homeId];
  @override
  $ItemTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'item_table';
  @override
  final String actualTableName = 'item_table';
  @override
  VerificationContext validateIntegrity(ItemTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.productId.present) {
      context.handle(_productIdMeta,
          productId.isAcceptableValue(d.productId.value, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (d.expirationDate.present) {
      context.handle(
          _expirationDateMeta,
          expirationDate.isAcceptableValue(
              d.expirationDate.value, _expirationDateMeta));
    }
    if (d.notificationDate.present) {
      context.handle(
          _notificationDateMeta,
          notificationDate.isAcceptableValue(
              d.notificationDate.value, _notificationDateMeta));
    }
    if (d.homeId.present) {
      context.handle(
          _homeIdMeta, homeId.isAcceptableValue(d.homeId.value, _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ItemEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ItemTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.productId.present) {
      map['product_id'] = Variable<String, StringType>(d.productId.value);
    }
    if (d.expirationDate.present) {
      map['expiration_date'] =
          Variable<DateTime, DateTimeType>(d.expirationDate.value);
    }
    if (d.notificationDate.present) {
      map['notification_date'] =
          Variable<DateTime, DateTimeType>(d.notificationDate.value);
    }
    if (d.homeId.present) {
      map['home_id'] = Variable<String, StringType>(d.homeId.value);
    }
    return map;
  }

  @override
  $ItemTableTable createAlias(String alias) {
    return $ItemTableTable(_db, alias);
  }
}

class ProductEntry extends DataClass implements Insertable<ProductEntry> {
  final String id;
  final String ean;
  final String categoryId;
  final String description;
  final String homeId;
  final double refillLimit;
  final int unit;
  ProductEntry(
      {@required this.id,
      this.ean,
      this.categoryId,
      @required this.description,
      @required this.homeId,
      this.refillLimit,
      this.unit});
  factory ProductEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return ProductEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ean: stringType.mapFromDatabaseResponse(data['${effectivePrefix}ean']),
      categoryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
      refillLimit: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}refill_limit']),
      unit: intType.mapFromDatabaseResponse(data['${effectivePrefix}unit']),
    );
  }
  factory ProductEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductEntry(
      id: serializer.fromJson<String>(json['id']),
      ean: serializer.fromJson<String>(json['ean']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      description: serializer.fromJson<String>(json['description']),
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
      'categoryId': serializer.toJson<String>(categoryId),
      'description': serializer.toJson<String>(description),
      'homeId': serializer.toJson<String>(homeId),
      'refillLimit': serializer.toJson<double>(refillLimit),
      'unit': serializer.toJson<int>(unit),
    };
  }

  @override
  ProductTableCompanion createCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ean: ean == null && nullToAbsent ? const Value.absent() : Value(ean),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      homeId:
          homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
      refillLimit: refillLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(refillLimit),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  ProductEntry copyWith(
          {String id,
          String ean,
          String categoryId,
          String description,
          String homeId,
          double refillLimit,
          int unit}) =>
      ProductEntry(
        id: id ?? this.id,
        ean: ean ?? this.ean,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        homeId: homeId ?? this.homeId,
        refillLimit: refillLimit ?? this.refillLimit,
        unit: unit ?? this.unit,
      );
  @override
  String toString() {
    return (StringBuffer('ProductEntry(')
          ..write('id: $id, ')
          ..write('ean: $ean, ')
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('homeId: $homeId, ')
          ..write('refillLimit: $refillLimit, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ean.hashCode,
          $mrjc(
              categoryId.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(homeId.hashCode,
                      $mrjc(refillLimit.hashCode, unit.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductEntry &&
          other.id == this.id &&
          other.ean == this.ean &&
          other.categoryId == this.categoryId &&
          other.description == this.description &&
          other.homeId == this.homeId &&
          other.refillLimit == this.refillLimit &&
          other.unit == this.unit);
}

class ProductTableCompanion extends UpdateCompanion<ProductEntry> {
  final Value<String> id;
  final Value<String> ean;
  final Value<String> categoryId;
  final Value<String> description;
  final Value<String> homeId;
  final Value<double> refillLimit;
  final Value<int> unit;
  const ProductTableCompanion({
    this.id = const Value.absent(),
    this.ean = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.description = const Value.absent(),
    this.homeId = const Value.absent(),
    this.refillLimit = const Value.absent(),
    this.unit = const Value.absent(),
  });
  ProductTableCompanion.insert({
    @required String id,
    this.ean = const Value.absent(),
    this.categoryId = const Value.absent(),
    @required String description,
    @required String homeId,
    this.refillLimit = const Value.absent(),
    this.unit = const Value.absent(),
  })  : id = Value(id),
        description = Value(description),
        homeId = Value(homeId);
  ProductTableCompanion copyWith(
      {Value<String> id,
      Value<String> ean,
      Value<String> categoryId,
      Value<String> description,
      Value<String> homeId,
      Value<double> refillLimit,
      Value<int> unit}) {
    return ProductTableCompanion(
      id: id ?? this.id,
      ean: ean ?? this.ean,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      homeId: homeId ?? this.homeId,
      refillLimit: refillLimit ?? this.refillLimit,
      unit: unit ?? this.unit,
    );
  }
}

class $ProductTableTable extends ProductTable
    with TableInfo<$ProductTableTable, ProductEntry> {
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
    return GeneratedTextColumn(
      'ean',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedTextColumn _categoryId;
  @override
  GeneratedTextColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedTextColumn _constructCategoryId() {
    return GeneratedTextColumn('category_id', $tableName, true,
        $customConstraints: 'null references CategoryTable(id)');
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false,
        $customConstraints: 'references Home(id)');
  }

  final VerificationMeta _refillLimitMeta =
      const VerificationMeta('refillLimit');
  GeneratedRealColumn _refillLimit;
  @override
  GeneratedRealColumn get refillLimit =>
      _refillLimit ??= _constructRefillLimit();
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
  List<GeneratedColumn> get $columns =>
      [id, ean, categoryId, description, homeId, refillLimit, unit];
  @override
  $ProductTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_table';
  @override
  final String actualTableName = 'product_table';
  @override
  VerificationContext validateIntegrity(ProductTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.ean.present) {
      context.handle(_eanMeta, ean.isAcceptableValue(d.ean.value, _eanMeta));
    }
    if (d.categoryId.present) {
      context.handle(_categoryIdMeta,
          categoryId.isAcceptableValue(d.categoryId.value, _categoryIdMeta));
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.homeId.present) {
      context.handle(
          _homeIdMeta, homeId.isAcceptableValue(d.homeId.value, _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    if (d.refillLimit.present) {
      context.handle(_refillLimitMeta,
          refillLimit.isAcceptableValue(d.refillLimit.value, _refillLimitMeta));
    }
    if (d.unit.present) {
      context.handle(
          _unitMeta, unit.isAcceptableValue(d.unit.value, _unitMeta));
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
  Map<String, Variable> entityToSql(ProductTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.ean.present) {
      map['ean'] = Variable<String, StringType>(d.ean.value);
    }
    if (d.categoryId.present) {
      map['category_id'] = Variable<String, StringType>(d.categoryId.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.homeId.present) {
      map['home_id'] = Variable<String, StringType>(d.homeId.value);
    }
    if (d.refillLimit.present) {
      map['refill_limit'] = Variable<double, RealType>(d.refillLimit.value);
    }
    if (d.unit.present) {
      map['unit'] = Variable<int, IntType>(d.unit.value);
    }
    return map;
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(_db, alias);
  }
}

class CategoryEntry extends DataClass implements Insertable<CategoryEntry> {
  final String id;
  final String name;
  final String pluralName;
  final String warnInterval;
  final String homeId;
  final double refillLimit;
  final int unit;
  CategoryEntry(
      {@required this.id,
      @required this.name,
      this.pluralName,
      this.warnInterval,
      @required this.homeId,
      this.refillLimit,
      @required this.unit});
  factory CategoryEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return CategoryEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      pluralName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}plural_name']),
      warnInterval: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}warn_interval']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
      refillLimit: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}refill_limit']),
      unit: intType.mapFromDatabaseResponse(data['${effectivePrefix}unit']),
    );
  }
  factory CategoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CategoryEntry(
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

  @override
  CategoryTableCompanion createCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      pluralName: pluralName == null && nullToAbsent
          ? const Value.absent()
          : Value(pluralName),
      warnInterval: warnInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(warnInterval),
      homeId:
          homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
      refillLimit: refillLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(refillLimit),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  CategoryEntry copyWith(
          {String id,
          String name,
          String pluralName,
          String warnInterval,
          String homeId,
          double refillLimit,
          int unit}) =>
      CategoryEntry(
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
    return (StringBuffer('CategoryEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pluralName: $pluralName, ')
          ..write('warnInterval: $warnInterval, ')
          ..write('homeId: $homeId, ')
          ..write('refillLimit: $refillLimit, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              pluralName.hashCode,
              $mrjc(
                  warnInterval.hashCode,
                  $mrjc(homeId.hashCode,
                      $mrjc(refillLimit.hashCode, unit.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CategoryEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.pluralName == this.pluralName &&
          other.warnInterval == this.warnInterval &&
          other.homeId == this.homeId &&
          other.refillLimit == this.refillLimit &&
          other.unit == this.unit);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> pluralName;
  final Value<String> warnInterval;
  final Value<String> homeId;
  final Value<double> refillLimit;
  final Value<int> unit;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pluralName = const Value.absent(),
    this.warnInterval = const Value.absent(),
    this.homeId = const Value.absent(),
    this.refillLimit = const Value.absent(),
    this.unit = const Value.absent(),
  });
  CategoryTableCompanion.insert({
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
  CategoryTableCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> pluralName,
      Value<String> warnInterval,
      Value<String> homeId,
      Value<double> refillLimit,
      Value<int> unit}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pluralName: pluralName ?? this.pluralName,
      warnInterval: warnInterval ?? this.warnInterval,
      homeId: homeId ?? this.homeId,
      refillLimit: refillLimit ?? this.refillLimit,
      unit: unit ?? this.unit,
    );
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoryTableTable(this._db, [this._alias]);
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
    return GeneratedTextColumn('name', $tableName, false,
        $customConstraints: 'unique');
  }

  final VerificationMeta _pluralNameMeta = const VerificationMeta('pluralName');
  GeneratedTextColumn _pluralName;
  @override
  GeneratedTextColumn get pluralName => _pluralName ??= _constructPluralName();
  GeneratedTextColumn _constructPluralName() {
    return GeneratedTextColumn(
      'plural_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _warnIntervalMeta =
      const VerificationMeta('warnInterval');
  GeneratedTextColumn _warnInterval;
  @override
  GeneratedTextColumn get warnInterval =>
      _warnInterval ??= _constructWarnInterval();
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
    return GeneratedTextColumn('home_id', $tableName, false,
        $customConstraints: 'references Home(id)');
  }

  final VerificationMeta _refillLimitMeta =
      const VerificationMeta('refillLimit');
  GeneratedRealColumn _refillLimit;
  @override
  GeneratedRealColumn get refillLimit =>
      _refillLimit ??= _constructRefillLimit();
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
  List<GeneratedColumn> get $columns =>
      [id, name, pluralName, warnInterval, homeId, refillLimit, unit];
  @override
  $CategoryTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'category_table';
  @override
  final String actualTableName = 'category_table';
  @override
  VerificationContext validateIntegrity(CategoryTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.pluralName.present) {
      context.handle(_pluralNameMeta,
          pluralName.isAcceptableValue(d.pluralName.value, _pluralNameMeta));
    }
    if (d.warnInterval.present) {
      context.handle(
          _warnIntervalMeta,
          warnInterval.isAcceptableValue(
              d.warnInterval.value, _warnIntervalMeta));
    }
    if (d.homeId.present) {
      context.handle(
          _homeIdMeta, homeId.isAcceptableValue(d.homeId.value, _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    if (d.refillLimit.present) {
      context.handle(_refillLimitMeta,
          refillLimit.isAcceptableValue(d.refillLimit.value, _refillLimitMeta));
    }
    if (d.unit.present) {
      context.handle(
          _unitMeta, unit.isAcceptableValue(d.unit.value, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CategoryEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoryTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.pluralName.present) {
      map['plural_name'] = Variable<String, StringType>(d.pluralName.value);
    }
    if (d.warnInterval.present) {
      map['warn_interval'] = Variable<String, StringType>(d.warnInterval.value);
    }
    if (d.homeId.present) {
      map['home_id'] = Variable<String, StringType>(d.homeId.value);
    }
    if (d.refillLimit.present) {
      map['refill_limit'] = Variable<double, RealType>(d.refillLimit.value);
    }
    if (d.unit.present) {
      map['unit'] = Variable<int, IntType>(d.unit.value);
    }
    return map;
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(_db, alias);
  }
}

class ChangeEntry extends DataClass implements Insertable<ChangeEntry> {
  final String id;
  final String userId;
  final double value;
  final DateTime changeDate;
  final String itemId;
  final String homeId;
  ChangeEntry(
      {@required this.id,
      @required this.userId,
      @required this.value,
      @required this.changeDate,
      @required this.itemId,
      @required this.homeId});
  factory ChangeEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ChangeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      value:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
      changeDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}change_date']),
      itemId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
    );
  }
  factory ChangeEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ChangeEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      value: serializer.fromJson<double>(json['value']),
      changeDate: serializer.fromJson<DateTime>(json['changeDate']),
      itemId: serializer.fromJson<String>(json['itemId']),
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
      'itemId': serializer.toJson<String>(itemId),
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  @override
  ChangeTableCompanion createCompanion(bool nullToAbsent) {
    return ChangeTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      changeDate: changeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(changeDate),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      homeId:
          homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
    );
  }

  ChangeEntry copyWith(
          {String id,
          String userId,
          double value,
          DateTime changeDate,
          String itemId,
          String homeId}) =>
      ChangeEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        value: value ?? this.value,
        changeDate: changeDate ?? this.changeDate,
        itemId: itemId ?? this.itemId,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('ChangeEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('value: $value, ')
          ..write('changeDate: $changeDate, ')
          ..write('itemId: $itemId, ')
          ..write('homeId: $homeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              value.hashCode,
              $mrjc(changeDate.hashCode,
                  $mrjc(itemId.hashCode, homeId.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ChangeEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.value == this.value &&
          other.changeDate == this.changeDate &&
          other.itemId == this.itemId &&
          other.homeId == this.homeId);
}

class ChangeTableCompanion extends UpdateCompanion<ChangeEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<double> value;
  final Value<DateTime> changeDate;
  final Value<String> itemId;
  final Value<String> homeId;
  const ChangeTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.value = const Value.absent(),
    this.changeDate = const Value.absent(),
    this.itemId = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  ChangeTableCompanion.insert({
    this.id = const Value.absent(),
    @required String userId,
    @required double value,
    @required DateTime changeDate,
    @required String itemId,
    @required String homeId,
  })  : userId = Value(userId),
        value = Value(value),
        changeDate = Value(changeDate),
        itemId = Value(itemId),
        homeId = Value(homeId);
  ChangeTableCompanion copyWith(
      {Value<String> id,
      Value<String> userId,
      Value<double> value,
      Value<DateTime> changeDate,
      Value<String> itemId,
      Value<String> homeId}) {
    return ChangeTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      changeDate: changeDate ?? this.changeDate,
      itemId: itemId ?? this.itemId,
      homeId: homeId ?? this.homeId,
    );
  }
}

class $ChangeTableTable extends ChangeTable
    with TableInfo<$ChangeTableTable, ChangeEntry> {
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
  GeneratedDateTimeColumn get changeDate =>
      _changeDate ??= _constructChangeDate();
  GeneratedDateTimeColumn _constructChangeDate() {
    return GeneratedDateTimeColumn(
      'change_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedTextColumn _itemId;
  @override
  GeneratedTextColumn get itemId => _itemId ??= _constructItemId();
  GeneratedTextColumn _constructItemId() {
    return GeneratedTextColumn('item_id', $tableName, false,
        $customConstraints: 'references ItemTable(id)');
  }

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false,
        $customConstraints: 'references Home(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, value, changeDate, itemId, homeId];
  @override
  $ChangeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'change_table';
  @override
  final String actualTableName = 'change_table';
  @override
  VerificationContext validateIntegrity(ChangeTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (d.value.present) {
      context.handle(
          _valueMeta, value.isAcceptableValue(d.value.value, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (d.changeDate.present) {
      context.handle(_changeDateMeta,
          changeDate.isAcceptableValue(d.changeDate.value, _changeDateMeta));
    } else if (isInserting) {
      context.missing(_changeDateMeta);
    }
    if (d.itemId.present) {
      context.handle(
          _itemIdMeta, itemId.isAcceptableValue(d.itemId.value, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (d.homeId.present) {
      context.handle(
          _homeIdMeta, homeId.isAcceptableValue(d.homeId.value, _homeIdMeta));
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
  Map<String, Variable> entityToSql(ChangeTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<String, StringType>(d.userId.value);
    }
    if (d.value.present) {
      map['value'] = Variable<double, RealType>(d.value.value);
    }
    if (d.changeDate.present) {
      map['change_date'] = Variable<DateTime, DateTimeType>(d.changeDate.value);
    }
    if (d.itemId.present) {
      map['item_id'] = Variable<String, StringType>(d.itemId.value);
    }
    if (d.homeId.present) {
      map['home_id'] = Variable<String, StringType>(d.homeId.value);
    }
    return map;
  }

  @override
  $ChangeTableTable createAlias(String alias) {
    return $ChangeTableTable(_db, alias);
  }
}

class DatabaseChangelogEntry extends DataClass
    implements Insertable<DatabaseChangelogEntry> {
  final String id;
  final DateTime modificationDate;
  final String userId;
  final String categoryId;
  final String productId;
  final String itemId;
  final int direction;
  final String homeId;
  DatabaseChangelogEntry(
      {@required this.id,
      @required this.modificationDate,
      @required this.userId,
      this.categoryId,
      this.productId,
      this.itemId,
      @required this.direction,
      @required this.homeId});
  factory DatabaseChangelogEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return DatabaseChangelogEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      modificationDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}modification_date']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      categoryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      productId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      itemId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      direction:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}direction']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
    );
  }
  factory DatabaseChangelogEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DatabaseChangelogEntry(
      id: serializer.fromJson<String>(json['id']),
      modificationDate: serializer.fromJson<DateTime>(json['modificationDate']),
      userId: serializer.fromJson<String>(json['userId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      productId: serializer.fromJson<String>(json['productId']),
      itemId: serializer.fromJson<String>(json['itemId']),
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
      'categoryId': serializer.toJson<String>(categoryId),
      'productId': serializer.toJson<String>(productId),
      'itemId': serializer.toJson<String>(itemId),
      'direction': serializer.toJson<int>(direction),
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  @override
  DatabaseChangelogTableCompanion createCompanion(bool nullToAbsent) {
    return DatabaseChangelogTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      modificationDate: modificationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(modificationDate),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      homeId:
          homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
    );
  }

  DatabaseChangelogEntry copyWith(
          {String id,
          DateTime modificationDate,
          String userId,
          String categoryId,
          String productId,
          String itemId,
          int direction,
          String homeId}) =>
      DatabaseChangelogEntry(
        id: id ?? this.id,
        modificationDate: modificationDate ?? this.modificationDate,
        userId: userId ?? this.userId,
        categoryId: categoryId ?? this.categoryId,
        productId: productId ?? this.productId,
        itemId: itemId ?? this.itemId,
        direction: direction ?? this.direction,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('DatabaseChangelogEntry(')
          ..write('id: $id, ')
          ..write('modificationDate: $modificationDate, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('productId: $productId, ')
          ..write('itemId: $itemId, ')
          ..write('direction: $direction, ')
          ..write('homeId: $homeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          modificationDate.hashCode,
          $mrjc(
              userId.hashCode,
              $mrjc(
                  categoryId.hashCode,
                  $mrjc(
                      productId.hashCode,
                      $mrjc(itemId.hashCode,
                          $mrjc(direction.hashCode, homeId.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DatabaseChangelogEntry &&
          other.id == this.id &&
          other.modificationDate == this.modificationDate &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.productId == this.productId &&
          other.itemId == this.itemId &&
          other.direction == this.direction &&
          other.homeId == this.homeId);
}

class DatabaseChangelogTableCompanion
    extends UpdateCompanion<DatabaseChangelogEntry> {
  final Value<String> id;
  final Value<DateTime> modificationDate;
  final Value<String> userId;
  final Value<String> categoryId;
  final Value<String> productId;
  final Value<String> itemId;
  final Value<int> direction;
  final Value<String> homeId;
  const DatabaseChangelogTableCompanion({
    this.id = const Value.absent(),
    this.modificationDate = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.productId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.direction = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  DatabaseChangelogTableCompanion.insert({
    @required String id,
    @required DateTime modificationDate,
    @required String userId,
    this.categoryId = const Value.absent(),
    this.productId = const Value.absent(),
    this.itemId = const Value.absent(),
    @required int direction,
    @required String homeId,
  })  : id = Value(id),
        modificationDate = Value(modificationDate),
        userId = Value(userId),
        direction = Value(direction),
        homeId = Value(homeId);
  DatabaseChangelogTableCompanion copyWith(
      {Value<String> id,
      Value<DateTime> modificationDate,
      Value<String> userId,
      Value<String> categoryId,
      Value<String> productId,
      Value<String> itemId,
      Value<int> direction,
      Value<String> homeId}) {
    return DatabaseChangelogTableCompanion(
      id: id ?? this.id,
      modificationDate: modificationDate ?? this.modificationDate,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      productId: productId ?? this.productId,
      itemId: itemId ?? this.itemId,
      direction: direction ?? this.direction,
      homeId: homeId ?? this.homeId,
    );
  }
}

class $DatabaseChangelogTableTable extends DatabaseChangelogTable
    with TableInfo<$DatabaseChangelogTableTable, DatabaseChangelogEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $DatabaseChangelogTableTable(this._db, [this._alias]);
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

  final VerificationMeta _modificationDateMeta =
      const VerificationMeta('modificationDate');
  GeneratedDateTimeColumn _modificationDate;
  @override
  GeneratedDateTimeColumn get modificationDate =>
      _modificationDate ??= _constructModificationDate();
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

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedTextColumn _categoryId;
  @override
  GeneratedTextColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedTextColumn _constructCategoryId() {
    return GeneratedTextColumn('category_id', $tableName, true,
        $customConstraints: 'null references CategoryTable(id)');
  }

  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedTextColumn _productId;
  @override
  GeneratedTextColumn get productId => _productId ??= _constructProductId();
  GeneratedTextColumn _constructProductId() {
    return GeneratedTextColumn('product_id', $tableName, true,
        $customConstraints: 'null references ProductTable(id)');
  }

  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedTextColumn _itemId;
  @override
  GeneratedTextColumn get itemId => _itemId ??= _constructItemId();
  GeneratedTextColumn _constructItemId() {
    return GeneratedTextColumn('item_id', $tableName, true,
        $customConstraints: 'null references ItemTable(id)');
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
    return GeneratedTextColumn('home_id', $tableName, false,
        $customConstraints: 'references Home(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        modificationDate,
        userId,
        categoryId,
        productId,
        itemId,
        direction,
        homeId
      ];
  @override
  $DatabaseChangelogTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'database_changelog_table';
  @override
  final String actualTableName = 'database_changelog_table';
  @override
  VerificationContext validateIntegrity(DatabaseChangelogTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.modificationDate.present) {
      context.handle(
          _modificationDateMeta,
          modificationDate.isAcceptableValue(
              d.modificationDate.value, _modificationDateMeta));
    } else if (isInserting) {
      context.missing(_modificationDateMeta);
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (d.categoryId.present) {
      context.handle(_categoryIdMeta,
          categoryId.isAcceptableValue(d.categoryId.value, _categoryIdMeta));
    }
    if (d.productId.present) {
      context.handle(_productIdMeta,
          productId.isAcceptableValue(d.productId.value, _productIdMeta));
    }
    if (d.itemId.present) {
      context.handle(
          _itemIdMeta, itemId.isAcceptableValue(d.itemId.value, _itemIdMeta));
    }
    if (d.direction.present) {
      context.handle(_directionMeta,
          direction.isAcceptableValue(d.direction.value, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (d.homeId.present) {
      context.handle(
          _homeIdMeta, homeId.isAcceptableValue(d.homeId.value, _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseChangelogEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DatabaseChangelogEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DatabaseChangelogTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.modificationDate.present) {
      map['modification_date'] =
          Variable<DateTime, DateTimeType>(d.modificationDate.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<String, StringType>(d.userId.value);
    }
    if (d.categoryId.present) {
      map['category_id'] = Variable<String, StringType>(d.categoryId.value);
    }
    if (d.productId.present) {
      map['product_id'] = Variable<String, StringType>(d.productId.value);
    }
    if (d.itemId.present) {
      map['item_id'] = Variable<String, StringType>(d.itemId.value);
    }
    if (d.direction.present) {
      map['direction'] = Variable<int, IntType>(d.direction.value);
    }
    if (d.homeId.present) {
      map['home_id'] = Variable<String, StringType>(d.homeId.value);
    }
    return map;
  }

  @override
  $DatabaseChangelogTableTable createAlias(String alias) {
    return $DatabaseChangelogTableTable(_db, alias);
  }
}

class SyncEntry extends DataClass implements Insertable<SyncEntry> {
  final DateTime synchronizationDate;
  final String userId;
  final String homeId;
  SyncEntry(
      {@required this.synchronizationDate,
      @required this.userId,
      @required this.homeId});
  factory SyncEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return SyncEntry(
      synchronizationDate: dateTimeType.mapFromDatabaseResponse(
          data['${effectivePrefix}synchronization_date']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
    );
  }
  factory SyncEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SyncEntry(
      synchronizationDate:
          serializer.fromJson<DateTime>(json['synchronizationDate']),
      userId: serializer.fromJson<String>(json['userId']),
      homeId: serializer.fromJson<String>(json['homeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'synchronizationDate': serializer.toJson<DateTime>(synchronizationDate),
      'userId': serializer.toJson<String>(userId),
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  @override
  SyncTableCompanion createCompanion(bool nullToAbsent) {
    return SyncTableCompanion(
      synchronizationDate: synchronizationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(synchronizationDate),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      homeId:
          homeId == null && nullToAbsent ? const Value.absent() : Value(homeId),
    );
  }

  SyncEntry copyWith(
          {DateTime synchronizationDate, String userId, String homeId}) =>
      SyncEntry(
        synchronizationDate: synchronizationDate ?? this.synchronizationDate,
        userId: userId ?? this.userId,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('SyncEntry(')
          ..write('synchronizationDate: $synchronizationDate, ')
          ..write('userId: $userId, ')
          ..write('homeId: $homeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      synchronizationDate.hashCode, $mrjc(userId.hashCode, homeId.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SyncEntry &&
          other.synchronizationDate == this.synchronizationDate &&
          other.userId == this.userId &&
          other.homeId == this.homeId);
}

class SyncTableCompanion extends UpdateCompanion<SyncEntry> {
  final Value<DateTime> synchronizationDate;
  final Value<String> userId;
  final Value<String> homeId;
  const SyncTableCompanion({
    this.synchronizationDate = const Value.absent(),
    this.userId = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  SyncTableCompanion.insert({
    @required DateTime synchronizationDate,
    @required String userId,
    @required String homeId,
  })  : synchronizationDate = Value(synchronizationDate),
        userId = Value(userId),
        homeId = Value(homeId);
  SyncTableCompanion copyWith(
      {Value<DateTime> synchronizationDate,
      Value<String> userId,
      Value<String> homeId}) {
    return SyncTableCompanion(
      synchronizationDate: synchronizationDate ?? this.synchronizationDate,
      userId: userId ?? this.userId,
      homeId: homeId ?? this.homeId,
    );
  }
}

class $SyncTableTable extends SyncTable
    with TableInfo<$SyncTableTable, SyncEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $SyncTableTable(this._db, [this._alias]);
  final VerificationMeta _synchronizationDateMeta =
      const VerificationMeta('synchronizationDate');
  GeneratedDateTimeColumn _synchronizationDate;
  @override
  GeneratedDateTimeColumn get synchronizationDate =>
      _synchronizationDate ??= _constructSynchronizationDate();
  GeneratedDateTimeColumn _constructSynchronizationDate() {
    return GeneratedDateTimeColumn(
      'synchronization_date',
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

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn('home_id', $tableName, false,
        $customConstraints: 'references Home(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [synchronizationDate, userId, homeId];
  @override
  $SyncTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sync_table';
  @override
  final String actualTableName = 'sync_table';
  @override
  VerificationContext validateIntegrity(SyncTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.synchronizationDate.present) {
      context.handle(
          _synchronizationDateMeta,
          synchronizationDate.isAcceptableValue(
              d.synchronizationDate.value, _synchronizationDateMeta));
    } else if (isInserting) {
      context.missing(_synchronizationDateMeta);
    }
    if (d.userId.present) {
      context.handle(
          _userIdMeta, userId.isAcceptableValue(d.userId.value, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (d.homeId.present) {
      context.handle(
          _homeIdMeta, homeId.isAcceptableValue(d.homeId.value, _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  SyncEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SyncEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SyncTableCompanion d) {
    final map = <String, Variable>{};
    if (d.synchronizationDate.present) {
      map['synchronization_date'] =
          Variable<DateTime, DateTimeType>(d.synchronizationDate.value);
    }
    if (d.userId.present) {
      map['user_id'] = Variable<String, StringType>(d.userId.value);
    }
    if (d.homeId.present) {
      map['home_id'] = Variable<String, StringType>(d.homeId.value);
    }
    return map;
  }

  @override
  $SyncTableTable createAlias(String alias) {
    return $SyncTableTable(_db, alias);
  }
}

class UserEntry extends DataClass implements Insertable<UserEntry> {
  final String id;
  final String name;
  UserEntry({@required this.id, @required this.name});
  factory UserEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return UserEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory UserEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  UserTableCompanion createCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  UserEntry copyWith({String id, String name}) => UserEntry(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('UserEntry(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UserEntry && other.id == this.id && other.name == this.name);
}

class UserTableCompanion extends UpdateCompanion<UserEntry> {
  final Value<String> id;
  final Value<String> name;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  UserTableCompanion.insert({
    @required String id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  UserTableCompanion copyWith({Value<String> id, Value<String> name}) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserEntry> {
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

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $UserTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_table';
  @override
  final String actualTableName = 'user_table';
  @override
  VerificationContext validateIntegrity(UserTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Map<String, Variable> entityToSql(UserTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(_db, alias);
  }
}

class HomeEntry extends DataClass implements Insertable<HomeEntry> {
  final String id;
  final String name;
  HomeEntry({@required this.id, @required this.name});
  factory HomeEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return HomeEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory HomeEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HomeEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  HomeTableCompanion createCompanion(bool nullToAbsent) {
    return HomeTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  HomeEntry copyWith({String id, String name}) => HomeEntry(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('HomeEntry(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HomeEntry && other.id == this.id && other.name == this.name);
}

class HomeTableCompanion extends UpdateCompanion<HomeEntry> {
  final Value<String> id;
  final Value<String> name;
  const HomeTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  HomeTableCompanion.insert({
    @required String id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  HomeTableCompanion copyWith({Value<String> id, Value<String> name}) {
    return HomeTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $HomeTableTable extends HomeTable
    with TableInfo<$HomeTableTable, HomeEntry> {
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

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $HomeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'home_table';
  @override
  final String actualTableName = 'home_table';
  @override
  VerificationContext validateIntegrity(HomeTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Map<String, Variable> entityToSql(HomeTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $HomeTableTable createAlias(String alias) {
    return $HomeTableTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ItemTableTable _itemTable;
  $ItemTableTable get itemTable => _itemTable ??= $ItemTableTable(this);
  $ProductTableTable _productTable;
  $ProductTableTable get productTable =>
      _productTable ??= $ProductTableTable(this);
  $CategoryTableTable _categoryTable;
  $CategoryTableTable get categoryTable =>
      _categoryTable ??= $CategoryTableTable(this);
  $ChangeTableTable _changeTable;
  $ChangeTableTable get changeTable => _changeTable ??= $ChangeTableTable(this);
  $DatabaseChangelogTableTable _databaseChangelogTable;
  $DatabaseChangelogTableTable get databaseChangelogTable =>
      _databaseChangelogTable ??= $DatabaseChangelogTableTable(this);
  $SyncTableTable _syncTable;
  $SyncTableTable get syncTable => _syncTable ??= $SyncTableTable(this);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  $HomeTableTable _homeTable;
  $HomeTableTable get homeTable => _homeTable ??= $HomeTableTable(this);
  ItemRepository _itemRepository;
  ItemRepository get itemRepository =>
      _itemRepository ??= ItemRepository(this as Database);
  ProductRepository _productRepository;
  ProductRepository get productRepository =>
      _productRepository ??= ProductRepository(this as Database);
  CategoryRepository _categoryRepository;
  CategoryRepository get categoryRepository =>
      _categoryRepository ??= CategoryRepository(this as Database);
  ChangeRepository _changeRepository;
  ChangeRepository get changeRepository =>
      _changeRepository ??= ChangeRepository(this as Database);
  DatabaseChangelogRepository _databaseChangelogRepository;
  DatabaseChangelogRepository get databaseChangelogRepository =>
      _databaseChangelogRepository ??=
          DatabaseChangelogRepository(this as Database);
  SyncRepository _syncRepository;
  SyncRepository get syncRepository =>
      _syncRepository ??= SyncRepository(this as Database);
  UserRepository _userRepository;
  UserRepository get userRepository =>
      _userRepository ??= UserRepository(this as Database);
  HomeRepository _homeRepository;
  HomeRepository get homeRepository =>
      _homeRepository ??= HomeRepository(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        itemTable,
        productTable,
        categoryTable,
        changeTable,
        databaseChangelogTable,
        syncTable,
        userTable,
        homeTable
      ];
}
