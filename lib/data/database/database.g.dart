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
    if (!nullToAbsent || notificationDate != null) {
      map['notification_date'] = Variable<DateTime>(notificationDate);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
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
  static Insertable<ItemEntry> custom({
    Expression<String> id,
    Expression<String> productId,
    Expression<DateTime> expirationDate,
    Expression<DateTime> notificationDate,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (notificationDate != null) 'notification_date': notificationDate,
      if (homeId != null) 'home_id': homeId,
    });
  }

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
    if (notificationDate.present) {
      map['notification_date'] = Variable<DateTime>(notificationDate.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    return map;
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
  VerificationContext validateIntegrity(Insertable<ItemEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
          _expirationDateMeta,
          expirationDate.isAcceptableOrUnknown(
              data['expiration_date'], _expirationDateMeta));
    }
    if (data.containsKey('notification_date')) {
      context.handle(
          _notificationDateMeta,
          notificationDate.isAcceptableOrUnknown(
              data['notification_date'], _notificationDateMeta));
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || ean != null) {
      map['ean'] = Variable<String>(ean);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
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
  static Insertable<ProductEntry> custom({
    Expression<String> id,
    Expression<String> ean,
    Expression<String> categoryId,
    Expression<String> description,
    Expression<String> homeId,
    Expression<double> refillLimit,
    Expression<int> unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ean != null) 'ean': ean,
      if (categoryId != null) 'category_id': categoryId,
      if (description != null) 'description': description,
      if (homeId != null) 'home_id': homeId,
      if (refillLimit != null) 'refill_limit': refillLimit,
      if (unit != null) 'unit': unit,
    });
  }

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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ean.present) {
      map['ean'] = Variable<String>(ean.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
    return GeneratedTextColumn('ean', $tableName, true,
        $customConstraints: 'unique');
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
    return GeneratedTextColumn('description', $tableName, false,
        $customConstraints: 'unique');
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
  VerificationContext validateIntegrity(Insertable<ProductEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ean')) {
      context.handle(
          _eanMeta, ean.isAcceptableOrUnknown(data['ean'], _eanMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id'], _categoryIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    if (data.containsKey('refill_limit')) {
      context.handle(
          _refillLimitMeta,
          refillLimit.isAcceptableOrUnknown(
              data['refill_limit'], _refillLimitMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit'], _unitMeta));
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
  static Insertable<CategoryEntry> custom({
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
    return GeneratedTextColumn('plural_name', $tableName, true,
        $customConstraints: 'unique');
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
  VerificationContext validateIntegrity(Insertable<CategoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('plural_name')) {
      context.handle(
          _pluralNameMeta,
          pluralName.isAcceptableOrUnknown(
              data['plural_name'], _pluralNameMeta));
    }
    if (data.containsKey('warn_interval')) {
      context.handle(
          _warnIntervalMeta,
          warnInterval.isAcceptableOrUnknown(
              data['warn_interval'], _warnIntervalMeta));
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
    }
    if (data.containsKey('refill_limit')) {
      context.handle(
          _refillLimitMeta,
          refillLimit.isAcceptableOrUnknown(
              data['refill_limit'], _refillLimitMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit'], _unitMeta));
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
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<String>(itemId);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
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
  static Insertable<ChangeEntry> custom({
    Expression<String> id,
    Expression<String> userId,
    Expression<double> value,
    Expression<DateTime> changeDate,
    Expression<String> itemId,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (value != null) 'value': value,
      if (changeDate != null) 'change_date': changeDate,
      if (itemId != null) 'item_id': itemId,
      if (homeId != null) 'home_id': homeId,
    });
  }

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
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    return map;
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
  VerificationContext validateIntegrity(Insertable<ChangeEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('change_date')) {
      context.handle(
          _changeDateMeta,
          changeDate.isAcceptableOrUnknown(
              data['change_date'], _changeDateMeta));
    } else if (isInserting) {
      context.missing(_changeDateMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
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

class ModelChangeEntry extends DataClass
    implements Insertable<ModelChangeEntry> {
  final String id;
  final DateTime modificationDate;
  final String userId;
  final String categoryId;
  final String productId;
  final String itemId;
  final int direction;
  final String homeId;
  ModelChangeEntry(
      {@required this.id,
      @required this.modificationDate,
      @required this.userId,
      this.categoryId,
      this.productId,
      this.itemId,
      @required this.direction,
      @required this.homeId});
  factory ModelChangeEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return ModelChangeEntry(
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
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<String>(itemId);
    }
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<int>(direction);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
  }

  factory ModelChangeEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ModelChangeEntry(
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

  ModelChangeEntry copyWith(
          {String id,
          DateTime modificationDate,
          String userId,
          String categoryId,
          String productId,
          String itemId,
          int direction,
          String homeId}) =>
      ModelChangeEntry(
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
    return (StringBuffer('ModelChangeEntry(')
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
      (other is ModelChangeEntry &&
          other.id == this.id &&
          other.modificationDate == this.modificationDate &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.productId == this.productId &&
          other.itemId == this.itemId &&
          other.direction == this.direction &&
          other.homeId == this.homeId);
}

class ModelChangeTableCompanion extends UpdateCompanion<ModelChangeEntry> {
  final Value<String> id;
  final Value<DateTime> modificationDate;
  final Value<String> userId;
  final Value<String> categoryId;
  final Value<String> productId;
  final Value<String> itemId;
  final Value<int> direction;
  final Value<String> homeId;
  const ModelChangeTableCompanion({
    this.id = const Value.absent(),
    this.modificationDate = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.productId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.direction = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  ModelChangeTableCompanion.insert({
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
  static Insertable<ModelChangeEntry> custom({
    Expression<String> id,
    Expression<DateTime> modificationDate,
    Expression<String> userId,
    Expression<String> categoryId,
    Expression<String> productId,
    Expression<String> itemId,
    Expression<int> direction,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (modificationDate != null) 'modification_date': modificationDate,
      if (userId != null) 'user_id': userId,
      if (categoryId != null) 'category_id': categoryId,
      if (productId != null) 'product_id': productId,
      if (itemId != null) 'item_id': itemId,
      if (direction != null) 'direction': direction,
      if (homeId != null) 'home_id': homeId,
    });
  }

  ModelChangeTableCompanion copyWith(
      {Value<String> id,
      Value<DateTime> modificationDate,
      Value<String> userId,
      Value<String> categoryId,
      Value<String> productId,
      Value<String> itemId,
      Value<int> direction,
      Value<String> homeId}) {
    return ModelChangeTableCompanion(
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
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
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

class $ModelChangeTableTable extends ModelChangeTable
    with TableInfo<$ModelChangeTableTable, ModelChangeEntry> {
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
  $ModelChangeTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'model_change_table';
  @override
  final String actualTableName = 'model_change_table';
  @override
  VerificationContext validateIntegrity(Insertable<ModelChangeEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('modification_date')) {
      context.handle(
          _modificationDateMeta,
          modificationDate.isAcceptableOrUnknown(
              data['modification_date'], _modificationDateMeta));
    } else if (isInserting) {
      context.missing(_modificationDateMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id'], _categoryIdMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction'], _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || synchronizationDate != null) {
      map['synchronization_date'] = Variable<DateTime>(synchronizationDate);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
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
  static Insertable<SyncEntry> custom({
    Expression<DateTime> synchronizationDate,
    Expression<String> userId,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (synchronizationDate != null)
        'synchronization_date': synchronizationDate,
      if (userId != null) 'user_id': userId,
      if (homeId != null) 'home_id': homeId,
    });
  }

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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (synchronizationDate.present) {
      map['synchronization_date'] =
          Variable<DateTime>(synchronizationDate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    return map;
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
  VerificationContext validateIntegrity(Insertable<SyncEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('synchronization_date')) {
      context.handle(
          _synchronizationDateMeta,
          synchronizationDate.isAcceptableOrUnknown(
              data['synchronization_date'], _synchronizationDateMeta));
    } else if (isInserting) {
      context.missing(_synchronizationDateMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
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
  static Insertable<UserEntry> custom({
    Expression<String> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  UserTableCompanion copyWith({Value<String> id, Value<String> name}) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
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
  VerificationContext validateIntegrity(Insertable<UserEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
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
  static Insertable<HomeEntry> custom({
    Expression<String> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  HomeTableCompanion copyWith({Value<String> id, Value<String> name}) {
    return HomeTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
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
  VerificationContext validateIntegrity(Insertable<HomeEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
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
  $HomeTableTable createAlias(String alias) {
    return $HomeTableTable(_db, alias);
  }
}

class ModificationEntry extends DataClass
    implements Insertable<ModificationEntry> {
  final String id;
  final String modelChangeId;
  final String fieldName;
  final String from;
  final String to;
  final String homeId;
  ModificationEntry(
      {@required this.id,
      @required this.modelChangeId,
      @required this.fieldName,
      this.from,
      this.to,
      @required this.homeId});
  factory ModificationEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ModificationEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      modelChangeId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}model_change_id']),
      fieldName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}field_name']),
      from: stringType.mapFromDatabaseResponse(data['${effectivePrefix}from']),
      to: stringType.mapFromDatabaseResponse(data['${effectivePrefix}to']),
      homeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}home_id']),
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
    if (!nullToAbsent || homeId != null) {
      map['home_id'] = Variable<String>(homeId);
    }
    return map;
  }

  factory ModificationEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ModificationEntry(
      id: serializer.fromJson<String>(json['id']),
      modelChangeId: serializer.fromJson<String>(json['modelChangeId']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      from: serializer.fromJson<String>(json['from']),
      to: serializer.fromJson<String>(json['to']),
      homeId: serializer.fromJson<String>(json['homeId']),
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
      'homeId': serializer.toJson<String>(homeId),
    };
  }

  ModificationEntry copyWith(
          {String id,
          String modelChangeId,
          String fieldName,
          String from,
          String to,
          String homeId}) =>
      ModificationEntry(
        id: id ?? this.id,
        modelChangeId: modelChangeId ?? this.modelChangeId,
        fieldName: fieldName ?? this.fieldName,
        from: from ?? this.from,
        to: to ?? this.to,
        homeId: homeId ?? this.homeId,
      );
  @override
  String toString() {
    return (StringBuffer('ModificationEntry(')
          ..write('id: $id, ')
          ..write('modelChangeId: $modelChangeId, ')
          ..write('fieldName: $fieldName, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('homeId: $homeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          modelChangeId.hashCode,
          $mrjc(fieldName.hashCode,
              $mrjc(from.hashCode, $mrjc(to.hashCode, homeId.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ModificationEntry &&
          other.id == this.id &&
          other.modelChangeId == this.modelChangeId &&
          other.fieldName == this.fieldName &&
          other.from == this.from &&
          other.to == this.to &&
          other.homeId == this.homeId);
}

class ModificationTableCompanion extends UpdateCompanion<ModificationEntry> {
  final Value<String> id;
  final Value<String> modelChangeId;
  final Value<String> fieldName;
  final Value<String> from;
  final Value<String> to;
  final Value<String> homeId;
  const ModificationTableCompanion({
    this.id = const Value.absent(),
    this.modelChangeId = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
    this.homeId = const Value.absent(),
  });
  ModificationTableCompanion.insert({
    @required String id,
    @required String modelChangeId,
    @required String fieldName,
    this.from = const Value.absent(),
    this.to = const Value.absent(),
    @required String homeId,
  })  : id = Value(id),
        modelChangeId = Value(modelChangeId),
        fieldName = Value(fieldName),
        homeId = Value(homeId);
  static Insertable<ModificationEntry> custom({
    Expression<String> id,
    Expression<String> modelChangeId,
    Expression<String> fieldName,
    Expression<String> from,
    Expression<String> to,
    Expression<String> homeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (modelChangeId != null) 'model_change_id': modelChangeId,
      if (fieldName != null) 'field_name': fieldName,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (homeId != null) 'home_id': homeId,
    });
  }

  ModificationTableCompanion copyWith(
      {Value<String> id,
      Value<String> modelChangeId,
      Value<String> fieldName,
      Value<String> from,
      Value<String> to,
      Value<String> homeId}) {
    return ModificationTableCompanion(
      id: id ?? this.id,
      modelChangeId: modelChangeId ?? this.modelChangeId,
      fieldName: fieldName ?? this.fieldName,
      from: from ?? this.from,
      to: to ?? this.to,
      homeId: homeId ?? this.homeId,
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
    if (homeId.present) {
      map['home_id'] = Variable<String>(homeId.value);
    }
    return map;
  }
}

class $ModificationTableTable extends ModificationTable
    with TableInfo<$ModificationTableTable, ModificationEntry> {
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

  final VerificationMeta _modelChangeIdMeta =
      const VerificationMeta('modelChangeId');
  GeneratedTextColumn _modelChangeId;
  @override
  GeneratedTextColumn get modelChangeId =>
      _modelChangeId ??= _constructModelChangeId();
  GeneratedTextColumn _constructModelChangeId() {
    return GeneratedTextColumn('model_change_id', $tableName, false,
        $customConstraints: 'references ModelChangeTable(id)');
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

  final VerificationMeta _homeIdMeta = const VerificationMeta('homeId');
  GeneratedTextColumn _homeId;
  @override
  GeneratedTextColumn get homeId => _homeId ??= _constructHomeId();
  GeneratedTextColumn _constructHomeId() {
    return GeneratedTextColumn(
      'home_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, modelChangeId, fieldName, from, to, homeId];
  @override
  $ModificationTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'modification_table';
  @override
  final String actualTableName = 'modification_table';
  @override
  VerificationContext validateIntegrity(Insertable<ModificationEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('model_change_id')) {
      context.handle(
          _modelChangeIdMeta,
          modelChangeId.isAcceptableOrUnknown(
              data['model_change_id'], _modelChangeIdMeta));
    } else if (isInserting) {
      context.missing(_modelChangeIdMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(_fieldNameMeta,
          fieldName.isAcceptableOrUnknown(data['field_name'], _fieldNameMeta));
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('from')) {
      context.handle(
          _fromMeta, from.isAcceptableOrUnknown(data['from'], _fromMeta));
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to'], _toMeta));
    }
    if (data.containsKey('home_id')) {
      context.handle(_homeIdMeta,
          homeId.isAcceptableOrUnknown(data['home_id'], _homeIdMeta));
    } else if (isInserting) {
      context.missing(_homeIdMeta);
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
  $ModelChangeTableTable _modelChangeTable;
  $ModelChangeTableTable get modelChangeTable =>
      _modelChangeTable ??= $ModelChangeTableTable(this);
  $SyncTableTable _syncTable;
  $SyncTableTable get syncTable => _syncTable ??= $SyncTableTable(this);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  $HomeTableTable _homeTable;
  $HomeTableTable get homeTable => _homeTable ??= $HomeTableTable(this);
  $ModificationTableTable _modificationTable;
  $ModificationTableTable get modificationTable =>
      _modificationTable ??= $ModificationTableTable(this);
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
  ModelChangeRepository _modelChangeRepository;
  ModelChangeRepository get modelChangeRepository =>
      _modelChangeRepository ??= ModelChangeRepository(this as Database);
  SyncRepository _syncRepository;
  SyncRepository get syncRepository =>
      _syncRepository ??= SyncRepository(this as Database);
  UserRepository _userRepository;
  UserRepository get userRepository =>
      _userRepository ??= UserRepository(this as Database);
  HomeRepository _homeRepository;
  HomeRepository get homeRepository =>
      _homeRepository ??= HomeRepository(this as Database);
  ModificationRepository _modificationRepository;
  ModificationRepository get modificationRepository =>
      _modificationRepository ??= ModificationRepository(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        itemTable,
        productTable,
        categoryTable,
        changeTable,
        modelChangeTable,
        syncTable,
        userTable,
        homeTable,
        modificationTable
      ];
}
