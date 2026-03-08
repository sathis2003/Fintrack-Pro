// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ExpensesTable extends Expenses
    with TableInfo<$ExpensesTable, ExpenseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isRecurringMeta =
      const VerificationMeta('isRecurring');
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
      'is_recurring', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_recurring" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('chat'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('INR'));
  static const VerificationMeta _exchangeRateMeta =
      const VerificationMeta('exchangeRate');
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
      'exchange_rate', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        userId,
        amount,
        category,
        description,
        date,
        isRecurring,
        source,
        syncStatus,
        createdAt,
        updatedAt,
        isDeleted,
        currency,
        exchangeRate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
          _isRecurringMeta,
          isRecurring.isAcceptableOrUnknown(
              data['is_recurring']!, _isRecurringMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
          _exchangeRateMeta,
          exchangeRate.isAcceptableOrUnknown(
              data['exchange_rate']!, _exchangeRateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      isRecurring: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_recurring'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      exchangeRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}exchange_rate'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class ExpenseData extends DataClass implements Insertable<ExpenseData> {
  final int id;
  final String uuid;
  final String userId;
  final double amount;
  final String category;
  final String description;
  final int date;
  final bool isRecurring;
  final String source;
  final String syncStatus;
  final int createdAt;
  final int updatedAt;
  final bool isDeleted;
  final String currency;
  final double exchangeRate;
  const ExpenseData(
      {required this.id,
      required this.uuid,
      required this.userId,
      required this.amount,
      required this.category,
      required this.description,
      required this.date,
      required this.isRecurring,
      required this.source,
      required this.syncStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.isDeleted,
      required this.currency,
      required this.exchangeRate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_id'] = Variable<String>(userId);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<int>(date);
    map['is_recurring'] = Variable<bool>(isRecurring);
    map['source'] = Variable<String>(source);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['currency'] = Variable<String>(currency);
    map['exchange_rate'] = Variable<double>(exchangeRate);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userId: Value(userId),
      amount: Value(amount),
      category: Value(category),
      description: Value(description),
      date: Value(date),
      isRecurring: Value(isRecurring),
      source: Value(source),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      currency: Value(currency),
      exchangeRate: Value(exchangeRate),
    );
  }

  factory ExpenseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userId: serializer.fromJson<String>(json['userId']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<int>(json['date']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      source: serializer.fromJson<String>(json['source']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      currency: serializer.fromJson<String>(json['currency']),
      exchangeRate: serializer.fromJson<double>(json['exchangeRate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userId': serializer.toJson<String>(userId),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<int>(date),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'source': serializer.toJson<String>(source),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'currency': serializer.toJson<String>(currency),
      'exchangeRate': serializer.toJson<double>(exchangeRate),
    };
  }

  ExpenseData copyWith(
          {int? id,
          String? uuid,
          String? userId,
          double? amount,
          String? category,
          String? description,
          int? date,
          bool? isRecurring,
          String? source,
          String? syncStatus,
          int? createdAt,
          int? updatedAt,
          bool? isDeleted,
          String? currency,
          double? exchangeRate}) =>
      ExpenseData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        userId: userId ?? this.userId,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        description: description ?? this.description,
        date: date ?? this.date,
        isRecurring: isRecurring ?? this.isRecurring,
        source: source ?? this.source,
        syncStatus: syncStatus ?? this.syncStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        currency: currency ?? this.currency,
        exchangeRate: exchangeRate ?? this.exchangeRate,
      );
  ExpenseData copyWithCompanion(ExpensesCompanion data) {
    return ExpenseData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userId: data.userId.present ? data.userId.value : this.userId,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      date: data.date.present ? data.date.value : this.date,
      isRecurring:
          data.isRecurring.present ? data.isRecurring.value : this.isRecurring,
      source: data.source.present ? data.source.value : this.source,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      currency: data.currency.present ? data.currency.value : this.currency,
      exchangeRate: data.exchangeRate.present
          ? data.exchangeRate.value
          : this.exchangeRate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('source: $source, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('currency: $currency, ')
          ..write('exchangeRate: $exchangeRate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      userId,
      amount,
      category,
      description,
      date,
      isRecurring,
      source,
      syncStatus,
      createdAt,
      updatedAt,
      isDeleted,
      currency,
      exchangeRate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userId == this.userId &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.description == this.description &&
          other.date == this.date &&
          other.isRecurring == this.isRecurring &&
          other.source == this.source &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.currency == this.currency &&
          other.exchangeRate == this.exchangeRate);
}

class ExpensesCompanion extends UpdateCompanion<ExpenseData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userId;
  final Value<double> amount;
  final Value<String> category;
  final Value<String> description;
  final Value<int> date;
  final Value<bool> isRecurring;
  final Value<String> source;
  final Value<String> syncStatus;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<bool> isDeleted;
  final Value<String> currency;
  final Value<double> exchangeRate;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userId = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.source = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.currency = const Value.absent(),
    this.exchangeRate = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String userId,
    required double amount,
    required String category,
    this.description = const Value.absent(),
    required int date,
    this.isRecurring = const Value.absent(),
    this.source = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.isDeleted = const Value.absent(),
    this.currency = const Value.absent(),
    this.exchangeRate = const Value.absent(),
  })  : uuid = Value(uuid),
        userId = Value(userId),
        amount = Value(amount),
        category = Value(category),
        date = Value(date),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ExpenseData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userId,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? date,
    Expression<bool>? isRecurring,
    Expression<String>? source,
    Expression<String>? syncStatus,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? currency,
    Expression<double>? exchangeRate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userId != null) 'user_id': userId,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (source != null) 'source': source,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (currency != null) 'currency': currency,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? userId,
      Value<double>? amount,
      Value<String>? category,
      Value<String>? description,
      Value<int>? date,
      Value<bool>? isRecurring,
      Value<String>? source,
      Value<String>? syncStatus,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<bool>? isDeleted,
      Value<String>? currency,
      Value<double>? exchangeRate}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      isRecurring: isRecurring ?? this.isRecurring,
      source: source ?? this.source,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      currency: currency ?? this.currency,
      exchangeRate: exchangeRate ?? this.exchangeRate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('source: $source, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('currency: $currency, ')
          ..write('exchangeRate: $exchangeRate')
          ..write(')'))
        .toString();
  }
}

class $PendingSyncsTable extends PendingSyncs
    with TableInfo<$PendingSyncsTable, PendingSync> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingSyncsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tableIdentifierMeta =
      const VerificationMeta('tableIdentifier');
  @override
  late final GeneratedColumn<String> tableIdentifier = GeneratedColumn<String>(
      'table_identifier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordUuidMeta =
      const VerificationMeta('recordUuid');
  @override
  late final GeneratedColumn<String> recordUuid = GeneratedColumn<String>(
      'record_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tableIdentifier,
        recordUuid,
        operation,
        payload,
        createdAt,
        retryCount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_syncs';
  @override
  VerificationContext validateIntegrity(Insertable<PendingSync> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('table_identifier')) {
      context.handle(
          _tableIdentifierMeta,
          tableIdentifier.isAcceptableOrUnknown(
              data['table_identifier']!, _tableIdentifierMeta));
    } else if (isInserting) {
      context.missing(_tableIdentifierMeta);
    }
    if (data.containsKey('record_uuid')) {
      context.handle(
          _recordUuidMeta,
          recordUuid.isAcceptableOrUnknown(
              data['record_uuid']!, _recordUuidMeta));
    } else if (isInserting) {
      context.missing(_recordUuidMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingSync map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingSync(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tableIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}table_identifier'])!,
      recordUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}record_uuid'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
    );
  }

  @override
  $PendingSyncsTable createAlias(String alias) {
    return $PendingSyncsTable(attachedDatabase, alias);
  }
}

class PendingSync extends DataClass implements Insertable<PendingSync> {
  final int id;
  final String tableIdentifier;
  final String recordUuid;
  final String operation;
  final String payload;
  final int createdAt;
  final int retryCount;
  const PendingSync(
      {required this.id,
      required this.tableIdentifier,
      required this.recordUuid,
      required this.operation,
      required this.payload,
      required this.createdAt,
      required this.retryCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['table_identifier'] = Variable<String>(tableIdentifier);
    map['record_uuid'] = Variable<String>(recordUuid);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<int>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  PendingSyncsCompanion toCompanion(bool nullToAbsent) {
    return PendingSyncsCompanion(
      id: Value(id),
      tableIdentifier: Value(tableIdentifier),
      recordUuid: Value(recordUuid),
      operation: Value(operation),
      payload: Value(payload),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
    );
  }

  factory PendingSync.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingSync(
      id: serializer.fromJson<int>(json['id']),
      tableIdentifier: serializer.fromJson<String>(json['tableIdentifier']),
      recordUuid: serializer.fromJson<String>(json['recordUuid']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tableIdentifier': serializer.toJson<String>(tableIdentifier),
      'recordUuid': serializer.toJson<String>(recordUuid),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<int>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  PendingSync copyWith(
          {int? id,
          String? tableIdentifier,
          String? recordUuid,
          String? operation,
          String? payload,
          int? createdAt,
          int? retryCount}) =>
      PendingSync(
        id: id ?? this.id,
        tableIdentifier: tableIdentifier ?? this.tableIdentifier,
        recordUuid: recordUuid ?? this.recordUuid,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        createdAt: createdAt ?? this.createdAt,
        retryCount: retryCount ?? this.retryCount,
      );
  PendingSync copyWithCompanion(PendingSyncsCompanion data) {
    return PendingSync(
      id: data.id.present ? data.id.value : this.id,
      tableIdentifier: data.tableIdentifier.present
          ? data.tableIdentifier.value
          : this.tableIdentifier,
      recordUuid:
          data.recordUuid.present ? data.recordUuid.value : this.recordUuid,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingSync(')
          ..write('id: $id, ')
          ..write('tableIdentifier: $tableIdentifier, ')
          ..write('recordUuid: $recordUuid, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tableIdentifier, recordUuid, operation,
      payload, createdAt, retryCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingSync &&
          other.id == this.id &&
          other.tableIdentifier == this.tableIdentifier &&
          other.recordUuid == this.recordUuid &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount);
}

class PendingSyncsCompanion extends UpdateCompanion<PendingSync> {
  final Value<int> id;
  final Value<String> tableIdentifier;
  final Value<String> recordUuid;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> createdAt;
  final Value<int> retryCount;
  const PendingSyncsCompanion({
    this.id = const Value.absent(),
    this.tableIdentifier = const Value.absent(),
    this.recordUuid = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
  });
  PendingSyncsCompanion.insert({
    this.id = const Value.absent(),
    required String tableIdentifier,
    required String recordUuid,
    required String operation,
    required String payload,
    required int createdAt,
    this.retryCount = const Value.absent(),
  })  : tableIdentifier = Value(tableIdentifier),
        recordUuid = Value(recordUuid),
        operation = Value(operation),
        payload = Value(payload),
        createdAt = Value(createdAt);
  static Insertable<PendingSync> custom({
    Expression<int>? id,
    Expression<String>? tableIdentifier,
    Expression<String>? recordUuid,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? createdAt,
    Expression<int>? retryCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tableIdentifier != null) 'table_identifier': tableIdentifier,
      if (recordUuid != null) 'record_uuid': recordUuid,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
    });
  }

  PendingSyncsCompanion copyWith(
      {Value<int>? id,
      Value<String>? tableIdentifier,
      Value<String>? recordUuid,
      Value<String>? operation,
      Value<String>? payload,
      Value<int>? createdAt,
      Value<int>? retryCount}) {
    return PendingSyncsCompanion(
      id: id ?? this.id,
      tableIdentifier: tableIdentifier ?? this.tableIdentifier,
      recordUuid: recordUuid ?? this.recordUuid,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tableIdentifier.present) {
      map['table_identifier'] = Variable<String>(tableIdentifier.value);
    }
    if (recordUuid.present) {
      map['record_uuid'] = Variable<String>(recordUuid.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncsCompanion(')
          ..write('id: $id, ')
          ..write('tableIdentifier: $tableIdentifier, ')
          ..write('recordUuid: $recordUuid, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }
}

class $FinancialProfilesTable extends FinancialProfiles
    with TableInfo<$FinancialProfilesTable, FinancialProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthlyIncomeMeta =
      const VerificationMeta('monthlyIncome');
  @override
  late final GeneratedColumn<double> monthlyIncome = GeneratedColumn<double>(
      'monthly_income', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _incomeDayMeta =
      const VerificationMeta('incomeDay');
  @override
  late final GeneratedColumn<int> incomeDay = GeneratedColumn<int>(
      'income_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('INR'));
  static const VerificationMeta _budgetAlertsEnabledMeta =
      const VerificationMeta('budgetAlertsEnabled');
  @override
  late final GeneratedColumn<bool> budgetAlertsEnabled = GeneratedColumn<bool>(
      'budget_alerts_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("budget_alerts_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _offlineModeOnlyMeta =
      const VerificationMeta('offlineModeOnly');
  @override
  late final GeneratedColumn<bool> offlineModeOnly = GeneratedColumn<bool>(
      'offline_mode_only', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("offline_mode_only" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastTrackedDateMeta =
      const VerificationMeta('lastTrackedDate');
  @override
  late final GeneratedColumn<String> lastTrackedDate = GeneratedColumn<String>(
      'last_tracked_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        monthlyIncome,
        incomeDay,
        currency,
        budgetAlertsEnabled,
        offlineModeOnly,
        updatedAt,
        currentStreak,
        longestStreak,
        lastTrackedDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<FinancialProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('monthly_income')) {
      context.handle(
          _monthlyIncomeMeta,
          monthlyIncome.isAcceptableOrUnknown(
              data['monthly_income']!, _monthlyIncomeMeta));
    }
    if (data.containsKey('income_day')) {
      context.handle(_incomeDayMeta,
          incomeDay.isAcceptableOrUnknown(data['income_day']!, _incomeDayMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('budget_alerts_enabled')) {
      context.handle(
          _budgetAlertsEnabledMeta,
          budgetAlertsEnabled.isAcceptableOrUnknown(
              data['budget_alerts_enabled']!, _budgetAlertsEnabledMeta));
    }
    if (data.containsKey('offline_mode_only')) {
      context.handle(
          _offlineModeOnlyMeta,
          offlineModeOnly.isAcceptableOrUnknown(
              data['offline_mode_only']!, _offlineModeOnlyMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('last_tracked_date')) {
      context.handle(
          _lastTrackedDateMeta,
          lastTrackedDate.isAcceptableOrUnknown(
              data['last_tracked_date']!, _lastTrackedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      monthlyIncome: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monthly_income'])!,
      incomeDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}income_day'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      budgetAlertsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}budget_alerts_enabled'])!,
      offlineModeOnly: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}offline_mode_only'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      lastTrackedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_tracked_date']),
    );
  }

  @override
  $FinancialProfilesTable createAlias(String alias) {
    return $FinancialProfilesTable(attachedDatabase, alias);
  }
}

class FinancialProfile extends DataClass
    implements Insertable<FinancialProfile> {
  final int id;
  final String userId;
  final double monthlyIncome;
  final int incomeDay;
  final String currency;
  final bool budgetAlertsEnabled;
  final bool offlineModeOnly;
  final int updatedAt;
  final int currentStreak;
  final int longestStreak;
  final String? lastTrackedDate;
  const FinancialProfile(
      {required this.id,
      required this.userId,
      required this.monthlyIncome,
      required this.incomeDay,
      required this.currency,
      required this.budgetAlertsEnabled,
      required this.offlineModeOnly,
      required this.updatedAt,
      required this.currentStreak,
      required this.longestStreak,
      this.lastTrackedDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['monthly_income'] = Variable<double>(monthlyIncome);
    map['income_day'] = Variable<int>(incomeDay);
    map['currency'] = Variable<String>(currency);
    map['budget_alerts_enabled'] = Variable<bool>(budgetAlertsEnabled);
    map['offline_mode_only'] = Variable<bool>(offlineModeOnly);
    map['updated_at'] = Variable<int>(updatedAt);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastTrackedDate != null) {
      map['last_tracked_date'] = Variable<String>(lastTrackedDate);
    }
    return map;
  }

  FinancialProfilesCompanion toCompanion(bool nullToAbsent) {
    return FinancialProfilesCompanion(
      id: Value(id),
      userId: Value(userId),
      monthlyIncome: Value(monthlyIncome),
      incomeDay: Value(incomeDay),
      currency: Value(currency),
      budgetAlertsEnabled: Value(budgetAlertsEnabled),
      offlineModeOnly: Value(offlineModeOnly),
      updatedAt: Value(updatedAt),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastTrackedDate: lastTrackedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTrackedDate),
    );
  }

  factory FinancialProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialProfile(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      monthlyIncome: serializer.fromJson<double>(json['monthlyIncome']),
      incomeDay: serializer.fromJson<int>(json['incomeDay']),
      currency: serializer.fromJson<String>(json['currency']),
      budgetAlertsEnabled:
          serializer.fromJson<bool>(json['budgetAlertsEnabled']),
      offlineModeOnly: serializer.fromJson<bool>(json['offlineModeOnly']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastTrackedDate: serializer.fromJson<String?>(json['lastTrackedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'monthlyIncome': serializer.toJson<double>(monthlyIncome),
      'incomeDay': serializer.toJson<int>(incomeDay),
      'currency': serializer.toJson<String>(currency),
      'budgetAlertsEnabled': serializer.toJson<bool>(budgetAlertsEnabled),
      'offlineModeOnly': serializer.toJson<bool>(offlineModeOnly),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastTrackedDate': serializer.toJson<String?>(lastTrackedDate),
    };
  }

  FinancialProfile copyWith(
          {int? id,
          String? userId,
          double? monthlyIncome,
          int? incomeDay,
          String? currency,
          bool? budgetAlertsEnabled,
          bool? offlineModeOnly,
          int? updatedAt,
          int? currentStreak,
          int? longestStreak,
          Value<String?> lastTrackedDate = const Value.absent()}) =>
      FinancialProfile(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        monthlyIncome: monthlyIncome ?? this.monthlyIncome,
        incomeDay: incomeDay ?? this.incomeDay,
        currency: currency ?? this.currency,
        budgetAlertsEnabled: budgetAlertsEnabled ?? this.budgetAlertsEnabled,
        offlineModeOnly: offlineModeOnly ?? this.offlineModeOnly,
        updatedAt: updatedAt ?? this.updatedAt,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        lastTrackedDate: lastTrackedDate.present
            ? lastTrackedDate.value
            : this.lastTrackedDate,
      );
  FinancialProfile copyWithCompanion(FinancialProfilesCompanion data) {
    return FinancialProfile(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      monthlyIncome: data.monthlyIncome.present
          ? data.monthlyIncome.value
          : this.monthlyIncome,
      incomeDay: data.incomeDay.present ? data.incomeDay.value : this.incomeDay,
      currency: data.currency.present ? data.currency.value : this.currency,
      budgetAlertsEnabled: data.budgetAlertsEnabled.present
          ? data.budgetAlertsEnabled.value
          : this.budgetAlertsEnabled,
      offlineModeOnly: data.offlineModeOnly.present
          ? data.offlineModeOnly.value
          : this.offlineModeOnly,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      lastTrackedDate: data.lastTrackedDate.present
          ? data.lastTrackedDate.value
          : this.lastTrackedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialProfile(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('monthlyIncome: $monthlyIncome, ')
          ..write('incomeDay: $incomeDay, ')
          ..write('currency: $currency, ')
          ..write('budgetAlertsEnabled: $budgetAlertsEnabled, ')
          ..write('offlineModeOnly: $offlineModeOnly, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastTrackedDate: $lastTrackedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      monthlyIncome,
      incomeDay,
      currency,
      budgetAlertsEnabled,
      offlineModeOnly,
      updatedAt,
      currentStreak,
      longestStreak,
      lastTrackedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialProfile &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.monthlyIncome == this.monthlyIncome &&
          other.incomeDay == this.incomeDay &&
          other.currency == this.currency &&
          other.budgetAlertsEnabled == this.budgetAlertsEnabled &&
          other.offlineModeOnly == this.offlineModeOnly &&
          other.updatedAt == this.updatedAt &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastTrackedDate == this.lastTrackedDate);
}

class FinancialProfilesCompanion extends UpdateCompanion<FinancialProfile> {
  final Value<int> id;
  final Value<String> userId;
  final Value<double> monthlyIncome;
  final Value<int> incomeDay;
  final Value<String> currency;
  final Value<bool> budgetAlertsEnabled;
  final Value<bool> offlineModeOnly;
  final Value<int> updatedAt;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<String?> lastTrackedDate;
  const FinancialProfilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.monthlyIncome = const Value.absent(),
    this.incomeDay = const Value.absent(),
    this.currency = const Value.absent(),
    this.budgetAlertsEnabled = const Value.absent(),
    this.offlineModeOnly = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastTrackedDate = const Value.absent(),
  });
  FinancialProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.monthlyIncome = const Value.absent(),
    this.incomeDay = const Value.absent(),
    this.currency = const Value.absent(),
    this.budgetAlertsEnabled = const Value.absent(),
    this.offlineModeOnly = const Value.absent(),
    required int updatedAt,
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastTrackedDate = const Value.absent(),
  })  : userId = Value(userId),
        updatedAt = Value(updatedAt);
  static Insertable<FinancialProfile> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<double>? monthlyIncome,
    Expression<int>? incomeDay,
    Expression<String>? currency,
    Expression<bool>? budgetAlertsEnabled,
    Expression<bool>? offlineModeOnly,
    Expression<int>? updatedAt,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<String>? lastTrackedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (monthlyIncome != null) 'monthly_income': monthlyIncome,
      if (incomeDay != null) 'income_day': incomeDay,
      if (currency != null) 'currency': currency,
      if (budgetAlertsEnabled != null)
        'budget_alerts_enabled': budgetAlertsEnabled,
      if (offlineModeOnly != null) 'offline_mode_only': offlineModeOnly,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastTrackedDate != null) 'last_tracked_date': lastTrackedDate,
    });
  }

  FinancialProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<double>? monthlyIncome,
      Value<int>? incomeDay,
      Value<String>? currency,
      Value<bool>? budgetAlertsEnabled,
      Value<bool>? offlineModeOnly,
      Value<int>? updatedAt,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<String?>? lastTrackedDate}) {
    return FinancialProfilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      incomeDay: incomeDay ?? this.incomeDay,
      currency: currency ?? this.currency,
      budgetAlertsEnabled: budgetAlertsEnabled ?? this.budgetAlertsEnabled,
      offlineModeOnly: offlineModeOnly ?? this.offlineModeOnly,
      updatedAt: updatedAt ?? this.updatedAt,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastTrackedDate: lastTrackedDate ?? this.lastTrackedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (monthlyIncome.present) {
      map['monthly_income'] = Variable<double>(monthlyIncome.value);
    }
    if (incomeDay.present) {
      map['income_day'] = Variable<int>(incomeDay.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (budgetAlertsEnabled.present) {
      map['budget_alerts_enabled'] = Variable<bool>(budgetAlertsEnabled.value);
    }
    if (offlineModeOnly.present) {
      map['offline_mode_only'] = Variable<bool>(offlineModeOnly.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastTrackedDate.present) {
      map['last_tracked_date'] = Variable<String>(lastTrackedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialProfilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('monthlyIncome: $monthlyIncome, ')
          ..write('incomeDay: $incomeDay, ')
          ..write('currency: $currency, ')
          ..write('budgetAlertsEnabled: $budgetAlertsEnabled, ')
          ..write('offlineModeOnly: $offlineModeOnly, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastTrackedDate: $lastTrackedDate')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, BudgetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuid, userId, category, amount, month, syncStatus, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class BudgetData extends DataClass implements Insertable<BudgetData> {
  final int id;
  final String uuid;
  final String userId;
  final String category;
  final double amount;
  final int month;
  final String syncStatus;
  final int updatedAt;
  const BudgetData(
      {required this.id,
      required this.uuid,
      required this.userId,
      required this.category,
      required this.amount,
      required this.month,
      required this.syncStatus,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_id'] = Variable<String>(userId);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['month'] = Variable<int>(month);
    map['sync_status'] = Variable<String>(syncStatus);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userId: Value(userId),
      category: Value(category),
      amount: Value(amount),
      month: Value(month),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory BudgetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userId: serializer.fromJson<String>(json['userId']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      month: serializer.fromJson<int>(json['month']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userId': serializer.toJson<String>(userId),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'month': serializer.toJson<int>(month),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  BudgetData copyWith(
          {int? id,
          String? uuid,
          String? userId,
          String? category,
          double? amount,
          int? month,
          String? syncStatus,
          int? updatedAt}) =>
      BudgetData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        userId: userId ?? this.userId,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        month: month ?? this.month,
        syncStatus: syncStatus ?? this.syncStatus,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BudgetData copyWithCompanion(BudgetsCompanion data) {
    return BudgetData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userId: data.userId.present ? data.userId.value : this.userId,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      month: data.month.present ? data.month.value : this.month,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('month: $month, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uuid, userId, category, amount, month, syncStatus, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userId == this.userId &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.month == this.month &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class BudgetsCompanion extends UpdateCompanion<BudgetData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userId;
  final Value<String> category;
  final Value<double> amount;
  final Value<int> month;
  final Value<String> syncStatus;
  final Value<int> updatedAt;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userId = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.month = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BudgetsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String userId,
    required String category,
    required double amount,
    required int month,
    this.syncStatus = const Value.absent(),
    required int updatedAt,
  })  : uuid = Value(uuid),
        userId = Value(userId),
        category = Value(category),
        amount = Value(amount),
        month = Value(month),
        updatedAt = Value(updatedAt);
  static Insertable<BudgetData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userId,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<int>? month,
    Expression<String>? syncStatus,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userId != null) 'user_id': userId,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (month != null) 'month': month,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BudgetsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? userId,
      Value<String>? category,
      Value<double>? amount,
      Value<int>? month,
      Value<String>? syncStatus,
      Value<int>? updatedAt}) {
    return BudgetsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      month: month ?? this.month,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('month: $month, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AiInsightsTable extends AiInsights
    with TableInfo<$AiInsightsTable, AiInsightData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiInsightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _riskLevelMeta =
      const VerificationMeta('riskLevel');
  @override
  late final GeneratedColumn<String> riskLevel = GeneratedColumn<String>(
      'risk_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _riskScoreMeta =
      const VerificationMeta('riskScore');
  @override
  late final GeneratedColumn<int> riskScore = GeneratedColumn<int>(
      'risk_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _suggestionsMeta =
      const VerificationMeta('suggestions');
  @override
  late final GeneratedColumn<String> suggestions = GeneratedColumn<String>(
      'suggestions', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positiveNoteMeta =
      const VerificationMeta('positiveNote');
  @override
  late final GeneratedColumn<String> positiveNote = GeneratedColumn<String>(
      'positive_note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _exhaustionDateMeta =
      const VerificationMeta('exhaustionDate');
  @override
  late final GeneratedColumn<int> exhaustionDate = GeneratedColumn<int>(
      'exhaustion_date', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<int> generatedAt = GeneratedColumn<int>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        month,
        riskLevel,
        riskScore,
        summary,
        suggestions,
        positiveNote,
        exhaustionDate,
        generatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_insights';
  @override
  VerificationContext validateIntegrity(Insertable<AiInsightData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('risk_level')) {
      context.handle(_riskLevelMeta,
          riskLevel.isAcceptableOrUnknown(data['risk_level']!, _riskLevelMeta));
    } else if (isInserting) {
      context.missing(_riskLevelMeta);
    }
    if (data.containsKey('risk_score')) {
      context.handle(_riskScoreMeta,
          riskScore.isAcceptableOrUnknown(data['risk_score']!, _riskScoreMeta));
    } else if (isInserting) {
      context.missing(_riskScoreMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('suggestions')) {
      context.handle(
          _suggestionsMeta,
          suggestions.isAcceptableOrUnknown(
              data['suggestions']!, _suggestionsMeta));
    } else if (isInserting) {
      context.missing(_suggestionsMeta);
    }
    if (data.containsKey('positive_note')) {
      context.handle(
          _positiveNoteMeta,
          positiveNote.isAcceptableOrUnknown(
              data['positive_note']!, _positiveNoteMeta));
    }
    if (data.containsKey('exhaustion_date')) {
      context.handle(
          _exhaustionDateMeta,
          exhaustionDate.isAcceptableOrUnknown(
              data['exhaustion_date']!, _exhaustionDateMeta));
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiInsightData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiInsightData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      riskLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}risk_level'])!,
      riskScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}risk_score'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      suggestions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}suggestions'])!,
      positiveNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}positive_note']),
      exhaustionDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exhaustion_date']),
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}generated_at'])!,
    );
  }

  @override
  $AiInsightsTable createAlias(String alias) {
    return $AiInsightsTable(attachedDatabase, alias);
  }
}

class AiInsightData extends DataClass implements Insertable<AiInsightData> {
  final int id;
  final String userId;
  final int month;
  final String riskLevel;
  final int riskScore;
  final String summary;
  final String suggestions;
  final String? positiveNote;
  final int? exhaustionDate;
  final int generatedAt;
  const AiInsightData(
      {required this.id,
      required this.userId,
      required this.month,
      required this.riskLevel,
      required this.riskScore,
      required this.summary,
      required this.suggestions,
      this.positiveNote,
      this.exhaustionDate,
      required this.generatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['month'] = Variable<int>(month);
    map['risk_level'] = Variable<String>(riskLevel);
    map['risk_score'] = Variable<int>(riskScore);
    map['summary'] = Variable<String>(summary);
    map['suggestions'] = Variable<String>(suggestions);
    if (!nullToAbsent || positiveNote != null) {
      map['positive_note'] = Variable<String>(positiveNote);
    }
    if (!nullToAbsent || exhaustionDate != null) {
      map['exhaustion_date'] = Variable<int>(exhaustionDate);
    }
    map['generated_at'] = Variable<int>(generatedAt);
    return map;
  }

  AiInsightsCompanion toCompanion(bool nullToAbsent) {
    return AiInsightsCompanion(
      id: Value(id),
      userId: Value(userId),
      month: Value(month),
      riskLevel: Value(riskLevel),
      riskScore: Value(riskScore),
      summary: Value(summary),
      suggestions: Value(suggestions),
      positiveNote: positiveNote == null && nullToAbsent
          ? const Value.absent()
          : Value(positiveNote),
      exhaustionDate: exhaustionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(exhaustionDate),
      generatedAt: Value(generatedAt),
    );
  }

  factory AiInsightData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiInsightData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      month: serializer.fromJson<int>(json['month']),
      riskLevel: serializer.fromJson<String>(json['riskLevel']),
      riskScore: serializer.fromJson<int>(json['riskScore']),
      summary: serializer.fromJson<String>(json['summary']),
      suggestions: serializer.fromJson<String>(json['suggestions']),
      positiveNote: serializer.fromJson<String?>(json['positiveNote']),
      exhaustionDate: serializer.fromJson<int?>(json['exhaustionDate']),
      generatedAt: serializer.fromJson<int>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'month': serializer.toJson<int>(month),
      'riskLevel': serializer.toJson<String>(riskLevel),
      'riskScore': serializer.toJson<int>(riskScore),
      'summary': serializer.toJson<String>(summary),
      'suggestions': serializer.toJson<String>(suggestions),
      'positiveNote': serializer.toJson<String?>(positiveNote),
      'exhaustionDate': serializer.toJson<int?>(exhaustionDate),
      'generatedAt': serializer.toJson<int>(generatedAt),
    };
  }

  AiInsightData copyWith(
          {int? id,
          String? userId,
          int? month,
          String? riskLevel,
          int? riskScore,
          String? summary,
          String? suggestions,
          Value<String?> positiveNote = const Value.absent(),
          Value<int?> exhaustionDate = const Value.absent(),
          int? generatedAt}) =>
      AiInsightData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        month: month ?? this.month,
        riskLevel: riskLevel ?? this.riskLevel,
        riskScore: riskScore ?? this.riskScore,
        summary: summary ?? this.summary,
        suggestions: suggestions ?? this.suggestions,
        positiveNote:
            positiveNote.present ? positiveNote.value : this.positiveNote,
        exhaustionDate:
            exhaustionDate.present ? exhaustionDate.value : this.exhaustionDate,
        generatedAt: generatedAt ?? this.generatedAt,
      );
  AiInsightData copyWithCompanion(AiInsightsCompanion data) {
    return AiInsightData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      month: data.month.present ? data.month.value : this.month,
      riskLevel: data.riskLevel.present ? data.riskLevel.value : this.riskLevel,
      riskScore: data.riskScore.present ? data.riskScore.value : this.riskScore,
      summary: data.summary.present ? data.summary.value : this.summary,
      suggestions:
          data.suggestions.present ? data.suggestions.value : this.suggestions,
      positiveNote: data.positiveNote.present
          ? data.positiveNote.value
          : this.positiveNote,
      exhaustionDate: data.exhaustionDate.present
          ? data.exhaustionDate.value
          : this.exhaustionDate,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiInsightData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('month: $month, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('riskScore: $riskScore, ')
          ..write('summary: $summary, ')
          ..write('suggestions: $suggestions, ')
          ..write('positiveNote: $positiveNote, ')
          ..write('exhaustionDate: $exhaustionDate, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, month, riskLevel, riskScore,
      summary, suggestions, positiveNote, exhaustionDate, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiInsightData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.month == this.month &&
          other.riskLevel == this.riskLevel &&
          other.riskScore == this.riskScore &&
          other.summary == this.summary &&
          other.suggestions == this.suggestions &&
          other.positiveNote == this.positiveNote &&
          other.exhaustionDate == this.exhaustionDate &&
          other.generatedAt == this.generatedAt);
}

class AiInsightsCompanion extends UpdateCompanion<AiInsightData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> month;
  final Value<String> riskLevel;
  final Value<int> riskScore;
  final Value<String> summary;
  final Value<String> suggestions;
  final Value<String?> positiveNote;
  final Value<int?> exhaustionDate;
  final Value<int> generatedAt;
  const AiInsightsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.month = const Value.absent(),
    this.riskLevel = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.summary = const Value.absent(),
    this.suggestions = const Value.absent(),
    this.positiveNote = const Value.absent(),
    this.exhaustionDate = const Value.absent(),
    this.generatedAt = const Value.absent(),
  });
  AiInsightsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int month,
    required String riskLevel,
    required int riskScore,
    required String summary,
    required String suggestions,
    this.positiveNote = const Value.absent(),
    this.exhaustionDate = const Value.absent(),
    required int generatedAt,
  })  : userId = Value(userId),
        month = Value(month),
        riskLevel = Value(riskLevel),
        riskScore = Value(riskScore),
        summary = Value(summary),
        suggestions = Value(suggestions),
        generatedAt = Value(generatedAt);
  static Insertable<AiInsightData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? month,
    Expression<String>? riskLevel,
    Expression<int>? riskScore,
    Expression<String>? summary,
    Expression<String>? suggestions,
    Expression<String>? positiveNote,
    Expression<int>? exhaustionDate,
    Expression<int>? generatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (month != null) 'month': month,
      if (riskLevel != null) 'risk_level': riskLevel,
      if (riskScore != null) 'risk_score': riskScore,
      if (summary != null) 'summary': summary,
      if (suggestions != null) 'suggestions': suggestions,
      if (positiveNote != null) 'positive_note': positiveNote,
      if (exhaustionDate != null) 'exhaustion_date': exhaustionDate,
      if (generatedAt != null) 'generated_at': generatedAt,
    });
  }

  AiInsightsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<int>? month,
      Value<String>? riskLevel,
      Value<int>? riskScore,
      Value<String>? summary,
      Value<String>? suggestions,
      Value<String?>? positiveNote,
      Value<int?>? exhaustionDate,
      Value<int>? generatedAt}) {
    return AiInsightsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      month: month ?? this.month,
      riskLevel: riskLevel ?? this.riskLevel,
      riskScore: riskScore ?? this.riskScore,
      summary: summary ?? this.summary,
      suggestions: suggestions ?? this.suggestions,
      positiveNote: positiveNote ?? this.positiveNote,
      exhaustionDate: exhaustionDate ?? this.exhaustionDate,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (riskLevel.present) {
      map['risk_level'] = Variable<String>(riskLevel.value);
    }
    if (riskScore.present) {
      map['risk_score'] = Variable<int>(riskScore.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (suggestions.present) {
      map['suggestions'] = Variable<String>(suggestions.value);
    }
    if (positiveNote.present) {
      map['positive_note'] = Variable<String>(positiveNote.value);
    }
    if (exhaustionDate.present) {
      map['exhaustion_date'] = Variable<int>(exhaustionDate.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<int>(generatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiInsightsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('month: $month, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('riskScore: $riskScore, ')
          ..write('summary: $summary, ')
          ..write('suggestions: $suggestions, ')
          ..write('positiveNote: $positiveNote, ')
          ..write('exhaustionDate: $exhaustionDate, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }
}

class $RecurringExpensesTableTable extends RecurringExpensesTable
    with TableInfo<$RecurringExpensesTableTable, RecurringExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _averageAmountMeta =
      const VerificationMeta('averageAmount');
  @override
  late final GeneratedColumn<double> averageAmount = GeneratedColumn<double>(
      'average_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dayOfMonthMeta =
      const VerificationMeta('dayOfMonth');
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
      'day_of_month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _reminderEnabledMeta =
      const VerificationMeta('reminderEnabled');
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
      'reminder_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminder_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _reminderDaysBeforeMeta =
      const VerificationMeta('reminderDaysBefore');
  @override
  late final GeneratedColumn<int> reminderDaysBefore = GeneratedColumn<int>(
      'reminder_days_before', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _lastOccurrenceMeta =
      const VerificationMeta('lastOccurrence');
  @override
  late final GeneratedColumn<String> lastOccurrence = GeneratedColumn<String>(
      'last_occurrence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextExpectedDateMeta =
      const VerificationMeta('nextExpectedDate');
  @override
  late final GeneratedColumn<String> nextExpectedDate = GeneratedColumn<String>(
      'next_expected_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        userId,
        category,
        description,
        averageAmount,
        dayOfMonth,
        frequency,
        isActive,
        reminderEnabled,
        reminderDaysBefore,
        lastOccurrence,
        nextExpectedDate,
        syncStatus,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_expenses_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecurringExpensesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('average_amount')) {
      context.handle(
          _averageAmountMeta,
          averageAmount.isAcceptableOrUnknown(
              data['average_amount']!, _averageAmountMeta));
    } else if (isInserting) {
      context.missing(_averageAmountMeta);
    }
    if (data.containsKey('day_of_month')) {
      context.handle(
          _dayOfMonthMeta,
          dayOfMonth.isAcceptableOrUnknown(
              data['day_of_month']!, _dayOfMonthMeta));
    } else if (isInserting) {
      context.missing(_dayOfMonthMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
          _reminderEnabledMeta,
          reminderEnabled.isAcceptableOrUnknown(
              data['reminder_enabled']!, _reminderEnabledMeta));
    }
    if (data.containsKey('reminder_days_before')) {
      context.handle(
          _reminderDaysBeforeMeta,
          reminderDaysBefore.isAcceptableOrUnknown(
              data['reminder_days_before']!, _reminderDaysBeforeMeta));
    }
    if (data.containsKey('last_occurrence')) {
      context.handle(
          _lastOccurrenceMeta,
          lastOccurrence.isAcceptableOrUnknown(
              data['last_occurrence']!, _lastOccurrenceMeta));
    } else if (isInserting) {
      context.missing(_lastOccurrenceMeta);
    }
    if (data.containsKey('next_expected_date')) {
      context.handle(
          _nextExpectedDateMeta,
          nextExpectedDate.isAcceptableOrUnknown(
              data['next_expected_date']!, _nextExpectedDateMeta));
    } else if (isInserting) {
      context.missing(_nextExpectedDateMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringExpensesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringExpensesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      averageAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}average_amount'])!,
      dayOfMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_month'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      reminderEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reminder_enabled'])!,
      reminderDaysBefore: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}reminder_days_before'])!,
      lastOccurrence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_occurrence'])!,
      nextExpectedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}next_expected_date'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RecurringExpensesTableTable createAlias(String alias) {
    return $RecurringExpensesTableTable(attachedDatabase, alias);
  }
}

class RecurringExpensesTableData extends DataClass
    implements Insertable<RecurringExpensesTableData> {
  final int id;
  final String uuid;
  final String userId;
  final String category;
  final String description;
  final double averageAmount;
  final int dayOfMonth;
  final String frequency;
  final bool isActive;
  final bool reminderEnabled;
  final int reminderDaysBefore;
  final String lastOccurrence;
  final String nextExpectedDate;
  final String syncStatus;
  final DateTime createdAt;
  const RecurringExpensesTableData(
      {required this.id,
      required this.uuid,
      required this.userId,
      required this.category,
      required this.description,
      required this.averageAmount,
      required this.dayOfMonth,
      required this.frequency,
      required this.isActive,
      required this.reminderEnabled,
      required this.reminderDaysBefore,
      required this.lastOccurrence,
      required this.nextExpectedDate,
      required this.syncStatus,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_id'] = Variable<String>(userId);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['average_amount'] = Variable<double>(averageAmount);
    map['day_of_month'] = Variable<int>(dayOfMonth);
    map['frequency'] = Variable<String>(frequency);
    map['is_active'] = Variable<bool>(isActive);
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['reminder_days_before'] = Variable<int>(reminderDaysBefore);
    map['last_occurrence'] = Variable<String>(lastOccurrence);
    map['next_expected_date'] = Variable<String>(nextExpectedDate);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecurringExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return RecurringExpensesTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userId: Value(userId),
      category: Value(category),
      description: Value(description),
      averageAmount: Value(averageAmount),
      dayOfMonth: Value(dayOfMonth),
      frequency: Value(frequency),
      isActive: Value(isActive),
      reminderEnabled: Value(reminderEnabled),
      reminderDaysBefore: Value(reminderDaysBefore),
      lastOccurrence: Value(lastOccurrence),
      nextExpectedDate: Value(nextExpectedDate),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
    );
  }

  factory RecurringExpensesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringExpensesTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userId: serializer.fromJson<String>(json['userId']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      averageAmount: serializer.fromJson<double>(json['averageAmount']),
      dayOfMonth: serializer.fromJson<int>(json['dayOfMonth']),
      frequency: serializer.fromJson<String>(json['frequency']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      reminderDaysBefore: serializer.fromJson<int>(json['reminderDaysBefore']),
      lastOccurrence: serializer.fromJson<String>(json['lastOccurrence']),
      nextExpectedDate: serializer.fromJson<String>(json['nextExpectedDate']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userId': serializer.toJson<String>(userId),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'averageAmount': serializer.toJson<double>(averageAmount),
      'dayOfMonth': serializer.toJson<int>(dayOfMonth),
      'frequency': serializer.toJson<String>(frequency),
      'isActive': serializer.toJson<bool>(isActive),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'reminderDaysBefore': serializer.toJson<int>(reminderDaysBefore),
      'lastOccurrence': serializer.toJson<String>(lastOccurrence),
      'nextExpectedDate': serializer.toJson<String>(nextExpectedDate),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecurringExpensesTableData copyWith(
          {int? id,
          String? uuid,
          String? userId,
          String? category,
          String? description,
          double? averageAmount,
          int? dayOfMonth,
          String? frequency,
          bool? isActive,
          bool? reminderEnabled,
          int? reminderDaysBefore,
          String? lastOccurrence,
          String? nextExpectedDate,
          String? syncStatus,
          DateTime? createdAt}) =>
      RecurringExpensesTableData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        userId: userId ?? this.userId,
        category: category ?? this.category,
        description: description ?? this.description,
        averageAmount: averageAmount ?? this.averageAmount,
        dayOfMonth: dayOfMonth ?? this.dayOfMonth,
        frequency: frequency ?? this.frequency,
        isActive: isActive ?? this.isActive,
        reminderEnabled: reminderEnabled ?? this.reminderEnabled,
        reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
        lastOccurrence: lastOccurrence ?? this.lastOccurrence,
        nextExpectedDate: nextExpectedDate ?? this.nextExpectedDate,
        syncStatus: syncStatus ?? this.syncStatus,
        createdAt: createdAt ?? this.createdAt,
      );
  RecurringExpensesTableData copyWithCompanion(
      RecurringExpensesTableCompanion data) {
    return RecurringExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userId: data.userId.present ? data.userId.value : this.userId,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      averageAmount: data.averageAmount.present
          ? data.averageAmount.value
          : this.averageAmount,
      dayOfMonth:
          data.dayOfMonth.present ? data.dayOfMonth.value : this.dayOfMonth,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderDaysBefore: data.reminderDaysBefore.present
          ? data.reminderDaysBefore.value
          : this.reminderDaysBefore,
      lastOccurrence: data.lastOccurrence.present
          ? data.lastOccurrence.value
          : this.lastOccurrence,
      nextExpectedDate: data.nextExpectedDate.present
          ? data.nextExpectedDate.value
          : this.nextExpectedDate,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringExpensesTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('averageAmount: $averageAmount, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('frequency: $frequency, ')
          ..write('isActive: $isActive, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('lastOccurrence: $lastOccurrence, ')
          ..write('nextExpectedDate: $nextExpectedDate, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      userId,
      category,
      description,
      averageAmount,
      dayOfMonth,
      frequency,
      isActive,
      reminderEnabled,
      reminderDaysBefore,
      lastOccurrence,
      nextExpectedDate,
      syncStatus,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringExpensesTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userId == this.userId &&
          other.category == this.category &&
          other.description == this.description &&
          other.averageAmount == this.averageAmount &&
          other.dayOfMonth == this.dayOfMonth &&
          other.frequency == this.frequency &&
          other.isActive == this.isActive &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderDaysBefore == this.reminderDaysBefore &&
          other.lastOccurrence == this.lastOccurrence &&
          other.nextExpectedDate == this.nextExpectedDate &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt);
}

class RecurringExpensesTableCompanion
    extends UpdateCompanion<RecurringExpensesTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userId;
  final Value<String> category;
  final Value<String> description;
  final Value<double> averageAmount;
  final Value<int> dayOfMonth;
  final Value<String> frequency;
  final Value<bool> isActive;
  final Value<bool> reminderEnabled;
  final Value<int> reminderDaysBefore;
  final Value<String> lastOccurrence;
  final Value<String> nextExpectedDate;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  const RecurringExpensesTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userId = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.averageAmount = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.frequency = const Value.absent(),
    this.isActive = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.lastOccurrence = const Value.absent(),
    this.nextExpectedDate = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecurringExpensesTableCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String userId,
    required String category,
    required String description,
    required double averageAmount,
    required int dayOfMonth,
    required String frequency,
    this.isActive = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    required String lastOccurrence,
    required String nextExpectedDate,
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : uuid = Value(uuid),
        userId = Value(userId),
        category = Value(category),
        description = Value(description),
        averageAmount = Value(averageAmount),
        dayOfMonth = Value(dayOfMonth),
        frequency = Value(frequency),
        lastOccurrence = Value(lastOccurrence),
        nextExpectedDate = Value(nextExpectedDate);
  static Insertable<RecurringExpensesTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userId,
    Expression<String>? category,
    Expression<String>? description,
    Expression<double>? averageAmount,
    Expression<int>? dayOfMonth,
    Expression<String>? frequency,
    Expression<bool>? isActive,
    Expression<bool>? reminderEnabled,
    Expression<int>? reminderDaysBefore,
    Expression<String>? lastOccurrence,
    Expression<String>? nextExpectedDate,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userId != null) 'user_id': userId,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (averageAmount != null) 'average_amount': averageAmount,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (frequency != null) 'frequency': frequency,
      if (isActive != null) 'is_active': isActive,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderDaysBefore != null)
        'reminder_days_before': reminderDaysBefore,
      if (lastOccurrence != null) 'last_occurrence': lastOccurrence,
      if (nextExpectedDate != null) 'next_expected_date': nextExpectedDate,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecurringExpensesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? userId,
      Value<String>? category,
      Value<String>? description,
      Value<double>? averageAmount,
      Value<int>? dayOfMonth,
      Value<String>? frequency,
      Value<bool>? isActive,
      Value<bool>? reminderEnabled,
      Value<int>? reminderDaysBefore,
      Value<String>? lastOccurrence,
      Value<String>? nextExpectedDate,
      Value<String>? syncStatus,
      Value<DateTime>? createdAt}) {
    return RecurringExpensesTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      description: description ?? this.description,
      averageAmount: averageAmount ?? this.averageAmount,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      frequency: frequency ?? this.frequency,
      isActive: isActive ?? this.isActive,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      lastOccurrence: lastOccurrence ?? this.lastOccurrence,
      nextExpectedDate: nextExpectedDate ?? this.nextExpectedDate,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (averageAmount.present) {
      map['average_amount'] = Variable<double>(averageAmount.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (reminderDaysBefore.present) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore.value);
    }
    if (lastOccurrence.present) {
      map['last_occurrence'] = Variable<String>(lastOccurrence.value);
    }
    if (nextExpectedDate.present) {
      map['next_expected_date'] = Variable<String>(nextExpectedDate.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('averageAmount: $averageAmount, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('frequency: $frequency, ')
          ..write('isActive: $isActive, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('lastOccurrence: $lastOccurrence, ')
          ..write('nextExpectedDate: $nextExpectedDate, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTableTable extends AchievementsTable
    with TableInfo<$AchievementsTableTable, AchievementsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badgeIdMeta =
      const VerificationMeta('badgeId');
  @override
  late final GeneratedColumn<String> badgeId = GeneratedColumn<String>(
      'badge_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badgeNameMeta =
      const VerificationMeta('badgeName');
  @override
  late final GeneratedColumn<String> badgeName = GeneratedColumn<String>(
      'badge_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badgeDescriptionMeta =
      const VerificationMeta('badgeDescription');
  @override
  late final GeneratedColumn<String> badgeDescription = GeneratedColumn<String>(
      'badge_description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badgeIconMeta =
      const VerificationMeta('badgeIcon');
  @override
  late final GeneratedColumn<String> badgeIcon = GeneratedColumn<String>(
      'badge_icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isUnlockedMeta =
      const VerificationMeta('isUnlocked');
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
      'is_unlocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_unlocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _unlockedAtMeta =
      const VerificationMeta('unlockedAt');
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
      'unlocked_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        badgeId,
        badgeName,
        badgeDescription,
        badgeIcon,
        isUnlocked,
        unlockedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AchievementsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('badge_id')) {
      context.handle(_badgeIdMeta,
          badgeId.isAcceptableOrUnknown(data['badge_id']!, _badgeIdMeta));
    } else if (isInserting) {
      context.missing(_badgeIdMeta);
    }
    if (data.containsKey('badge_name')) {
      context.handle(_badgeNameMeta,
          badgeName.isAcceptableOrUnknown(data['badge_name']!, _badgeNameMeta));
    } else if (isInserting) {
      context.missing(_badgeNameMeta);
    }
    if (data.containsKey('badge_description')) {
      context.handle(
          _badgeDescriptionMeta,
          badgeDescription.isAcceptableOrUnknown(
              data['badge_description']!, _badgeDescriptionMeta));
    } else if (isInserting) {
      context.missing(_badgeDescriptionMeta);
    }
    if (data.containsKey('badge_icon')) {
      context.handle(_badgeIconMeta,
          badgeIcon.isAcceptableOrUnknown(data['badge_icon']!, _badgeIconMeta));
    } else if (isInserting) {
      context.missing(_badgeIconMeta);
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
          _isUnlockedMeta,
          isUnlocked.isAcceptableOrUnknown(
              data['is_unlocked']!, _isUnlockedMeta));
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
          _unlockedAtMeta,
          unlockedAt.isAcceptableOrUnknown(
              data['unlocked_at']!, _unlockedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AchievementsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      badgeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}badge_id'])!,
      badgeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}badge_name'])!,
      badgeDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}badge_description'])!,
      badgeIcon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}badge_icon'])!,
      isUnlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unlocked'])!,
      unlockedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}unlocked_at']),
    );
  }

  @override
  $AchievementsTableTable createAlias(String alias) {
    return $AchievementsTableTable(attachedDatabase, alias);
  }
}

class AchievementsTableData extends DataClass
    implements Insertable<AchievementsTableData> {
  final int id;
  final String userId;
  final String badgeId;
  final String badgeName;
  final String badgeDescription;
  final String badgeIcon;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  const AchievementsTableData(
      {required this.id,
      required this.userId,
      required this.badgeId,
      required this.badgeName,
      required this.badgeDescription,
      required this.badgeIcon,
      required this.isUnlocked,
      this.unlockedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['badge_id'] = Variable<String>(badgeId);
    map['badge_name'] = Variable<String>(badgeName);
    map['badge_description'] = Variable<String>(badgeDescription);
    map['badge_icon'] = Variable<String>(badgeIcon);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  AchievementsTableCompanion toCompanion(bool nullToAbsent) {
    return AchievementsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      badgeId: Value(badgeId),
      badgeName: Value(badgeName),
      badgeDescription: Value(badgeDescription),
      badgeIcon: Value(badgeIcon),
      isUnlocked: Value(isUnlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory AchievementsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementsTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      badgeId: serializer.fromJson<String>(json['badgeId']),
      badgeName: serializer.fromJson<String>(json['badgeName']),
      badgeDescription: serializer.fromJson<String>(json['badgeDescription']),
      badgeIcon: serializer.fromJson<String>(json['badgeIcon']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'badgeId': serializer.toJson<String>(badgeId),
      'badgeName': serializer.toJson<String>(badgeName),
      'badgeDescription': serializer.toJson<String>(badgeDescription),
      'badgeIcon': serializer.toJson<String>(badgeIcon),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  AchievementsTableData copyWith(
          {int? id,
          String? userId,
          String? badgeId,
          String? badgeName,
          String? badgeDescription,
          String? badgeIcon,
          bool? isUnlocked,
          Value<DateTime?> unlockedAt = const Value.absent()}) =>
      AchievementsTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        badgeId: badgeId ?? this.badgeId,
        badgeName: badgeName ?? this.badgeName,
        badgeDescription: badgeDescription ?? this.badgeDescription,
        badgeIcon: badgeIcon ?? this.badgeIcon,
        isUnlocked: isUnlocked ?? this.isUnlocked,
        unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
      );
  AchievementsTableData copyWithCompanion(AchievementsTableCompanion data) {
    return AchievementsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      badgeId: data.badgeId.present ? data.badgeId.value : this.badgeId,
      badgeName: data.badgeName.present ? data.badgeName.value : this.badgeName,
      badgeDescription: data.badgeDescription.present
          ? data.badgeDescription.value
          : this.badgeDescription,
      badgeIcon: data.badgeIcon.present ? data.badgeIcon.value : this.badgeIcon,
      isUnlocked:
          data.isUnlocked.present ? data.isUnlocked.value : this.isUnlocked,
      unlockedAt:
          data.unlockedAt.present ? data.unlockedAt.value : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('badgeId: $badgeId, ')
          ..write('badgeName: $badgeName, ')
          ..write('badgeDescription: $badgeDescription, ')
          ..write('badgeIcon: $badgeIcon, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, badgeId, badgeName,
      badgeDescription, badgeIcon, isUnlocked, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.badgeId == this.badgeId &&
          other.badgeName == this.badgeName &&
          other.badgeDescription == this.badgeDescription &&
          other.badgeIcon == this.badgeIcon &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsTableCompanion
    extends UpdateCompanion<AchievementsTableData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> badgeId;
  final Value<String> badgeName;
  final Value<String> badgeDescription;
  final Value<String> badgeIcon;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  const AchievementsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.badgeId = const Value.absent(),
    this.badgeName = const Value.absent(),
    this.badgeDescription = const Value.absent(),
    this.badgeIcon = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  });
  AchievementsTableCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String badgeId,
    required String badgeName,
    required String badgeDescription,
    required String badgeIcon,
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  })  : userId = Value(userId),
        badgeId = Value(badgeId),
        badgeName = Value(badgeName),
        badgeDescription = Value(badgeDescription),
        badgeIcon = Value(badgeIcon);
  static Insertable<AchievementsTableData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? badgeId,
    Expression<String>? badgeName,
    Expression<String>? badgeDescription,
    Expression<String>? badgeIcon,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (badgeId != null) 'badge_id': badgeId,
      if (badgeName != null) 'badge_name': badgeName,
      if (badgeDescription != null) 'badge_description': badgeDescription,
      if (badgeIcon != null) 'badge_icon': badgeIcon,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
    });
  }

  AchievementsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? badgeId,
      Value<String>? badgeName,
      Value<String>? badgeDescription,
      Value<String>? badgeIcon,
      Value<bool>? isUnlocked,
      Value<DateTime?>? unlockedAt}) {
    return AchievementsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      badgeId: badgeId ?? this.badgeId,
      badgeName: badgeName ?? this.badgeName,
      badgeDescription: badgeDescription ?? this.badgeDescription,
      badgeIcon: badgeIcon ?? this.badgeIcon,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (badgeId.present) {
      map['badge_id'] = Variable<String>(badgeId.value);
    }
    if (badgeName.present) {
      map['badge_name'] = Variable<String>(badgeName.value);
    }
    if (badgeDescription.present) {
      map['badge_description'] = Variable<String>(badgeDescription.value);
    }
    if (badgeIcon.present) {
      map['badge_icon'] = Variable<String>(badgeIcon.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('badgeId: $badgeId, ')
          ..write('badgeName: $badgeName, ')
          ..write('badgeDescription: $badgeDescription, ')
          ..write('badgeIcon: $badgeIcon, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryBudgetsTable extends CategoryBudgets
    with TableInfo<$CategoryBudgetsTable, CategoryBudgetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryBudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _limitAmountMeta =
      const VerificationMeta('limitAmount');
  @override
  late final GeneratedColumn<double> limitAmount = GeneratedColumn<double>(
      'limit_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, category, limitAmount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_budgets';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryBudgetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('limit_amount')) {
      context.handle(
          _limitAmountMeta,
          limitAmount.isAcceptableOrUnknown(
              data['limit_amount']!, _limitAmountMeta));
    } else if (isInserting) {
      context.missing(_limitAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryBudgetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryBudgetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      limitAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}limit_amount'])!,
    );
  }

  @override
  $CategoryBudgetsTable createAlias(String alias) {
    return $CategoryBudgetsTable(attachedDatabase, alias);
  }
}

class CategoryBudgetData extends DataClass
    implements Insertable<CategoryBudgetData> {
  final int id;
  final String userId;
  final String category;
  final double limitAmount;
  const CategoryBudgetData(
      {required this.id,
      required this.userId,
      required this.category,
      required this.limitAmount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['category'] = Variable<String>(category);
    map['limit_amount'] = Variable<double>(limitAmount);
    return map;
  }

  CategoryBudgetsCompanion toCompanion(bool nullToAbsent) {
    return CategoryBudgetsCompanion(
      id: Value(id),
      userId: Value(userId),
      category: Value(category),
      limitAmount: Value(limitAmount),
    );
  }

  factory CategoryBudgetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryBudgetData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      category: serializer.fromJson<String>(json['category']),
      limitAmount: serializer.fromJson<double>(json['limitAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'category': serializer.toJson<String>(category),
      'limitAmount': serializer.toJson<double>(limitAmount),
    };
  }

  CategoryBudgetData copyWith(
          {int? id, String? userId, String? category, double? limitAmount}) =>
      CategoryBudgetData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        category: category ?? this.category,
        limitAmount: limitAmount ?? this.limitAmount,
      );
  CategoryBudgetData copyWithCompanion(CategoryBudgetsCompanion data) {
    return CategoryBudgetData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      category: data.category.present ? data.category.value : this.category,
      limitAmount:
          data.limitAmount.present ? data.limitAmount.value : this.limitAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryBudgetData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('category: $category, ')
          ..write('limitAmount: $limitAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, category, limitAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryBudgetData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.category == this.category &&
          other.limitAmount == this.limitAmount);
}

class CategoryBudgetsCompanion extends UpdateCompanion<CategoryBudgetData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> category;
  final Value<double> limitAmount;
  const CategoryBudgetsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.category = const Value.absent(),
    this.limitAmount = const Value.absent(),
  });
  CategoryBudgetsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String category,
    required double limitAmount,
  })  : userId = Value(userId),
        category = Value(category),
        limitAmount = Value(limitAmount);
  static Insertable<CategoryBudgetData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? category,
    Expression<double>? limitAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (category != null) 'category': category,
      if (limitAmount != null) 'limit_amount': limitAmount,
    });
  }

  CategoryBudgetsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? category,
      Value<double>? limitAmount}) {
    return CategoryBudgetsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      limitAmount: limitAmount ?? this.limitAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (limitAmount.present) {
      map['limit_amount'] = Variable<double>(limitAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryBudgetsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('category: $category, ')
          ..write('limitAmount: $limitAmount')
          ..write(')'))
        .toString();
  }
}

class $RawExpensesTable extends RawExpenses
    with TableInfo<$RawExpensesTable, RawExpenseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rawTextMeta =
      const VerificationMeta('rawText');
  @override
  late final GeneratedColumn<String> rawText = GeneratedColumn<String>(
      'raw_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, rawText, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_expenses';
  @override
  VerificationContext validateIntegrity(Insertable<RawExpenseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('raw_text')) {
      context.handle(_rawTextMeta,
          rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta));
    } else if (isInserting) {
      context.missing(_rawTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawExpenseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawExpenseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      rawText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raw_text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RawExpensesTable createAlias(String alias) {
    return $RawExpensesTable(attachedDatabase, alias);
  }
}

class RawExpenseData extends DataClass implements Insertable<RawExpenseData> {
  final int id;
  final String userId;
  final String rawText;
  final int createdAt;
  const RawExpenseData(
      {required this.id,
      required this.userId,
      required this.rawText,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['raw_text'] = Variable<String>(rawText);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  RawExpensesCompanion toCompanion(bool nullToAbsent) {
    return RawExpensesCompanion(
      id: Value(id),
      userId: Value(userId),
      rawText: Value(rawText),
      createdAt: Value(createdAt),
    );
  }

  factory RawExpenseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawExpenseData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      rawText: serializer.fromJson<String>(json['rawText']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'rawText': serializer.toJson<String>(rawText),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  RawExpenseData copyWith(
          {int? id, String? userId, String? rawText, int? createdAt}) =>
      RawExpenseData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        rawText: rawText ?? this.rawText,
        createdAt: createdAt ?? this.createdAt,
      );
  RawExpenseData copyWithCompanion(RawExpensesCompanion data) {
    return RawExpenseData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawExpenseData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('rawText: $rawText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, rawText, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawExpenseData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.rawText == this.rawText &&
          other.createdAt == this.createdAt);
}

class RawExpensesCompanion extends UpdateCompanion<RawExpenseData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> rawText;
  final Value<int> createdAt;
  const RawExpensesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.rawText = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RawExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String rawText,
    required int createdAt,
  })  : userId = Value(userId),
        rawText = Value(rawText),
        createdAt = Value(createdAt);
  static Insertable<RawExpenseData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? rawText,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (rawText != null) 'raw_text': rawText,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RawExpensesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? rawText,
      Value<int>? createdAt}) {
    return RawExpensesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      rawText: rawText ?? this.rawText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RawExpensesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('rawText: $rawText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GemmaInsightsTableTable extends GemmaInsightsTable
    with TableInfo<$GemmaInsightsTableTable, GemmaInsightData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GemmaInsightsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskTypeMeta =
      const VerificationMeta('taskType');
  @override
  late final GeneratedColumn<String> taskType = GeneratedColumn<String>(
      'task_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contextHashMeta =
      const VerificationMeta('contextHash');
  @override
  late final GeneratedColumn<String> contextHash = GeneratedColumn<String>(
      'context_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insightTextMeta =
      const VerificationMeta('insightText');
  @override
  late final GeneratedColumn<String> insightText = GeneratedColumn<String>(
      'insight_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<String> month = GeneratedColumn<String>(
      'month', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, taskType, contextHash, insightText, month, generatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gemma_insights_table';
  @override
  VerificationContext validateIntegrity(Insertable<GemmaInsightData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('task_type')) {
      context.handle(_taskTypeMeta,
          taskType.isAcceptableOrUnknown(data['task_type']!, _taskTypeMeta));
    } else if (isInserting) {
      context.missing(_taskTypeMeta);
    }
    if (data.containsKey('context_hash')) {
      context.handle(
          _contextHashMeta,
          contextHash.isAcceptableOrUnknown(
              data['context_hash']!, _contextHashMeta));
    } else if (isInserting) {
      context.missing(_contextHashMeta);
    }
    if (data.containsKey('insight_text')) {
      context.handle(
          _insightTextMeta,
          insightText.isAcceptableOrUnknown(
              data['insight_text']!, _insightTextMeta));
    } else if (isInserting) {
      context.missing(_insightTextMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GemmaInsightData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GemmaInsightData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      taskType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_type'])!,
      contextHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_hash'])!,
      insightText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insight_text'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}month'])!,
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}generated_at'])!,
    );
  }

  @override
  $GemmaInsightsTableTable createAlias(String alias) {
    return $GemmaInsightsTableTable(attachedDatabase, alias);
  }
}

class GemmaInsightData extends DataClass
    implements Insertable<GemmaInsightData> {
  final int id;
  final String userId;
  final String taskType;
  final String contextHash;
  final String insightText;
  final String month;
  final DateTime generatedAt;
  const GemmaInsightData(
      {required this.id,
      required this.userId,
      required this.taskType,
      required this.contextHash,
      required this.insightText,
      required this.month,
      required this.generatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['task_type'] = Variable<String>(taskType);
    map['context_hash'] = Variable<String>(contextHash);
    map['insight_text'] = Variable<String>(insightText);
    map['month'] = Variable<String>(month);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  GemmaInsightsTableCompanion toCompanion(bool nullToAbsent) {
    return GemmaInsightsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      taskType: Value(taskType),
      contextHash: Value(contextHash),
      insightText: Value(insightText),
      month: Value(month),
      generatedAt: Value(generatedAt),
    );
  }

  factory GemmaInsightData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GemmaInsightData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      taskType: serializer.fromJson<String>(json['taskType']),
      contextHash: serializer.fromJson<String>(json['contextHash']),
      insightText: serializer.fromJson<String>(json['insightText']),
      month: serializer.fromJson<String>(json['month']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'taskType': serializer.toJson<String>(taskType),
      'contextHash': serializer.toJson<String>(contextHash),
      'insightText': serializer.toJson<String>(insightText),
      'month': serializer.toJson<String>(month),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  GemmaInsightData copyWith(
          {int? id,
          String? userId,
          String? taskType,
          String? contextHash,
          String? insightText,
          String? month,
          DateTime? generatedAt}) =>
      GemmaInsightData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        taskType: taskType ?? this.taskType,
        contextHash: contextHash ?? this.contextHash,
        insightText: insightText ?? this.insightText,
        month: month ?? this.month,
        generatedAt: generatedAt ?? this.generatedAt,
      );
  GemmaInsightData copyWithCompanion(GemmaInsightsTableCompanion data) {
    return GemmaInsightData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      taskType: data.taskType.present ? data.taskType.value : this.taskType,
      contextHash:
          data.contextHash.present ? data.contextHash.value : this.contextHash,
      insightText:
          data.insightText.present ? data.insightText.value : this.insightText,
      month: data.month.present ? data.month.value : this.month,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GemmaInsightData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('taskType: $taskType, ')
          ..write('contextHash: $contextHash, ')
          ..write('insightText: $insightText, ')
          ..write('month: $month, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, taskType, contextHash, insightText, month, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GemmaInsightData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.taskType == this.taskType &&
          other.contextHash == this.contextHash &&
          other.insightText == this.insightText &&
          other.month == this.month &&
          other.generatedAt == this.generatedAt);
}

class GemmaInsightsTableCompanion extends UpdateCompanion<GemmaInsightData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> taskType;
  final Value<String> contextHash;
  final Value<String> insightText;
  final Value<String> month;
  final Value<DateTime> generatedAt;
  const GemmaInsightsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.taskType = const Value.absent(),
    this.contextHash = const Value.absent(),
    this.insightText = const Value.absent(),
    this.month = const Value.absent(),
    this.generatedAt = const Value.absent(),
  });
  GemmaInsightsTableCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String taskType,
    required String contextHash,
    required String insightText,
    required String month,
    this.generatedAt = const Value.absent(),
  })  : userId = Value(userId),
        taskType = Value(taskType),
        contextHash = Value(contextHash),
        insightText = Value(insightText),
        month = Value(month);
  static Insertable<GemmaInsightData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? taskType,
    Expression<String>? contextHash,
    Expression<String>? insightText,
    Expression<String>? month,
    Expression<DateTime>? generatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (taskType != null) 'task_type': taskType,
      if (contextHash != null) 'context_hash': contextHash,
      if (insightText != null) 'insight_text': insightText,
      if (month != null) 'month': month,
      if (generatedAt != null) 'generated_at': generatedAt,
    });
  }

  GemmaInsightsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? taskType,
      Value<String>? contextHash,
      Value<String>? insightText,
      Value<String>? month,
      Value<DateTime>? generatedAt}) {
    return GemmaInsightsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      taskType: taskType ?? this.taskType,
      contextHash: contextHash ?? this.contextHash,
      insightText: insightText ?? this.insightText,
      month: month ?? this.month,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (taskType.present) {
      map['task_type'] = Variable<String>(taskType.value);
    }
    if (contextHash.present) {
      map['context_hash'] = Variable<String>(contextHash.value);
    }
    if (insightText.present) {
      map['insight_text'] = Variable<String>(insightText.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GemmaInsightsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('taskType: $taskType, ')
          ..write('contextHash: $contextHash, ')
          ..write('insightText: $insightText, ')
          ..write('month: $month, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }
}

class $SmsImportLogTableTable extends SmsImportLogTable
    with TableInfo<$SmsImportLogTableTable, SmsImportLogTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsImportLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _smsIdMeta = const VerificationMeta('smsId');
  @override
  late final GeneratedColumn<String> smsId = GeneratedColumn<String>(
      'sms_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
      'sender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rawBodyMeta =
      const VerificationMeta('rawBody');
  @override
  late final GeneratedColumn<String> rawBody = GeneratedColumn<String>(
      'raw_body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _merchantMeta =
      const VerificationMeta('merchant');
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
      'merchant', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('imported'));
  static const VerificationMeta _expenseUuidMeta =
      const VerificationMeta('expenseUuid');
  @override
  late final GeneratedColumn<String> expenseUuid = GeneratedColumn<String>(
      'expense_uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _smsDateMeta =
      const VerificationMeta('smsDate');
  @override
  late final GeneratedColumn<DateTime> smsDate = GeneratedColumn<DateTime>(
      'sms_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        smsId,
        userId,
        sender,
        rawBody,
        amount,
        merchant,
        category,
        status,
        expenseUuid,
        smsDate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_import_log';
  @override
  VerificationContext validateIntegrity(
      Insertable<SmsImportLogTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sms_id')) {
      context.handle(
          _smsIdMeta, smsId.isAcceptableOrUnknown(data['sms_id']!, _smsIdMeta));
    } else if (isInserting) {
      context.missing(_smsIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(_senderMeta,
          sender.isAcceptableOrUnknown(data['sender']!, _senderMeta));
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('raw_body')) {
      context.handle(_rawBodyMeta,
          rawBody.isAcceptableOrUnknown(data['raw_body']!, _rawBodyMeta));
    } else if (isInserting) {
      context.missing(_rawBodyMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(_merchantMeta,
          merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta));
    } else if (isInserting) {
      context.missing(_merchantMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('expense_uuid')) {
      context.handle(
          _expenseUuidMeta,
          expenseUuid.isAcceptableOrUnknown(
              data['expense_uuid']!, _expenseUuidMeta));
    }
    if (data.containsKey('sms_date')) {
      context.handle(_smsDateMeta,
          smsDate.isAcceptableOrUnknown(data['sms_date']!, _smsDateMeta));
    } else if (isInserting) {
      context.missing(_smsDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsImportLogTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsImportLogTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      smsId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sms_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      sender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender'])!,
      rawBody: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raw_body'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      merchant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}merchant'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      expenseUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expense_uuid']),
      smsDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sms_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SmsImportLogTableTable createAlias(String alias) {
    return $SmsImportLogTableTable(attachedDatabase, alias);
  }
}

class SmsImportLogTableData extends DataClass
    implements Insertable<SmsImportLogTableData> {
  final int id;
  final String smsId;
  final String userId;
  final String sender;
  final String rawBody;
  final double amount;
  final String merchant;
  final String category;
  final String status;
  final String? expenseUuid;
  final DateTime smsDate;
  final DateTime createdAt;
  const SmsImportLogTableData(
      {required this.id,
      required this.smsId,
      required this.userId,
      required this.sender,
      required this.rawBody,
      required this.amount,
      required this.merchant,
      required this.category,
      required this.status,
      this.expenseUuid,
      required this.smsDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sms_id'] = Variable<String>(smsId);
    map['user_id'] = Variable<String>(userId);
    map['sender'] = Variable<String>(sender);
    map['raw_body'] = Variable<String>(rawBody);
    map['amount'] = Variable<double>(amount);
    map['merchant'] = Variable<String>(merchant);
    map['category'] = Variable<String>(category);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || expenseUuid != null) {
      map['expense_uuid'] = Variable<String>(expenseUuid);
    }
    map['sms_date'] = Variable<DateTime>(smsDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SmsImportLogTableCompanion toCompanion(bool nullToAbsent) {
    return SmsImportLogTableCompanion(
      id: Value(id),
      smsId: Value(smsId),
      userId: Value(userId),
      sender: Value(sender),
      rawBody: Value(rawBody),
      amount: Value(amount),
      merchant: Value(merchant),
      category: Value(category),
      status: Value(status),
      expenseUuid: expenseUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseUuid),
      smsDate: Value(smsDate),
      createdAt: Value(createdAt),
    );
  }

  factory SmsImportLogTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsImportLogTableData(
      id: serializer.fromJson<int>(json['id']),
      smsId: serializer.fromJson<String>(json['smsId']),
      userId: serializer.fromJson<String>(json['userId']),
      sender: serializer.fromJson<String>(json['sender']),
      rawBody: serializer.fromJson<String>(json['rawBody']),
      amount: serializer.fromJson<double>(json['amount']),
      merchant: serializer.fromJson<String>(json['merchant']),
      category: serializer.fromJson<String>(json['category']),
      status: serializer.fromJson<String>(json['status']),
      expenseUuid: serializer.fromJson<String?>(json['expenseUuid']),
      smsDate: serializer.fromJson<DateTime>(json['smsDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'smsId': serializer.toJson<String>(smsId),
      'userId': serializer.toJson<String>(userId),
      'sender': serializer.toJson<String>(sender),
      'rawBody': serializer.toJson<String>(rawBody),
      'amount': serializer.toJson<double>(amount),
      'merchant': serializer.toJson<String>(merchant),
      'category': serializer.toJson<String>(category),
      'status': serializer.toJson<String>(status),
      'expenseUuid': serializer.toJson<String?>(expenseUuid),
      'smsDate': serializer.toJson<DateTime>(smsDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SmsImportLogTableData copyWith(
          {int? id,
          String? smsId,
          String? userId,
          String? sender,
          String? rawBody,
          double? amount,
          String? merchant,
          String? category,
          String? status,
          Value<String?> expenseUuid = const Value.absent(),
          DateTime? smsDate,
          DateTime? createdAt}) =>
      SmsImportLogTableData(
        id: id ?? this.id,
        smsId: smsId ?? this.smsId,
        userId: userId ?? this.userId,
        sender: sender ?? this.sender,
        rawBody: rawBody ?? this.rawBody,
        amount: amount ?? this.amount,
        merchant: merchant ?? this.merchant,
        category: category ?? this.category,
        status: status ?? this.status,
        expenseUuid: expenseUuid.present ? expenseUuid.value : this.expenseUuid,
        smsDate: smsDate ?? this.smsDate,
        createdAt: createdAt ?? this.createdAt,
      );
  SmsImportLogTableData copyWithCompanion(SmsImportLogTableCompanion data) {
    return SmsImportLogTableData(
      id: data.id.present ? data.id.value : this.id,
      smsId: data.smsId.present ? data.smsId.value : this.smsId,
      userId: data.userId.present ? data.userId.value : this.userId,
      sender: data.sender.present ? data.sender.value : this.sender,
      rawBody: data.rawBody.present ? data.rawBody.value : this.rawBody,
      amount: data.amount.present ? data.amount.value : this.amount,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      category: data.category.present ? data.category.value : this.category,
      status: data.status.present ? data.status.value : this.status,
      expenseUuid:
          data.expenseUuid.present ? data.expenseUuid.value : this.expenseUuid,
      smsDate: data.smsDate.present ? data.smsDate.value : this.smsDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsImportLogTableData(')
          ..write('id: $id, ')
          ..write('smsId: $smsId, ')
          ..write('userId: $userId, ')
          ..write('sender: $sender, ')
          ..write('rawBody: $rawBody, ')
          ..write('amount: $amount, ')
          ..write('merchant: $merchant, ')
          ..write('category: $category, ')
          ..write('status: $status, ')
          ..write('expenseUuid: $expenseUuid, ')
          ..write('smsDate: $smsDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, smsId, userId, sender, rawBody, amount,
      merchant, category, status, expenseUuid, smsDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsImportLogTableData &&
          other.id == this.id &&
          other.smsId == this.smsId &&
          other.userId == this.userId &&
          other.sender == this.sender &&
          other.rawBody == this.rawBody &&
          other.amount == this.amount &&
          other.merchant == this.merchant &&
          other.category == this.category &&
          other.status == this.status &&
          other.expenseUuid == this.expenseUuid &&
          other.smsDate == this.smsDate &&
          other.createdAt == this.createdAt);
}

class SmsImportLogTableCompanion
    extends UpdateCompanion<SmsImportLogTableData> {
  final Value<int> id;
  final Value<String> smsId;
  final Value<String> userId;
  final Value<String> sender;
  final Value<String> rawBody;
  final Value<double> amount;
  final Value<String> merchant;
  final Value<String> category;
  final Value<String> status;
  final Value<String?> expenseUuid;
  final Value<DateTime> smsDate;
  final Value<DateTime> createdAt;
  const SmsImportLogTableCompanion({
    this.id = const Value.absent(),
    this.smsId = const Value.absent(),
    this.userId = const Value.absent(),
    this.sender = const Value.absent(),
    this.rawBody = const Value.absent(),
    this.amount = const Value.absent(),
    this.merchant = const Value.absent(),
    this.category = const Value.absent(),
    this.status = const Value.absent(),
    this.expenseUuid = const Value.absent(),
    this.smsDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SmsImportLogTableCompanion.insert({
    this.id = const Value.absent(),
    required String smsId,
    required String userId,
    required String sender,
    required String rawBody,
    required double amount,
    required String merchant,
    required String category,
    this.status = const Value.absent(),
    this.expenseUuid = const Value.absent(),
    required DateTime smsDate,
    this.createdAt = const Value.absent(),
  })  : smsId = Value(smsId),
        userId = Value(userId),
        sender = Value(sender),
        rawBody = Value(rawBody),
        amount = Value(amount),
        merchant = Value(merchant),
        category = Value(category),
        smsDate = Value(smsDate);
  static Insertable<SmsImportLogTableData> custom({
    Expression<int>? id,
    Expression<String>? smsId,
    Expression<String>? userId,
    Expression<String>? sender,
    Expression<String>? rawBody,
    Expression<double>? amount,
    Expression<String>? merchant,
    Expression<String>? category,
    Expression<String>? status,
    Expression<String>? expenseUuid,
    Expression<DateTime>? smsDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (smsId != null) 'sms_id': smsId,
      if (userId != null) 'user_id': userId,
      if (sender != null) 'sender': sender,
      if (rawBody != null) 'raw_body': rawBody,
      if (amount != null) 'amount': amount,
      if (merchant != null) 'merchant': merchant,
      if (category != null) 'category': category,
      if (status != null) 'status': status,
      if (expenseUuid != null) 'expense_uuid': expenseUuid,
      if (smsDate != null) 'sms_date': smsDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SmsImportLogTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? smsId,
      Value<String>? userId,
      Value<String>? sender,
      Value<String>? rawBody,
      Value<double>? amount,
      Value<String>? merchant,
      Value<String>? category,
      Value<String>? status,
      Value<String?>? expenseUuid,
      Value<DateTime>? smsDate,
      Value<DateTime>? createdAt}) {
    return SmsImportLogTableCompanion(
      id: id ?? this.id,
      smsId: smsId ?? this.smsId,
      userId: userId ?? this.userId,
      sender: sender ?? this.sender,
      rawBody: rawBody ?? this.rawBody,
      amount: amount ?? this.amount,
      merchant: merchant ?? this.merchant,
      category: category ?? this.category,
      status: status ?? this.status,
      expenseUuid: expenseUuid ?? this.expenseUuid,
      smsDate: smsDate ?? this.smsDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (smsId.present) {
      map['sms_id'] = Variable<String>(smsId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (rawBody.present) {
      map['raw_body'] = Variable<String>(rawBody.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (expenseUuid.present) {
      map['expense_uuid'] = Variable<String>(expenseUuid.value);
    }
    if (smsDate.present) {
      map['sms_date'] = Variable<DateTime>(smsDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsImportLogTableCompanion(')
          ..write('id: $id, ')
          ..write('smsId: $smsId, ')
          ..write('userId: $userId, ')
          ..write('sender: $sender, ')
          ..write('rawBody: $rawBody, ')
          ..write('amount: $amount, ')
          ..write('merchant: $merchant, ')
          ..write('category: $category, ')
          ..write('status: $status, ')
          ..write('expenseUuid: $expenseUuid, ')
          ..write('smsDate: $smsDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $PendingSyncsTable pendingSyncs = $PendingSyncsTable(this);
  late final $FinancialProfilesTable financialProfiles =
      $FinancialProfilesTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $AiInsightsTable aiInsights = $AiInsightsTable(this);
  late final $RecurringExpensesTableTable recurringExpensesTable =
      $RecurringExpensesTableTable(this);
  late final $AchievementsTableTable achievementsTable =
      $AchievementsTableTable(this);
  late final $CategoryBudgetsTable categoryBudgets =
      $CategoryBudgetsTable(this);
  late final $RawExpensesTable rawExpenses = $RawExpensesTable(this);
  late final $GemmaInsightsTableTable gemmaInsightsTable =
      $GemmaInsightsTableTable(this);
  late final $SmsImportLogTableTable smsImportLogTable =
      $SmsImportLogTableTable(this);
  late final ExpensesDao expensesDao = ExpensesDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  late final BudgetsDao budgetsDao = BudgetsDao(this as AppDatabase);
  late final InsightsDao insightsDao = InsightsDao(this as AppDatabase);
  late final RecurringDao recurringDao = RecurringDao(this as AppDatabase);
  late final AchievementsDao achievementsDao =
      AchievementsDao(this as AppDatabase);
  late final FinancialProfileDao financialProfileDao =
      FinancialProfileDao(this as AppDatabase);
  late final RawExpensesDao rawExpensesDao =
      RawExpensesDao(this as AppDatabase);
  late final GemmaInsightDao gemmaInsightDao =
      GemmaInsightDao(this as AppDatabase);
  late final SmsImportDao smsImportDao = SmsImportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        expenses,
        pendingSyncs,
        financialProfiles,
        budgets,
        aiInsights,
        recurringExpensesTable,
        achievementsTable,
        categoryBudgets,
        rawExpenses,
        gemmaInsightsTable,
        smsImportLogTable
      ];
}

typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required String uuid,
  required String userId,
  required double amount,
  required String category,
  Value<String> description,
  required int date,
  Value<bool> isRecurring,
  Value<String> source,
  Value<String> syncStatus,
  required int createdAt,
  required int updatedAt,
  Value<bool> isDeleted,
  Value<String> currency,
  Value<double> exchangeRate,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> userId,
  Value<double> amount,
  Value<String> category,
  Value<String> description,
  Value<int> date,
  Value<bool> isRecurring,
  Value<String> source,
  Value<String> syncStatus,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<bool> isDeleted,
  Value<String> currency,
  Value<double> exchangeRate,
});

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get exchangeRate => $composableBuilder(
      column: $table.exchangeRate, builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get exchangeRate => $composableBuilder(
      column: $table.exchangeRate,
      builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get exchangeRate => $composableBuilder(
      column: $table.exchangeRate, builder: (column) => column);
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    ExpenseData,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (ExpenseData, BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseData>),
    ExpenseData,
    PrefetchHooks Function()> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> date = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> exchangeRate = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            uuid: uuid,
            userId: userId,
            amount: amount,
            category: category,
            description: description,
            date: date,
            isRecurring: isRecurring,
            source: source,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
            currency: currency,
            exchangeRate: exchangeRate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String userId,
            required double amount,
            required String category,
            Value<String> description = const Value.absent(),
            required int date,
            Value<bool> isRecurring = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> exchangeRate = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            uuid: uuid,
            userId: userId,
            amount: amount,
            category: category,
            description: description,
            date: date,
            isRecurring: isRecurring,
            source: source,
            syncStatus: syncStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
            currency: currency,
            exchangeRate: exchangeRate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    ExpenseData,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (ExpenseData, BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseData>),
    ExpenseData,
    PrefetchHooks Function()>;
typedef $$PendingSyncsTableCreateCompanionBuilder = PendingSyncsCompanion
    Function({
  Value<int> id,
  required String tableIdentifier,
  required String recordUuid,
  required String operation,
  required String payload,
  required int createdAt,
  Value<int> retryCount,
});
typedef $$PendingSyncsTableUpdateCompanionBuilder = PendingSyncsCompanion
    Function({
  Value<int> id,
  Value<String> tableIdentifier,
  Value<String> recordUuid,
  Value<String> operation,
  Value<String> payload,
  Value<int> createdAt,
  Value<int> retryCount,
});

class $$PendingSyncsTableFilterComposer
    extends Composer<_$AppDatabase, $PendingSyncsTable> {
  $$PendingSyncsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableIdentifier => $composableBuilder(
      column: $table.tableIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordUuid => $composableBuilder(
      column: $table.recordUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));
}

class $$PendingSyncsTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingSyncsTable> {
  $$PendingSyncsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableIdentifier => $composableBuilder(
      column: $table.tableIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordUuid => $composableBuilder(
      column: $table.recordUuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));
}

class $$PendingSyncsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingSyncsTable> {
  $$PendingSyncsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tableIdentifier => $composableBuilder(
      column: $table.tableIdentifier, builder: (column) => column);

  GeneratedColumn<String> get recordUuid => $composableBuilder(
      column: $table.recordUuid, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);
}

class $$PendingSyncsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingSyncsTable,
    PendingSync,
    $$PendingSyncsTableFilterComposer,
    $$PendingSyncsTableOrderingComposer,
    $$PendingSyncsTableAnnotationComposer,
    $$PendingSyncsTableCreateCompanionBuilder,
    $$PendingSyncsTableUpdateCompanionBuilder,
    (
      PendingSync,
      BaseReferences<_$AppDatabase, $PendingSyncsTable, PendingSync>
    ),
    PendingSync,
    PrefetchHooks Function()> {
  $$PendingSyncsTableTableManager(_$AppDatabase db, $PendingSyncsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingSyncsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingSyncsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingSyncsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tableIdentifier = const Value.absent(),
            Value<String> recordUuid = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
          }) =>
              PendingSyncsCompanion(
            id: id,
            tableIdentifier: tableIdentifier,
            recordUuid: recordUuid,
            operation: operation,
            payload: payload,
            createdAt: createdAt,
            retryCount: retryCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tableIdentifier,
            required String recordUuid,
            required String operation,
            required String payload,
            required int createdAt,
            Value<int> retryCount = const Value.absent(),
          }) =>
              PendingSyncsCompanion.insert(
            id: id,
            tableIdentifier: tableIdentifier,
            recordUuid: recordUuid,
            operation: operation,
            payload: payload,
            createdAt: createdAt,
            retryCount: retryCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingSyncsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PendingSyncsTable,
    PendingSync,
    $$PendingSyncsTableFilterComposer,
    $$PendingSyncsTableOrderingComposer,
    $$PendingSyncsTableAnnotationComposer,
    $$PendingSyncsTableCreateCompanionBuilder,
    $$PendingSyncsTableUpdateCompanionBuilder,
    (
      PendingSync,
      BaseReferences<_$AppDatabase, $PendingSyncsTable, PendingSync>
    ),
    PendingSync,
    PrefetchHooks Function()>;
typedef $$FinancialProfilesTableCreateCompanionBuilder
    = FinancialProfilesCompanion Function({
  Value<int> id,
  required String userId,
  Value<double> monthlyIncome,
  Value<int> incomeDay,
  Value<String> currency,
  Value<bool> budgetAlertsEnabled,
  Value<bool> offlineModeOnly,
  required int updatedAt,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String?> lastTrackedDate,
});
typedef $$FinancialProfilesTableUpdateCompanionBuilder
    = FinancialProfilesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<double> monthlyIncome,
  Value<int> incomeDay,
  Value<String> currency,
  Value<bool> budgetAlertsEnabled,
  Value<bool> offlineModeOnly,
  Value<int> updatedAt,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String?> lastTrackedDate,
});

class $$FinancialProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialProfilesTable> {
  $$FinancialProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monthlyIncome => $composableBuilder(
      column: $table.monthlyIncome, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get incomeDay => $composableBuilder(
      column: $table.incomeDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get budgetAlertsEnabled => $composableBuilder(
      column: $table.budgetAlertsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get offlineModeOnly => $composableBuilder(
      column: $table.offlineModeOnly,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastTrackedDate => $composableBuilder(
      column: $table.lastTrackedDate,
      builder: (column) => ColumnFilters(column));
}

class $$FinancialProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialProfilesTable> {
  $$FinancialProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monthlyIncome => $composableBuilder(
      column: $table.monthlyIncome,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get incomeDay => $composableBuilder(
      column: $table.incomeDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get budgetAlertsEnabled => $composableBuilder(
      column: $table.budgetAlertsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get offlineModeOnly => $composableBuilder(
      column: $table.offlineModeOnly,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastTrackedDate => $composableBuilder(
      column: $table.lastTrackedDate,
      builder: (column) => ColumnOrderings(column));
}

class $$FinancialProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialProfilesTable> {
  $$FinancialProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get monthlyIncome => $composableBuilder(
      column: $table.monthlyIncome, builder: (column) => column);

  GeneratedColumn<int> get incomeDay =>
      $composableBuilder(column: $table.incomeDay, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<bool> get budgetAlertsEnabled => $composableBuilder(
      column: $table.budgetAlertsEnabled, builder: (column) => column);

  GeneratedColumn<bool> get offlineModeOnly => $composableBuilder(
      column: $table.offlineModeOnly, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<String> get lastTrackedDate => $composableBuilder(
      column: $table.lastTrackedDate, builder: (column) => column);
}

class $$FinancialProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FinancialProfilesTable,
    FinancialProfile,
    $$FinancialProfilesTableFilterComposer,
    $$FinancialProfilesTableOrderingComposer,
    $$FinancialProfilesTableAnnotationComposer,
    $$FinancialProfilesTableCreateCompanionBuilder,
    $$FinancialProfilesTableUpdateCompanionBuilder,
    (
      FinancialProfile,
      BaseReferences<_$AppDatabase, $FinancialProfilesTable, FinancialProfile>
    ),
    FinancialProfile,
    PrefetchHooks Function()> {
  $$FinancialProfilesTableTableManager(
      _$AppDatabase db, $FinancialProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialProfilesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<double> monthlyIncome = const Value.absent(),
            Value<int> incomeDay = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<bool> budgetAlertsEnabled = const Value.absent(),
            Value<bool> offlineModeOnly = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String?> lastTrackedDate = const Value.absent(),
          }) =>
              FinancialProfilesCompanion(
            id: id,
            userId: userId,
            monthlyIncome: monthlyIncome,
            incomeDay: incomeDay,
            currency: currency,
            budgetAlertsEnabled: budgetAlertsEnabled,
            offlineModeOnly: offlineModeOnly,
            updatedAt: updatedAt,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            lastTrackedDate: lastTrackedDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            Value<double> monthlyIncome = const Value.absent(),
            Value<int> incomeDay = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<bool> budgetAlertsEnabled = const Value.absent(),
            Value<bool> offlineModeOnly = const Value.absent(),
            required int updatedAt,
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String?> lastTrackedDate = const Value.absent(),
          }) =>
              FinancialProfilesCompanion.insert(
            id: id,
            userId: userId,
            monthlyIncome: monthlyIncome,
            incomeDay: incomeDay,
            currency: currency,
            budgetAlertsEnabled: budgetAlertsEnabled,
            offlineModeOnly: offlineModeOnly,
            updatedAt: updatedAt,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            lastTrackedDate: lastTrackedDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FinancialProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FinancialProfilesTable,
    FinancialProfile,
    $$FinancialProfilesTableFilterComposer,
    $$FinancialProfilesTableOrderingComposer,
    $$FinancialProfilesTableAnnotationComposer,
    $$FinancialProfilesTableCreateCompanionBuilder,
    $$FinancialProfilesTableUpdateCompanionBuilder,
    (
      FinancialProfile,
      BaseReferences<_$AppDatabase, $FinancialProfilesTable, FinancialProfile>
    ),
    FinancialProfile,
    PrefetchHooks Function()>;
typedef $$BudgetsTableCreateCompanionBuilder = BudgetsCompanion Function({
  Value<int> id,
  required String uuid,
  required String userId,
  required String category,
  required double amount,
  required int month,
  Value<String> syncStatus,
  required int updatedAt,
});
typedef $$BudgetsTableUpdateCompanionBuilder = BudgetsCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> userId,
  Value<String> category,
  Value<double> amount,
  Value<int> month,
  Value<String> syncStatus,
  Value<int> updatedAt,
});

class $$BudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$BudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BudgetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetsTable,
    BudgetData,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (BudgetData, BaseReferences<_$AppDatabase, $BudgetsTable, BudgetData>),
    BudgetData,
    PrefetchHooks Function()> {
  $$BudgetsTableTableManager(_$AppDatabase db, $BudgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
          }) =>
              BudgetsCompanion(
            id: id,
            uuid: uuid,
            userId: userId,
            category: category,
            amount: amount,
            month: month,
            syncStatus: syncStatus,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String userId,
            required String category,
            required double amount,
            required int month,
            Value<String> syncStatus = const Value.absent(),
            required int updatedAt,
          }) =>
              BudgetsCompanion.insert(
            id: id,
            uuid: uuid,
            userId: userId,
            category: category,
            amount: amount,
            month: month,
            syncStatus: syncStatus,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BudgetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BudgetsTable,
    BudgetData,
    $$BudgetsTableFilterComposer,
    $$BudgetsTableOrderingComposer,
    $$BudgetsTableAnnotationComposer,
    $$BudgetsTableCreateCompanionBuilder,
    $$BudgetsTableUpdateCompanionBuilder,
    (BudgetData, BaseReferences<_$AppDatabase, $BudgetsTable, BudgetData>),
    BudgetData,
    PrefetchHooks Function()>;
typedef $$AiInsightsTableCreateCompanionBuilder = AiInsightsCompanion Function({
  Value<int> id,
  required String userId,
  required int month,
  required String riskLevel,
  required int riskScore,
  required String summary,
  required String suggestions,
  Value<String?> positiveNote,
  Value<int?> exhaustionDate,
  required int generatedAt,
});
typedef $$AiInsightsTableUpdateCompanionBuilder = AiInsightsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<int> month,
  Value<String> riskLevel,
  Value<int> riskScore,
  Value<String> summary,
  Value<String> suggestions,
  Value<String?> positiveNote,
  Value<int?> exhaustionDate,
  Value<int> generatedAt,
});

class $$AiInsightsTableFilterComposer
    extends Composer<_$AppDatabase, $AiInsightsTable> {
  $$AiInsightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get riskLevel => $composableBuilder(
      column: $table.riskLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get riskScore => $composableBuilder(
      column: $table.riskScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get suggestions => $composableBuilder(
      column: $table.suggestions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get positiveNote => $composableBuilder(
      column: $table.positiveNote, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exhaustionDate => $composableBuilder(
      column: $table.exhaustionDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));
}

class $$AiInsightsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiInsightsTable> {
  $$AiInsightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get riskLevel => $composableBuilder(
      column: $table.riskLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get riskScore => $composableBuilder(
      column: $table.riskScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get suggestions => $composableBuilder(
      column: $table.suggestions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get positiveNote => $composableBuilder(
      column: $table.positiveNote,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exhaustionDate => $composableBuilder(
      column: $table.exhaustionDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AiInsightsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiInsightsTable> {
  $$AiInsightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<String> get riskLevel =>
      $composableBuilder(column: $table.riskLevel, builder: (column) => column);

  GeneratedColumn<int> get riskScore =>
      $composableBuilder(column: $table.riskScore, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get suggestions => $composableBuilder(
      column: $table.suggestions, builder: (column) => column);

  GeneratedColumn<String> get positiveNote => $composableBuilder(
      column: $table.positiveNote, builder: (column) => column);

  GeneratedColumn<int> get exhaustionDate => $composableBuilder(
      column: $table.exhaustionDate, builder: (column) => column);

  GeneratedColumn<int> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);
}

class $$AiInsightsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AiInsightsTable,
    AiInsightData,
    $$AiInsightsTableFilterComposer,
    $$AiInsightsTableOrderingComposer,
    $$AiInsightsTableAnnotationComposer,
    $$AiInsightsTableCreateCompanionBuilder,
    $$AiInsightsTableUpdateCompanionBuilder,
    (
      AiInsightData,
      BaseReferences<_$AppDatabase, $AiInsightsTable, AiInsightData>
    ),
    AiInsightData,
    PrefetchHooks Function()> {
  $$AiInsightsTableTableManager(_$AppDatabase db, $AiInsightsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiInsightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiInsightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiInsightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<String> riskLevel = const Value.absent(),
            Value<int> riskScore = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<String> suggestions = const Value.absent(),
            Value<String?> positiveNote = const Value.absent(),
            Value<int?> exhaustionDate = const Value.absent(),
            Value<int> generatedAt = const Value.absent(),
          }) =>
              AiInsightsCompanion(
            id: id,
            userId: userId,
            month: month,
            riskLevel: riskLevel,
            riskScore: riskScore,
            summary: summary,
            suggestions: suggestions,
            positiveNote: positiveNote,
            exhaustionDate: exhaustionDate,
            generatedAt: generatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required int month,
            required String riskLevel,
            required int riskScore,
            required String summary,
            required String suggestions,
            Value<String?> positiveNote = const Value.absent(),
            Value<int?> exhaustionDate = const Value.absent(),
            required int generatedAt,
          }) =>
              AiInsightsCompanion.insert(
            id: id,
            userId: userId,
            month: month,
            riskLevel: riskLevel,
            riskScore: riskScore,
            summary: summary,
            suggestions: suggestions,
            positiveNote: positiveNote,
            exhaustionDate: exhaustionDate,
            generatedAt: generatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AiInsightsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AiInsightsTable,
    AiInsightData,
    $$AiInsightsTableFilterComposer,
    $$AiInsightsTableOrderingComposer,
    $$AiInsightsTableAnnotationComposer,
    $$AiInsightsTableCreateCompanionBuilder,
    $$AiInsightsTableUpdateCompanionBuilder,
    (
      AiInsightData,
      BaseReferences<_$AppDatabase, $AiInsightsTable, AiInsightData>
    ),
    AiInsightData,
    PrefetchHooks Function()>;
typedef $$RecurringExpensesTableTableCreateCompanionBuilder
    = RecurringExpensesTableCompanion Function({
  Value<int> id,
  required String uuid,
  required String userId,
  required String category,
  required String description,
  required double averageAmount,
  required int dayOfMonth,
  required String frequency,
  Value<bool> isActive,
  Value<bool> reminderEnabled,
  Value<int> reminderDaysBefore,
  required String lastOccurrence,
  required String nextExpectedDate,
  Value<String> syncStatus,
  Value<DateTime> createdAt,
});
typedef $$RecurringExpensesTableTableUpdateCompanionBuilder
    = RecurringExpensesTableCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> userId,
  Value<String> category,
  Value<String> description,
  Value<double> averageAmount,
  Value<int> dayOfMonth,
  Value<String> frequency,
  Value<bool> isActive,
  Value<bool> reminderEnabled,
  Value<int> reminderDaysBefore,
  Value<String> lastOccurrence,
  Value<String> nextExpectedDate,
  Value<String> syncStatus,
  Value<DateTime> createdAt,
});

class $$RecurringExpensesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTableTable> {
  $$RecurringExpensesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get averageAmount => $composableBuilder(
      column: $table.averageAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
      column: $table.dayOfMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderDaysBefore => $composableBuilder(
      column: $table.reminderDaysBefore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastOccurrence => $composableBuilder(
      column: $table.lastOccurrence,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextExpectedDate => $composableBuilder(
      column: $table.nextExpectedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$RecurringExpensesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTableTable> {
  $$RecurringExpensesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get averageAmount => $composableBuilder(
      column: $table.averageAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
      column: $table.dayOfMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderDaysBefore => $composableBuilder(
      column: $table.reminderDaysBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastOccurrence => $composableBuilder(
      column: $table.lastOccurrence,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextExpectedDate => $composableBuilder(
      column: $table.nextExpectedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$RecurringExpensesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringExpensesTableTable> {
  $$RecurringExpensesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get averageAmount => $composableBuilder(
      column: $table.averageAmount, builder: (column) => column);

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
      column: $table.dayOfMonth, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
      column: $table.reminderEnabled, builder: (column) => column);

  GeneratedColumn<int> get reminderDaysBefore => $composableBuilder(
      column: $table.reminderDaysBefore, builder: (column) => column);

  GeneratedColumn<String> get lastOccurrence => $composableBuilder(
      column: $table.lastOccurrence, builder: (column) => column);

  GeneratedColumn<String> get nextExpectedDate => $composableBuilder(
      column: $table.nextExpectedDate, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RecurringExpensesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecurringExpensesTableTable,
    RecurringExpensesTableData,
    $$RecurringExpensesTableTableFilterComposer,
    $$RecurringExpensesTableTableOrderingComposer,
    $$RecurringExpensesTableTableAnnotationComposer,
    $$RecurringExpensesTableTableCreateCompanionBuilder,
    $$RecurringExpensesTableTableUpdateCompanionBuilder,
    (
      RecurringExpensesTableData,
      BaseReferences<_$AppDatabase, $RecurringExpensesTableTable,
          RecurringExpensesTableData>
    ),
    RecurringExpensesTableData,
    PrefetchHooks Function()> {
  $$RecurringExpensesTableTableTableManager(
      _$AppDatabase db, $RecurringExpensesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringExpensesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringExpensesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringExpensesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> averageAmount = const Value.absent(),
            Value<int> dayOfMonth = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            Value<int> reminderDaysBefore = const Value.absent(),
            Value<String> lastOccurrence = const Value.absent(),
            Value<String> nextExpectedDate = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RecurringExpensesTableCompanion(
            id: id,
            uuid: uuid,
            userId: userId,
            category: category,
            description: description,
            averageAmount: averageAmount,
            dayOfMonth: dayOfMonth,
            frequency: frequency,
            isActive: isActive,
            reminderEnabled: reminderEnabled,
            reminderDaysBefore: reminderDaysBefore,
            lastOccurrence: lastOccurrence,
            nextExpectedDate: nextExpectedDate,
            syncStatus: syncStatus,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uuid,
            required String userId,
            required String category,
            required String description,
            required double averageAmount,
            required int dayOfMonth,
            required String frequency,
            Value<bool> isActive = const Value.absent(),
            Value<bool> reminderEnabled = const Value.absent(),
            Value<int> reminderDaysBefore = const Value.absent(),
            required String lastOccurrence,
            required String nextExpectedDate,
            Value<String> syncStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RecurringExpensesTableCompanion.insert(
            id: id,
            uuid: uuid,
            userId: userId,
            category: category,
            description: description,
            averageAmount: averageAmount,
            dayOfMonth: dayOfMonth,
            frequency: frequency,
            isActive: isActive,
            reminderEnabled: reminderEnabled,
            reminderDaysBefore: reminderDaysBefore,
            lastOccurrence: lastOccurrence,
            nextExpectedDate: nextExpectedDate,
            syncStatus: syncStatus,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecurringExpensesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RecurringExpensesTableTable,
        RecurringExpensesTableData,
        $$RecurringExpensesTableTableFilterComposer,
        $$RecurringExpensesTableTableOrderingComposer,
        $$RecurringExpensesTableTableAnnotationComposer,
        $$RecurringExpensesTableTableCreateCompanionBuilder,
        $$RecurringExpensesTableTableUpdateCompanionBuilder,
        (
          RecurringExpensesTableData,
          BaseReferences<_$AppDatabase, $RecurringExpensesTableTable,
              RecurringExpensesTableData>
        ),
        RecurringExpensesTableData,
        PrefetchHooks Function()>;
typedef $$AchievementsTableTableCreateCompanionBuilder
    = AchievementsTableCompanion Function({
  Value<int> id,
  required String userId,
  required String badgeId,
  required String badgeName,
  required String badgeDescription,
  required String badgeIcon,
  Value<bool> isUnlocked,
  Value<DateTime?> unlockedAt,
});
typedef $$AchievementsTableTableUpdateCompanionBuilder
    = AchievementsTableCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> badgeId,
  Value<String> badgeName,
  Value<String> badgeDescription,
  Value<String> badgeIcon,
  Value<bool> isUnlocked,
  Value<DateTime?> unlockedAt,
});

class $$AchievementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badgeId => $composableBuilder(
      column: $table.badgeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badgeName => $composableBuilder(
      column: $table.badgeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badgeDescription => $composableBuilder(
      column: $table.badgeDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badgeIcon => $composableBuilder(
      column: $table.badgeIcon, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
      column: $table.isUnlocked, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => ColumnFilters(column));
}

class $$AchievementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badgeId => $composableBuilder(
      column: $table.badgeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badgeName => $composableBuilder(
      column: $table.badgeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badgeDescription => $composableBuilder(
      column: $table.badgeDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badgeIcon => $composableBuilder(
      column: $table.badgeIcon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
      column: $table.isUnlocked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => ColumnOrderings(column));
}

class $$AchievementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get badgeId =>
      $composableBuilder(column: $table.badgeId, builder: (column) => column);

  GeneratedColumn<String> get badgeName =>
      $composableBuilder(column: $table.badgeName, builder: (column) => column);

  GeneratedColumn<String> get badgeDescription => $composableBuilder(
      column: $table.badgeDescription, builder: (column) => column);

  GeneratedColumn<String> get badgeIcon =>
      $composableBuilder(column: $table.badgeIcon, builder: (column) => column);

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
      column: $table.isUnlocked, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => column);
}

class $$AchievementsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AchievementsTableTable,
    AchievementsTableData,
    $$AchievementsTableTableFilterComposer,
    $$AchievementsTableTableOrderingComposer,
    $$AchievementsTableTableAnnotationComposer,
    $$AchievementsTableTableCreateCompanionBuilder,
    $$AchievementsTableTableUpdateCompanionBuilder,
    (
      AchievementsTableData,
      BaseReferences<_$AppDatabase, $AchievementsTableTable,
          AchievementsTableData>
    ),
    AchievementsTableData,
    PrefetchHooks Function()> {
  $$AchievementsTableTableTableManager(
      _$AppDatabase db, $AchievementsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> badgeId = const Value.absent(),
            Value<String> badgeName = const Value.absent(),
            Value<String> badgeDescription = const Value.absent(),
            Value<String> badgeIcon = const Value.absent(),
            Value<bool> isUnlocked = const Value.absent(),
            Value<DateTime?> unlockedAt = const Value.absent(),
          }) =>
              AchievementsTableCompanion(
            id: id,
            userId: userId,
            badgeId: badgeId,
            badgeName: badgeName,
            badgeDescription: badgeDescription,
            badgeIcon: badgeIcon,
            isUnlocked: isUnlocked,
            unlockedAt: unlockedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String badgeId,
            required String badgeName,
            required String badgeDescription,
            required String badgeIcon,
            Value<bool> isUnlocked = const Value.absent(),
            Value<DateTime?> unlockedAt = const Value.absent(),
          }) =>
              AchievementsTableCompanion.insert(
            id: id,
            userId: userId,
            badgeId: badgeId,
            badgeName: badgeName,
            badgeDescription: badgeDescription,
            badgeIcon: badgeIcon,
            isUnlocked: isUnlocked,
            unlockedAt: unlockedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AchievementsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AchievementsTableTable,
    AchievementsTableData,
    $$AchievementsTableTableFilterComposer,
    $$AchievementsTableTableOrderingComposer,
    $$AchievementsTableTableAnnotationComposer,
    $$AchievementsTableTableCreateCompanionBuilder,
    $$AchievementsTableTableUpdateCompanionBuilder,
    (
      AchievementsTableData,
      BaseReferences<_$AppDatabase, $AchievementsTableTable,
          AchievementsTableData>
    ),
    AchievementsTableData,
    PrefetchHooks Function()>;
typedef $$CategoryBudgetsTableCreateCompanionBuilder = CategoryBudgetsCompanion
    Function({
  Value<int> id,
  required String userId,
  required String category,
  required double limitAmount,
});
typedef $$CategoryBudgetsTableUpdateCompanionBuilder = CategoryBudgetsCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<String> category,
  Value<double> limitAmount,
});

class $$CategoryBudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryBudgetsTable> {
  $$CategoryBudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get limitAmount => $composableBuilder(
      column: $table.limitAmount, builder: (column) => ColumnFilters(column));
}

class $$CategoryBudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryBudgetsTable> {
  $$CategoryBudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get limitAmount => $composableBuilder(
      column: $table.limitAmount, builder: (column) => ColumnOrderings(column));
}

class $$CategoryBudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryBudgetsTable> {
  $$CategoryBudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get limitAmount => $composableBuilder(
      column: $table.limitAmount, builder: (column) => column);
}

class $$CategoryBudgetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryBudgetsTable,
    CategoryBudgetData,
    $$CategoryBudgetsTableFilterComposer,
    $$CategoryBudgetsTableOrderingComposer,
    $$CategoryBudgetsTableAnnotationComposer,
    $$CategoryBudgetsTableCreateCompanionBuilder,
    $$CategoryBudgetsTableUpdateCompanionBuilder,
    (
      CategoryBudgetData,
      BaseReferences<_$AppDatabase, $CategoryBudgetsTable, CategoryBudgetData>
    ),
    CategoryBudgetData,
    PrefetchHooks Function()> {
  $$CategoryBudgetsTableTableManager(
      _$AppDatabase db, $CategoryBudgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryBudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryBudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryBudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> limitAmount = const Value.absent(),
          }) =>
              CategoryBudgetsCompanion(
            id: id,
            userId: userId,
            category: category,
            limitAmount: limitAmount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String category,
            required double limitAmount,
          }) =>
              CategoryBudgetsCompanion.insert(
            id: id,
            userId: userId,
            category: category,
            limitAmount: limitAmount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryBudgetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryBudgetsTable,
    CategoryBudgetData,
    $$CategoryBudgetsTableFilterComposer,
    $$CategoryBudgetsTableOrderingComposer,
    $$CategoryBudgetsTableAnnotationComposer,
    $$CategoryBudgetsTableCreateCompanionBuilder,
    $$CategoryBudgetsTableUpdateCompanionBuilder,
    (
      CategoryBudgetData,
      BaseReferences<_$AppDatabase, $CategoryBudgetsTable, CategoryBudgetData>
    ),
    CategoryBudgetData,
    PrefetchHooks Function()>;
typedef $$RawExpensesTableCreateCompanionBuilder = RawExpensesCompanion
    Function({
  Value<int> id,
  required String userId,
  required String rawText,
  required int createdAt,
});
typedef $$RawExpensesTableUpdateCompanionBuilder = RawExpensesCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<String> rawText,
  Value<int> createdAt,
});

class $$RawExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $RawExpensesTable> {
  $$RawExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawText => $composableBuilder(
      column: $table.rawText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$RawExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $RawExpensesTable> {
  $$RawExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawText => $composableBuilder(
      column: $table.rawText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$RawExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RawExpensesTable> {
  $$RawExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RawExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RawExpensesTable,
    RawExpenseData,
    $$RawExpensesTableFilterComposer,
    $$RawExpensesTableOrderingComposer,
    $$RawExpensesTableAnnotationComposer,
    $$RawExpensesTableCreateCompanionBuilder,
    $$RawExpensesTableUpdateCompanionBuilder,
    (
      RawExpenseData,
      BaseReferences<_$AppDatabase, $RawExpensesTable, RawExpenseData>
    ),
    RawExpenseData,
    PrefetchHooks Function()> {
  $$RawExpensesTableTableManager(_$AppDatabase db, $RawExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> rawText = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              RawExpensesCompanion(
            id: id,
            userId: userId,
            rawText: rawText,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String rawText,
            required int createdAt,
          }) =>
              RawExpensesCompanion.insert(
            id: id,
            userId: userId,
            rawText: rawText,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RawExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RawExpensesTable,
    RawExpenseData,
    $$RawExpensesTableFilterComposer,
    $$RawExpensesTableOrderingComposer,
    $$RawExpensesTableAnnotationComposer,
    $$RawExpensesTableCreateCompanionBuilder,
    $$RawExpensesTableUpdateCompanionBuilder,
    (
      RawExpenseData,
      BaseReferences<_$AppDatabase, $RawExpensesTable, RawExpenseData>
    ),
    RawExpenseData,
    PrefetchHooks Function()>;
typedef $$GemmaInsightsTableTableCreateCompanionBuilder
    = GemmaInsightsTableCompanion Function({
  Value<int> id,
  required String userId,
  required String taskType,
  required String contextHash,
  required String insightText,
  required String month,
  Value<DateTime> generatedAt,
});
typedef $$GemmaInsightsTableTableUpdateCompanionBuilder
    = GemmaInsightsTableCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> taskType,
  Value<String> contextHash,
  Value<String> insightText,
  Value<String> month,
  Value<DateTime> generatedAt,
});

class $$GemmaInsightsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GemmaInsightsTableTable> {
  $$GemmaInsightsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskType => $composableBuilder(
      column: $table.taskType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextHash => $composableBuilder(
      column: $table.contextHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insightText => $composableBuilder(
      column: $table.insightText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));
}

class $$GemmaInsightsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GemmaInsightsTableTable> {
  $$GemmaInsightsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskType => $composableBuilder(
      column: $table.taskType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextHash => $composableBuilder(
      column: $table.contextHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insightText => $composableBuilder(
      column: $table.insightText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));
}

class $$GemmaInsightsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GemmaInsightsTableTable> {
  $$GemmaInsightsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get taskType =>
      $composableBuilder(column: $table.taskType, builder: (column) => column);

  GeneratedColumn<String> get contextHash => $composableBuilder(
      column: $table.contextHash, builder: (column) => column);

  GeneratedColumn<String> get insightText => $composableBuilder(
      column: $table.insightText, builder: (column) => column);

  GeneratedColumn<String> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);
}

class $$GemmaInsightsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GemmaInsightsTableTable,
    GemmaInsightData,
    $$GemmaInsightsTableTableFilterComposer,
    $$GemmaInsightsTableTableOrderingComposer,
    $$GemmaInsightsTableTableAnnotationComposer,
    $$GemmaInsightsTableTableCreateCompanionBuilder,
    $$GemmaInsightsTableTableUpdateCompanionBuilder,
    (
      GemmaInsightData,
      BaseReferences<_$AppDatabase, $GemmaInsightsTableTable, GemmaInsightData>
    ),
    GemmaInsightData,
    PrefetchHooks Function()> {
  $$GemmaInsightsTableTableTableManager(
      _$AppDatabase db, $GemmaInsightsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GemmaInsightsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GemmaInsightsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GemmaInsightsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> taskType = const Value.absent(),
            Value<String> contextHash = const Value.absent(),
            Value<String> insightText = const Value.absent(),
            Value<String> month = const Value.absent(),
            Value<DateTime> generatedAt = const Value.absent(),
          }) =>
              GemmaInsightsTableCompanion(
            id: id,
            userId: userId,
            taskType: taskType,
            contextHash: contextHash,
            insightText: insightText,
            month: month,
            generatedAt: generatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String taskType,
            required String contextHash,
            required String insightText,
            required String month,
            Value<DateTime> generatedAt = const Value.absent(),
          }) =>
              GemmaInsightsTableCompanion.insert(
            id: id,
            userId: userId,
            taskType: taskType,
            contextHash: contextHash,
            insightText: insightText,
            month: month,
            generatedAt: generatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GemmaInsightsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GemmaInsightsTableTable,
    GemmaInsightData,
    $$GemmaInsightsTableTableFilterComposer,
    $$GemmaInsightsTableTableOrderingComposer,
    $$GemmaInsightsTableTableAnnotationComposer,
    $$GemmaInsightsTableTableCreateCompanionBuilder,
    $$GemmaInsightsTableTableUpdateCompanionBuilder,
    (
      GemmaInsightData,
      BaseReferences<_$AppDatabase, $GemmaInsightsTableTable, GemmaInsightData>
    ),
    GemmaInsightData,
    PrefetchHooks Function()>;
typedef $$SmsImportLogTableTableCreateCompanionBuilder
    = SmsImportLogTableCompanion Function({
  Value<int> id,
  required String smsId,
  required String userId,
  required String sender,
  required String rawBody,
  required double amount,
  required String merchant,
  required String category,
  Value<String> status,
  Value<String?> expenseUuid,
  required DateTime smsDate,
  Value<DateTime> createdAt,
});
typedef $$SmsImportLogTableTableUpdateCompanionBuilder
    = SmsImportLogTableCompanion Function({
  Value<int> id,
  Value<String> smsId,
  Value<String> userId,
  Value<String> sender,
  Value<String> rawBody,
  Value<double> amount,
  Value<String> merchant,
  Value<String> category,
  Value<String> status,
  Value<String?> expenseUuid,
  Value<DateTime> smsDate,
  Value<DateTime> createdAt,
});

class $$SmsImportLogTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsImportLogTableTable> {
  $$SmsImportLogTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get smsId => $composableBuilder(
      column: $table.smsId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sender => $composableBuilder(
      column: $table.sender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawBody => $composableBuilder(
      column: $table.rawBody, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get merchant => $composableBuilder(
      column: $table.merchant, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get expenseUuid => $composableBuilder(
      column: $table.expenseUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get smsDate => $composableBuilder(
      column: $table.smsDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SmsImportLogTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsImportLogTableTable> {
  $$SmsImportLogTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get smsId => $composableBuilder(
      column: $table.smsId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sender => $composableBuilder(
      column: $table.sender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawBody => $composableBuilder(
      column: $table.rawBody, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get merchant => $composableBuilder(
      column: $table.merchant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get expenseUuid => $composableBuilder(
      column: $table.expenseUuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get smsDate => $composableBuilder(
      column: $table.smsDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SmsImportLogTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsImportLogTableTable> {
  $$SmsImportLogTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get smsId =>
      $composableBuilder(column: $table.smsId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get rawBody =>
      $composableBuilder(column: $table.rawBody, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get expenseUuid => $composableBuilder(
      column: $table.expenseUuid, builder: (column) => column);

  GeneratedColumn<DateTime> get smsDate =>
      $composableBuilder(column: $table.smsDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SmsImportLogTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmsImportLogTableTable,
    SmsImportLogTableData,
    $$SmsImportLogTableTableFilterComposer,
    $$SmsImportLogTableTableOrderingComposer,
    $$SmsImportLogTableTableAnnotationComposer,
    $$SmsImportLogTableTableCreateCompanionBuilder,
    $$SmsImportLogTableTableUpdateCompanionBuilder,
    (
      SmsImportLogTableData,
      BaseReferences<_$AppDatabase, $SmsImportLogTableTable,
          SmsImportLogTableData>
    ),
    SmsImportLogTableData,
    PrefetchHooks Function()> {
  $$SmsImportLogTableTableTableManager(
      _$AppDatabase db, $SmsImportLogTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsImportLogTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsImportLogTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsImportLogTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> smsId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> sender = const Value.absent(),
            Value<String> rawBody = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> merchant = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> expenseUuid = const Value.absent(),
            Value<DateTime> smsDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SmsImportLogTableCompanion(
            id: id,
            smsId: smsId,
            userId: userId,
            sender: sender,
            rawBody: rawBody,
            amount: amount,
            merchant: merchant,
            category: category,
            status: status,
            expenseUuid: expenseUuid,
            smsDate: smsDate,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String smsId,
            required String userId,
            required String sender,
            required String rawBody,
            required double amount,
            required String merchant,
            required String category,
            Value<String> status = const Value.absent(),
            Value<String?> expenseUuid = const Value.absent(),
            required DateTime smsDate,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SmsImportLogTableCompanion.insert(
            id: id,
            smsId: smsId,
            userId: userId,
            sender: sender,
            rawBody: rawBody,
            amount: amount,
            merchant: merchant,
            category: category,
            status: status,
            expenseUuid: expenseUuid,
            smsDate: smsDate,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SmsImportLogTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SmsImportLogTableTable,
    SmsImportLogTableData,
    $$SmsImportLogTableTableFilterComposer,
    $$SmsImportLogTableTableOrderingComposer,
    $$SmsImportLogTableTableAnnotationComposer,
    $$SmsImportLogTableTableCreateCompanionBuilder,
    $$SmsImportLogTableTableUpdateCompanionBuilder,
    (
      SmsImportLogTableData,
      BaseReferences<_$AppDatabase, $SmsImportLogTableTable,
          SmsImportLogTableData>
    ),
    SmsImportLogTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$PendingSyncsTableTableManager get pendingSyncs =>
      $$PendingSyncsTableTableManager(_db, _db.pendingSyncs);
  $$FinancialProfilesTableTableManager get financialProfiles =>
      $$FinancialProfilesTableTableManager(_db, _db.financialProfiles);
  $$BudgetsTableTableManager get budgets =>
      $$BudgetsTableTableManager(_db, _db.budgets);
  $$AiInsightsTableTableManager get aiInsights =>
      $$AiInsightsTableTableManager(_db, _db.aiInsights);
  $$RecurringExpensesTableTableTableManager get recurringExpensesTable =>
      $$RecurringExpensesTableTableTableManager(
          _db, _db.recurringExpensesTable);
  $$AchievementsTableTableTableManager get achievementsTable =>
      $$AchievementsTableTableTableManager(_db, _db.achievementsTable);
  $$CategoryBudgetsTableTableManager get categoryBudgets =>
      $$CategoryBudgetsTableTableManager(_db, _db.categoryBudgets);
  $$RawExpensesTableTableManager get rawExpenses =>
      $$RawExpensesTableTableManager(_db, _db.rawExpenses);
  $$GemmaInsightsTableTableTableManager get gemmaInsightsTable =>
      $$GemmaInsightsTableTableTableManager(_db, _db.gemmaInsightsTable);
  $$SmsImportLogTableTableTableManager get smsImportLogTable =>
      $$SmsImportLogTableTableTableManager(_db, _db.smsImportLogTable);
}
