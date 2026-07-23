// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PrayerLogsTableTable extends PrayerLogsTable
    with TableInfo<$PrayerLogsTableTable, PrayerLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prayerNameMeta = const VerificationMeta(
    'prayerName',
  );
  @override
  late final GeneratedColumn<String> prayerName = GeneratedColumn<String>(
    'prayer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    prayerName,
    status,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('prayer_name')) {
      context.handle(
        _prayerNameMeta,
        prayerName.isAcceptableOrUnknown(data['prayer_name']!, _prayerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_prayerNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrayerLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      prayerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayer_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PrayerLogsTableTable createAlias(String alias) {
    return $PrayerLogsTableTable(attachedDatabase, alias);
  }
}

class PrayerLogsTableData extends DataClass
    implements Insertable<PrayerLogsTableData> {
  final int id;
  final String date;
  final String prayerName;
  final String status;
  final DateTime updatedAt;
  const PrayerLogsTableData({
    required this.id,
    required this.date,
    required this.prayerName,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['prayer_name'] = Variable<String>(prayerName);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrayerLogsTableCompanion toCompanion(bool nullToAbsent) {
    return PrayerLogsTableCompanion(
      id: Value(id),
      date: Value(date),
      prayerName: Value(prayerName),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrayerLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerLogsTableData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      prayerName: serializer.fromJson<String>(json['prayerName']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'prayerName': serializer.toJson<String>(prayerName),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrayerLogsTableData copyWith({
    int? id,
    String? date,
    String? prayerName,
    String? status,
    DateTime? updatedAt,
  }) => PrayerLogsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    prayerName: prayerName ?? this.prayerName,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PrayerLogsTableData copyWithCompanion(PrayerLogsTableCompanion data) {
    return PrayerLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      prayerName: data.prayerName.present
          ? data.prayerName.value
          : this.prayerName,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerLogsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('prayerName: $prayerName, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, prayerName, status, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerLogsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.prayerName == this.prayerName &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class PrayerLogsTableCompanion extends UpdateCompanion<PrayerLogsTableData> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> prayerName;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  const PrayerLogsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.prayerName = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PrayerLogsTableCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String prayerName,
    required String status,
    required DateTime updatedAt,
  }) : date = Value(date),
       prayerName = Value(prayerName),
       status = Value(status),
       updatedAt = Value(updatedAt);
  static Insertable<PrayerLogsTableData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? prayerName,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (prayerName != null) 'prayer_name': prayerName,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PrayerLogsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<String>? prayerName,
    Value<String>? status,
    Value<DateTime>? updatedAt,
  }) {
    return PrayerLogsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      prayerName: prayerName ?? this.prayerName,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (prayerName.present) {
      map['prayer_name'] = Variable<String>(prayerName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('prayerName: $prayerName, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BatteryOptStateTableTable extends BatteryOptStateTable
    with TableInfo<$BatteryOptStateTableTable, BatteryOptStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatteryOptStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastKnownExemptMeta = const VerificationMeta(
    'lastKnownExempt',
  );
  @override
  late final GeneratedColumn<bool> lastKnownExempt = GeneratedColumn<bool>(
    'last_known_exempt',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("last_known_exempt" IN (0, 1))',
    ),
  );
  static const VerificationMeta _nagDisabledMeta = const VerificationMeta(
    'nagDisabled',
  );
  @override
  late final GeneratedColumn<bool> nagDisabled = GeneratedColumn<bool>(
    'nag_disabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("nag_disabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPromptAtMeta = const VerificationMeta(
    'lastPromptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPromptAt = GeneratedColumn<DateTime>(
    'last_prompt_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lastKnownExempt,
    nagDisabled,
    lastPromptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battery_opt_state_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatteryOptStateTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_known_exempt')) {
      context.handle(
        _lastKnownExemptMeta,
        lastKnownExempt.isAcceptableOrUnknown(
          data['last_known_exempt']!,
          _lastKnownExemptMeta,
        ),
      );
    }
    if (data.containsKey('nag_disabled')) {
      context.handle(
        _nagDisabledMeta,
        nagDisabled.isAcceptableOrUnknown(
          data['nag_disabled']!,
          _nagDisabledMeta,
        ),
      );
    }
    if (data.containsKey('last_prompt_at')) {
      context.handle(
        _lastPromptAtMeta,
        lastPromptAt.isAcceptableOrUnknown(
          data['last_prompt_at']!,
          _lastPromptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatteryOptStateTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatteryOptStateTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastKnownExempt: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}last_known_exempt'],
      ),
      nagDisabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}nag_disabled'],
      )!,
      lastPromptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_prompt_at'],
      ),
    );
  }

  @override
  $BatteryOptStateTableTable createAlias(String alias) {
    return $BatteryOptStateTableTable(attachedDatabase, alias);
  }
}

class BatteryOptStateTableData extends DataClass
    implements Insertable<BatteryOptStateTableData> {
  final int id;
  final bool? lastKnownExempt;
  final bool nagDisabled;
  final DateTime? lastPromptAt;
  const BatteryOptStateTableData({
    required this.id,
    this.lastKnownExempt,
    required this.nagDisabled,
    this.lastPromptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastKnownExempt != null) {
      map['last_known_exempt'] = Variable<bool>(lastKnownExempt);
    }
    map['nag_disabled'] = Variable<bool>(nagDisabled);
    if (!nullToAbsent || lastPromptAt != null) {
      map['last_prompt_at'] = Variable<DateTime>(lastPromptAt);
    }
    return map;
  }

  BatteryOptStateTableCompanion toCompanion(bool nullToAbsent) {
    return BatteryOptStateTableCompanion(
      id: Value(id),
      lastKnownExempt: lastKnownExempt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastKnownExempt),
      nagDisabled: Value(nagDisabled),
      lastPromptAt: lastPromptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPromptAt),
    );
  }

  factory BatteryOptStateTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatteryOptStateTableData(
      id: serializer.fromJson<int>(json['id']),
      lastKnownExempt: serializer.fromJson<bool?>(json['lastKnownExempt']),
      nagDisabled: serializer.fromJson<bool>(json['nagDisabled']),
      lastPromptAt: serializer.fromJson<DateTime?>(json['lastPromptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastKnownExempt': serializer.toJson<bool?>(lastKnownExempt),
      'nagDisabled': serializer.toJson<bool>(nagDisabled),
      'lastPromptAt': serializer.toJson<DateTime?>(lastPromptAt),
    };
  }

  BatteryOptStateTableData copyWith({
    int? id,
    Value<bool?> lastKnownExempt = const Value.absent(),
    bool? nagDisabled,
    Value<DateTime?> lastPromptAt = const Value.absent(),
  }) => BatteryOptStateTableData(
    id: id ?? this.id,
    lastKnownExempt: lastKnownExempt.present
        ? lastKnownExempt.value
        : this.lastKnownExempt,
    nagDisabled: nagDisabled ?? this.nagDisabled,
    lastPromptAt: lastPromptAt.present ? lastPromptAt.value : this.lastPromptAt,
  );
  BatteryOptStateTableData copyWithCompanion(
    BatteryOptStateTableCompanion data,
  ) {
    return BatteryOptStateTableData(
      id: data.id.present ? data.id.value : this.id,
      lastKnownExempt: data.lastKnownExempt.present
          ? data.lastKnownExempt.value
          : this.lastKnownExempt,
      nagDisabled: data.nagDisabled.present
          ? data.nagDisabled.value
          : this.nagDisabled,
      lastPromptAt: data.lastPromptAt.present
          ? data.lastPromptAt.value
          : this.lastPromptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatteryOptStateTableData(')
          ..write('id: $id, ')
          ..write('lastKnownExempt: $lastKnownExempt, ')
          ..write('nagDisabled: $nagDisabled, ')
          ..write('lastPromptAt: $lastPromptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, lastKnownExempt, nagDisabled, lastPromptAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatteryOptStateTableData &&
          other.id == this.id &&
          other.lastKnownExempt == this.lastKnownExempt &&
          other.nagDisabled == this.nagDisabled &&
          other.lastPromptAt == this.lastPromptAt);
}

class BatteryOptStateTableCompanion
    extends UpdateCompanion<BatteryOptStateTableData> {
  final Value<int> id;
  final Value<bool?> lastKnownExempt;
  final Value<bool> nagDisabled;
  final Value<DateTime?> lastPromptAt;
  const BatteryOptStateTableCompanion({
    this.id = const Value.absent(),
    this.lastKnownExempt = const Value.absent(),
    this.nagDisabled = const Value.absent(),
    this.lastPromptAt = const Value.absent(),
  });
  BatteryOptStateTableCompanion.insert({
    this.id = const Value.absent(),
    this.lastKnownExempt = const Value.absent(),
    this.nagDisabled = const Value.absent(),
    this.lastPromptAt = const Value.absent(),
  });
  static Insertable<BatteryOptStateTableData> custom({
    Expression<int>? id,
    Expression<bool>? lastKnownExempt,
    Expression<bool>? nagDisabled,
    Expression<DateTime>? lastPromptAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastKnownExempt != null) 'last_known_exempt': lastKnownExempt,
      if (nagDisabled != null) 'nag_disabled': nagDisabled,
      if (lastPromptAt != null) 'last_prompt_at': lastPromptAt,
    });
  }

  BatteryOptStateTableCompanion copyWith({
    Value<int>? id,
    Value<bool?>? lastKnownExempt,
    Value<bool>? nagDisabled,
    Value<DateTime?>? lastPromptAt,
  }) {
    return BatteryOptStateTableCompanion(
      id: id ?? this.id,
      lastKnownExempt: lastKnownExempt ?? this.lastKnownExempt,
      nagDisabled: nagDisabled ?? this.nagDisabled,
      lastPromptAt: lastPromptAt ?? this.lastPromptAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastKnownExempt.present) {
      map['last_known_exempt'] = Variable<bool>(lastKnownExempt.value);
    }
    if (nagDisabled.present) {
      map['nag_disabled'] = Variable<bool>(nagDisabled.value);
    }
    if (lastPromptAt.present) {
      map['last_prompt_at'] = Variable<DateTime>(lastPromptAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatteryOptStateTableCompanion(')
          ..write('id: $id, ')
          ..write('lastKnownExempt: $lastKnownExempt, ')
          ..write('nagDisabled: $nagDisabled, ')
          ..write('lastPromptAt: $lastPromptAt')
          ..write(')'))
        .toString();
  }
}

class $DailyContentCacheTableTable extends DailyContentCacheTable
    with TableInfo<$DailyContentCacheTableTable, DailyContentCacheTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyContentCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [date, contentId, resolvedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_content_cache_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyContentCacheTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_resolvedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyContentCacheTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyContentCacheTableData(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      )!,
    );
  }

  @override
  $DailyContentCacheTableTable createAlias(String alias) {
    return $DailyContentCacheTableTable(attachedDatabase, alias);
  }
}

class DailyContentCacheTableData extends DataClass
    implements Insertable<DailyContentCacheTableData> {
  final String date;
  final String contentId;
  final DateTime resolvedAt;
  const DailyContentCacheTableData({
    required this.date,
    required this.contentId,
    required this.resolvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['content_id'] = Variable<String>(contentId);
    map['resolved_at'] = Variable<DateTime>(resolvedAt);
    return map;
  }

  DailyContentCacheTableCompanion toCompanion(bool nullToAbsent) {
    return DailyContentCacheTableCompanion(
      date: Value(date),
      contentId: Value(contentId),
      resolvedAt: Value(resolvedAt),
    );
  }

  factory DailyContentCacheTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyContentCacheTableData(
      date: serializer.fromJson<String>(json['date']),
      contentId: serializer.fromJson<String>(json['contentId']),
      resolvedAt: serializer.fromJson<DateTime>(json['resolvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'contentId': serializer.toJson<String>(contentId),
      'resolvedAt': serializer.toJson<DateTime>(resolvedAt),
    };
  }

  DailyContentCacheTableData copyWith({
    String? date,
    String? contentId,
    DateTime? resolvedAt,
  }) => DailyContentCacheTableData(
    date: date ?? this.date,
    contentId: contentId ?? this.contentId,
    resolvedAt: resolvedAt ?? this.resolvedAt,
  );
  DailyContentCacheTableData copyWithCompanion(
    DailyContentCacheTableCompanion data,
  ) {
    return DailyContentCacheTableData(
      date: data.date.present ? data.date.value : this.date,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyContentCacheTableData(')
          ..write('date: $date, ')
          ..write('contentId: $contentId, ')
          ..write('resolvedAt: $resolvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, contentId, resolvedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyContentCacheTableData &&
          other.date == this.date &&
          other.contentId == this.contentId &&
          other.resolvedAt == this.resolvedAt);
}

class DailyContentCacheTableCompanion
    extends UpdateCompanion<DailyContentCacheTableData> {
  final Value<String> date;
  final Value<String> contentId;
  final Value<DateTime> resolvedAt;
  final Value<int> rowid;
  const DailyContentCacheTableCompanion({
    this.date = const Value.absent(),
    this.contentId = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyContentCacheTableCompanion.insert({
    required String date,
    required String contentId,
    required DateTime resolvedAt,
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       contentId = Value(contentId),
       resolvedAt = Value(resolvedAt);
  static Insertable<DailyContentCacheTableData> custom({
    Expression<String>? date,
    Expression<String>? contentId,
    Expression<DateTime>? resolvedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (contentId != null) 'content_id': contentId,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyContentCacheTableCompanion copyWith({
    Value<String>? date,
    Value<String>? contentId,
    Value<DateTime>? resolvedAt,
    Value<int>? rowid,
  }) {
    return DailyContentCacheTableCompanion(
      date: date ?? this.date,
      contentId: contentId ?? this.contentId,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyContentCacheTableCompanion(')
          ..write('date: $date, ')
          ..write('contentId: $contentId, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyContentShownLogTableTable extends DailyContentShownLogTable
    with
        TableInfo<
          $DailyContentShownLogTableTable,
          DailyContentShownLogTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyContentShownLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shownDateMeta = const VerificationMeta(
    'shownDate',
  );
  @override
  late final GeneratedColumn<String> shownDate = GeneratedColumn<String>(
    'shown_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, contentId, shownDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_content_shown_log_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyContentShownLogTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('shown_date')) {
      context.handle(
        _shownDateMeta,
        shownDate.isAcceptableOrUnknown(data['shown_date']!, _shownDateMeta),
      );
    } else if (isInserting) {
      context.missing(_shownDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyContentShownLogTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyContentShownLogTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      shownDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shown_date'],
      )!,
    );
  }

  @override
  $DailyContentShownLogTableTable createAlias(String alias) {
    return $DailyContentShownLogTableTable(attachedDatabase, alias);
  }
}

class DailyContentShownLogTableData extends DataClass
    implements Insertable<DailyContentShownLogTableData> {
  final int id;
  final String contentId;
  final String shownDate;
  const DailyContentShownLogTableData({
    required this.id,
    required this.contentId,
    required this.shownDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_id'] = Variable<String>(contentId);
    map['shown_date'] = Variable<String>(shownDate);
    return map;
  }

  DailyContentShownLogTableCompanion toCompanion(bool nullToAbsent) {
    return DailyContentShownLogTableCompanion(
      id: Value(id),
      contentId: Value(contentId),
      shownDate: Value(shownDate),
    );
  }

  factory DailyContentShownLogTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyContentShownLogTableData(
      id: serializer.fromJson<int>(json['id']),
      contentId: serializer.fromJson<String>(json['contentId']),
      shownDate: serializer.fromJson<String>(json['shownDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentId': serializer.toJson<String>(contentId),
      'shownDate': serializer.toJson<String>(shownDate),
    };
  }

  DailyContentShownLogTableData copyWith({
    int? id,
    String? contentId,
    String? shownDate,
  }) => DailyContentShownLogTableData(
    id: id ?? this.id,
    contentId: contentId ?? this.contentId,
    shownDate: shownDate ?? this.shownDate,
  );
  DailyContentShownLogTableData copyWithCompanion(
    DailyContentShownLogTableCompanion data,
  ) {
    return DailyContentShownLogTableData(
      id: data.id.present ? data.id.value : this.id,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      shownDate: data.shownDate.present ? data.shownDate.value : this.shownDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyContentShownLogTableData(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('shownDate: $shownDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contentId, shownDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyContentShownLogTableData &&
          other.id == this.id &&
          other.contentId == this.contentId &&
          other.shownDate == this.shownDate);
}

class DailyContentShownLogTableCompanion
    extends UpdateCompanion<DailyContentShownLogTableData> {
  final Value<int> id;
  final Value<String> contentId;
  final Value<String> shownDate;
  const DailyContentShownLogTableCompanion({
    this.id = const Value.absent(),
    this.contentId = const Value.absent(),
    this.shownDate = const Value.absent(),
  });
  DailyContentShownLogTableCompanion.insert({
    this.id = const Value.absent(),
    required String contentId,
    required String shownDate,
  }) : contentId = Value(contentId),
       shownDate = Value(shownDate);
  static Insertable<DailyContentShownLogTableData> custom({
    Expression<int>? id,
    Expression<String>? contentId,
    Expression<String>? shownDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentId != null) 'content_id': contentId,
      if (shownDate != null) 'shown_date': shownDate,
    });
  }

  DailyContentShownLogTableCompanion copyWith({
    Value<int>? id,
    Value<String>? contentId,
    Value<String>? shownDate,
  }) {
    return DailyContentShownLogTableCompanion(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      shownDate: shownDate ?? this.shownDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (shownDate.present) {
      map['shown_date'] = Variable<String>(shownDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyContentShownLogTableCompanion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('shownDate: $shownDate')
          ..write(')'))
        .toString();
  }
}

class $FavoriteDailyContentTableTable extends FavoriteDailyContentTable
    with
        TableInfo<
          $FavoriteDailyContentTableTable,
          FavoriteDailyContentTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteDailyContentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _favoritedAtMeta = const VerificationMeta(
    'favoritedAt',
  );
  @override
  late final GeneratedColumn<DateTime> favoritedAt = GeneratedColumn<DateTime>(
    'favorited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [contentId, favoritedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_daily_content_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteDailyContentTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('favorited_at')) {
      context.handle(
        _favoritedAtMeta,
        favoritedAt.isAcceptableOrUnknown(
          data['favorited_at']!,
          _favoritedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_favoritedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contentId};
  @override
  FavoriteDailyContentTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteDailyContentTableData(
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      favoritedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}favorited_at'],
      )!,
    );
  }

  @override
  $FavoriteDailyContentTableTable createAlias(String alias) {
    return $FavoriteDailyContentTableTable(attachedDatabase, alias);
  }
}

class FavoriteDailyContentTableData extends DataClass
    implements Insertable<FavoriteDailyContentTableData> {
  final String contentId;
  final DateTime favoritedAt;
  const FavoriteDailyContentTableData({
    required this.contentId,
    required this.favoritedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content_id'] = Variable<String>(contentId);
    map['favorited_at'] = Variable<DateTime>(favoritedAt);
    return map;
  }

  FavoriteDailyContentTableCompanion toCompanion(bool nullToAbsent) {
    return FavoriteDailyContentTableCompanion(
      contentId: Value(contentId),
      favoritedAt: Value(favoritedAt),
    );
  }

  factory FavoriteDailyContentTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteDailyContentTableData(
      contentId: serializer.fromJson<String>(json['contentId']),
      favoritedAt: serializer.fromJson<DateTime>(json['favoritedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'contentId': serializer.toJson<String>(contentId),
      'favoritedAt': serializer.toJson<DateTime>(favoritedAt),
    };
  }

  FavoriteDailyContentTableData copyWith({
    String? contentId,
    DateTime? favoritedAt,
  }) => FavoriteDailyContentTableData(
    contentId: contentId ?? this.contentId,
    favoritedAt: favoritedAt ?? this.favoritedAt,
  );
  FavoriteDailyContentTableData copyWithCompanion(
    FavoriteDailyContentTableCompanion data,
  ) {
    return FavoriteDailyContentTableData(
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      favoritedAt: data.favoritedAt.present
          ? data.favoritedAt.value
          : this.favoritedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteDailyContentTableData(')
          ..write('contentId: $contentId, ')
          ..write('favoritedAt: $favoritedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(contentId, favoritedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteDailyContentTableData &&
          other.contentId == this.contentId &&
          other.favoritedAt == this.favoritedAt);
}

class FavoriteDailyContentTableCompanion
    extends UpdateCompanion<FavoriteDailyContentTableData> {
  final Value<String> contentId;
  final Value<DateTime> favoritedAt;
  final Value<int> rowid;
  const FavoriteDailyContentTableCompanion({
    this.contentId = const Value.absent(),
    this.favoritedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteDailyContentTableCompanion.insert({
    required String contentId,
    required DateTime favoritedAt,
    this.rowid = const Value.absent(),
  }) : contentId = Value(contentId),
       favoritedAt = Value(favoritedAt);
  static Insertable<FavoriteDailyContentTableData> custom({
    Expression<String>? contentId,
    Expression<DateTime>? favoritedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (contentId != null) 'content_id': contentId,
      if (favoritedAt != null) 'favorited_at': favoritedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteDailyContentTableCompanion copyWith({
    Value<String>? contentId,
    Value<DateTime>? favoritedAt,
    Value<int>? rowid,
  }) {
    return FavoriteDailyContentTableCompanion(
      contentId: contentId ?? this.contentId,
      favoritedAt: favoritedAt ?? this.favoritedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (favoritedAt.present) {
      map['favorited_at'] = Variable<DateTime>(favoritedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteDailyContentTableCompanion(')
          ..write('contentId: $contentId, ')
          ..write('favoritedAt: $favoritedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetadataTableTable extends AppMetadataTable
    with TableInfo<$AppMetadataTableTable, AppMetadataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_metadata_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetadataTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetadataTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetadataTableData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetadataTableTable createAlias(String alias) {
    return $AppMetadataTableTable(attachedDatabase, alias);
  }
}

class AppMetadataTableData extends DataClass
    implements Insertable<AppMetadataTableData> {
  final String key;
  final String value;
  const AppMetadataTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return AppMetadataTableCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetadataTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetadataTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetadataTableData copyWith({String? key, String? value}) =>
      AppMetadataTableData(key: key ?? this.key, value: value ?? this.value);
  AppMetadataTableData copyWithCompanion(AppMetadataTableCompanion data) {
    return AppMetadataTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetadataTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetadataTableCompanion extends UpdateCompanion<AppMetadataTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetadataTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetadataTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetadataTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetadataTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetadataTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PrayerLogsTableTable prayerLogsTable = $PrayerLogsTableTable(
    this,
  );
  late final $BatteryOptStateTableTable batteryOptStateTable =
      $BatteryOptStateTableTable(this);
  late final $DailyContentCacheTableTable dailyContentCacheTable =
      $DailyContentCacheTableTable(this);
  late final $DailyContentShownLogTableTable dailyContentShownLogTable =
      $DailyContentShownLogTableTable(this);
  late final $FavoriteDailyContentTableTable favoriteDailyContentTable =
      $FavoriteDailyContentTableTable(this);
  late final $AppMetadataTableTable appMetadataTable = $AppMetadataTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    prayerLogsTable,
    batteryOptStateTable,
    dailyContentCacheTable,
    dailyContentShownLogTable,
    favoriteDailyContentTable,
    appMetadataTable,
  ];
}

typedef $$PrayerLogsTableTableCreateCompanionBuilder =
    PrayerLogsTableCompanion Function({
      Value<int> id,
      required String date,
      required String prayerName,
      required String status,
      required DateTime updatedAt,
    });
typedef $$PrayerLogsTableTableUpdateCompanionBuilder =
    PrayerLogsTableCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<String> prayerName,
      Value<String> status,
      Value<DateTime> updatedAt,
    });

class $$PrayerLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerLogsTableTable> {
  $$PrayerLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prayerName => $composableBuilder(
    column: $table.prayerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrayerLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerLogsTableTable> {
  $$PrayerLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayerName => $composableBuilder(
    column: $table.prayerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrayerLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerLogsTableTable> {
  $$PrayerLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get prayerName => $composableBuilder(
    column: $table.prayerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PrayerLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerLogsTableTable,
          PrayerLogsTableData,
          $$PrayerLogsTableTableFilterComposer,
          $$PrayerLogsTableTableOrderingComposer,
          $$PrayerLogsTableTableAnnotationComposer,
          $$PrayerLogsTableTableCreateCompanionBuilder,
          $$PrayerLogsTableTableUpdateCompanionBuilder,
          (
            PrayerLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $PrayerLogsTableTable,
              PrayerLogsTableData
            >,
          ),
          PrayerLogsTableData,
          PrefetchHooks Function()
        > {
  $$PrayerLogsTableTableTableManager(
    _$AppDatabase db,
    $PrayerLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> prayerName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PrayerLogsTableCompanion(
                id: id,
                date: date,
                prayerName: prayerName,
                status: status,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required String prayerName,
                required String status,
                required DateTime updatedAt,
              }) => PrayerLogsTableCompanion.insert(
                id: id,
                date: date,
                prayerName: prayerName,
                status: status,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrayerLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerLogsTableTable,
      PrayerLogsTableData,
      $$PrayerLogsTableTableFilterComposer,
      $$PrayerLogsTableTableOrderingComposer,
      $$PrayerLogsTableTableAnnotationComposer,
      $$PrayerLogsTableTableCreateCompanionBuilder,
      $$PrayerLogsTableTableUpdateCompanionBuilder,
      (
        PrayerLogsTableData,
        BaseReferences<
          _$AppDatabase,
          $PrayerLogsTableTable,
          PrayerLogsTableData
        >,
      ),
      PrayerLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$BatteryOptStateTableTableCreateCompanionBuilder =
    BatteryOptStateTableCompanion Function({
      Value<int> id,
      Value<bool?> lastKnownExempt,
      Value<bool> nagDisabled,
      Value<DateTime?> lastPromptAt,
    });
typedef $$BatteryOptStateTableTableUpdateCompanionBuilder =
    BatteryOptStateTableCompanion Function({
      Value<int> id,
      Value<bool?> lastKnownExempt,
      Value<bool> nagDisabled,
      Value<DateTime?> lastPromptAt,
    });

class $$BatteryOptStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $BatteryOptStateTableTable> {
  $$BatteryOptStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lastKnownExempt => $composableBuilder(
    column: $table.lastKnownExempt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get nagDisabled => $composableBuilder(
    column: $table.nagDisabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPromptAt => $composableBuilder(
    column: $table.lastPromptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BatteryOptStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BatteryOptStateTableTable> {
  $$BatteryOptStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lastKnownExempt => $composableBuilder(
    column: $table.lastKnownExempt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get nagDisabled => $composableBuilder(
    column: $table.nagDisabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPromptAt => $composableBuilder(
    column: $table.lastPromptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BatteryOptStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatteryOptStateTableTable> {
  $$BatteryOptStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get lastKnownExempt => $composableBuilder(
    column: $table.lastKnownExempt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get nagDisabled => $composableBuilder(
    column: $table.nagDisabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPromptAt => $composableBuilder(
    column: $table.lastPromptAt,
    builder: (column) => column,
  );
}

class $$BatteryOptStateTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatteryOptStateTableTable,
          BatteryOptStateTableData,
          $$BatteryOptStateTableTableFilterComposer,
          $$BatteryOptStateTableTableOrderingComposer,
          $$BatteryOptStateTableTableAnnotationComposer,
          $$BatteryOptStateTableTableCreateCompanionBuilder,
          $$BatteryOptStateTableTableUpdateCompanionBuilder,
          (
            BatteryOptStateTableData,
            BaseReferences<
              _$AppDatabase,
              $BatteryOptStateTableTable,
              BatteryOptStateTableData
            >,
          ),
          BatteryOptStateTableData,
          PrefetchHooks Function()
        > {
  $$BatteryOptStateTableTableTableManager(
    _$AppDatabase db,
    $BatteryOptStateTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatteryOptStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatteryOptStateTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BatteryOptStateTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> lastKnownExempt = const Value.absent(),
                Value<bool> nagDisabled = const Value.absent(),
                Value<DateTime?> lastPromptAt = const Value.absent(),
              }) => BatteryOptStateTableCompanion(
                id: id,
                lastKnownExempt: lastKnownExempt,
                nagDisabled: nagDisabled,
                lastPromptAt: lastPromptAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool?> lastKnownExempt = const Value.absent(),
                Value<bool> nagDisabled = const Value.absent(),
                Value<DateTime?> lastPromptAt = const Value.absent(),
              }) => BatteryOptStateTableCompanion.insert(
                id: id,
                lastKnownExempt: lastKnownExempt,
                nagDisabled: nagDisabled,
                lastPromptAt: lastPromptAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BatteryOptStateTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatteryOptStateTableTable,
      BatteryOptStateTableData,
      $$BatteryOptStateTableTableFilterComposer,
      $$BatteryOptStateTableTableOrderingComposer,
      $$BatteryOptStateTableTableAnnotationComposer,
      $$BatteryOptStateTableTableCreateCompanionBuilder,
      $$BatteryOptStateTableTableUpdateCompanionBuilder,
      (
        BatteryOptStateTableData,
        BaseReferences<
          _$AppDatabase,
          $BatteryOptStateTableTable,
          BatteryOptStateTableData
        >,
      ),
      BatteryOptStateTableData,
      PrefetchHooks Function()
    >;
typedef $$DailyContentCacheTableTableCreateCompanionBuilder =
    DailyContentCacheTableCompanion Function({
      required String date,
      required String contentId,
      required DateTime resolvedAt,
      Value<int> rowid,
    });
typedef $$DailyContentCacheTableTableUpdateCompanionBuilder =
    DailyContentCacheTableCompanion Function({
      Value<String> date,
      Value<String> contentId,
      Value<DateTime> resolvedAt,
      Value<int> rowid,
    });

class $$DailyContentCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyContentCacheTableTable> {
  $$DailyContentCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyContentCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyContentCacheTableTable> {
  $$DailyContentCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyContentCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyContentCacheTableTable> {
  $$DailyContentCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );
}

class $$DailyContentCacheTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyContentCacheTableTable,
          DailyContentCacheTableData,
          $$DailyContentCacheTableTableFilterComposer,
          $$DailyContentCacheTableTableOrderingComposer,
          $$DailyContentCacheTableTableAnnotationComposer,
          $$DailyContentCacheTableTableCreateCompanionBuilder,
          $$DailyContentCacheTableTableUpdateCompanionBuilder,
          (
            DailyContentCacheTableData,
            BaseReferences<
              _$AppDatabase,
              $DailyContentCacheTableTable,
              DailyContentCacheTableData
            >,
          ),
          DailyContentCacheTableData,
          PrefetchHooks Function()
        > {
  $$DailyContentCacheTableTableTableManager(
    _$AppDatabase db,
    $DailyContentCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyContentCacheTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DailyContentCacheTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyContentCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<DateTime> resolvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyContentCacheTableCompanion(
                date: date,
                contentId: contentId,
                resolvedAt: resolvedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                required String contentId,
                required DateTime resolvedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyContentCacheTableCompanion.insert(
                date: date,
                contentId: contentId,
                resolvedAt: resolvedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyContentCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyContentCacheTableTable,
      DailyContentCacheTableData,
      $$DailyContentCacheTableTableFilterComposer,
      $$DailyContentCacheTableTableOrderingComposer,
      $$DailyContentCacheTableTableAnnotationComposer,
      $$DailyContentCacheTableTableCreateCompanionBuilder,
      $$DailyContentCacheTableTableUpdateCompanionBuilder,
      (
        DailyContentCacheTableData,
        BaseReferences<
          _$AppDatabase,
          $DailyContentCacheTableTable,
          DailyContentCacheTableData
        >,
      ),
      DailyContentCacheTableData,
      PrefetchHooks Function()
    >;
typedef $$DailyContentShownLogTableTableCreateCompanionBuilder =
    DailyContentShownLogTableCompanion Function({
      Value<int> id,
      required String contentId,
      required String shownDate,
    });
typedef $$DailyContentShownLogTableTableUpdateCompanionBuilder =
    DailyContentShownLogTableCompanion Function({
      Value<int> id,
      Value<String> contentId,
      Value<String> shownDate,
    });

class $$DailyContentShownLogTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyContentShownLogTableTable> {
  $$DailyContentShownLogTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shownDate => $composableBuilder(
    column: $table.shownDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyContentShownLogTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyContentShownLogTableTable> {
  $$DailyContentShownLogTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shownDate => $composableBuilder(
    column: $table.shownDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyContentShownLogTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyContentShownLogTableTable> {
  $$DailyContentShownLogTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get shownDate =>
      $composableBuilder(column: $table.shownDate, builder: (column) => column);
}

class $$DailyContentShownLogTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyContentShownLogTableTable,
          DailyContentShownLogTableData,
          $$DailyContentShownLogTableTableFilterComposer,
          $$DailyContentShownLogTableTableOrderingComposer,
          $$DailyContentShownLogTableTableAnnotationComposer,
          $$DailyContentShownLogTableTableCreateCompanionBuilder,
          $$DailyContentShownLogTableTableUpdateCompanionBuilder,
          (
            DailyContentShownLogTableData,
            BaseReferences<
              _$AppDatabase,
              $DailyContentShownLogTableTable,
              DailyContentShownLogTableData
            >,
          ),
          DailyContentShownLogTableData,
          PrefetchHooks Function()
        > {
  $$DailyContentShownLogTableTableTableManager(
    _$AppDatabase db,
    $DailyContentShownLogTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyContentShownLogTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DailyContentShownLogTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyContentShownLogTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String> shownDate = const Value.absent(),
              }) => DailyContentShownLogTableCompanion(
                id: id,
                contentId: contentId,
                shownDate: shownDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentId,
                required String shownDate,
              }) => DailyContentShownLogTableCompanion.insert(
                id: id,
                contentId: contentId,
                shownDate: shownDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyContentShownLogTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyContentShownLogTableTable,
      DailyContentShownLogTableData,
      $$DailyContentShownLogTableTableFilterComposer,
      $$DailyContentShownLogTableTableOrderingComposer,
      $$DailyContentShownLogTableTableAnnotationComposer,
      $$DailyContentShownLogTableTableCreateCompanionBuilder,
      $$DailyContentShownLogTableTableUpdateCompanionBuilder,
      (
        DailyContentShownLogTableData,
        BaseReferences<
          _$AppDatabase,
          $DailyContentShownLogTableTable,
          DailyContentShownLogTableData
        >,
      ),
      DailyContentShownLogTableData,
      PrefetchHooks Function()
    >;
typedef $$FavoriteDailyContentTableTableCreateCompanionBuilder =
    FavoriteDailyContentTableCompanion Function({
      required String contentId,
      required DateTime favoritedAt,
      Value<int> rowid,
    });
typedef $$FavoriteDailyContentTableTableUpdateCompanionBuilder =
    FavoriteDailyContentTableCompanion Function({
      Value<String> contentId,
      Value<DateTime> favoritedAt,
      Value<int> rowid,
    });

class $$FavoriteDailyContentTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteDailyContentTableTable> {
  $$FavoriteDailyContentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get favoritedAt => $composableBuilder(
    column: $table.favoritedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteDailyContentTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteDailyContentTableTable> {
  $$FavoriteDailyContentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get favoritedAt => $composableBuilder(
    column: $table.favoritedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteDailyContentTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteDailyContentTableTable> {
  $$FavoriteDailyContentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<DateTime> get favoritedAt => $composableBuilder(
    column: $table.favoritedAt,
    builder: (column) => column,
  );
}

class $$FavoriteDailyContentTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteDailyContentTableTable,
          FavoriteDailyContentTableData,
          $$FavoriteDailyContentTableTableFilterComposer,
          $$FavoriteDailyContentTableTableOrderingComposer,
          $$FavoriteDailyContentTableTableAnnotationComposer,
          $$FavoriteDailyContentTableTableCreateCompanionBuilder,
          $$FavoriteDailyContentTableTableUpdateCompanionBuilder,
          (
            FavoriteDailyContentTableData,
            BaseReferences<
              _$AppDatabase,
              $FavoriteDailyContentTableTable,
              FavoriteDailyContentTableData
            >,
          ),
          FavoriteDailyContentTableData,
          PrefetchHooks Function()
        > {
  $$FavoriteDailyContentTableTableTableManager(
    _$AppDatabase db,
    $FavoriteDailyContentTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteDailyContentTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FavoriteDailyContentTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FavoriteDailyContentTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> contentId = const Value.absent(),
                Value<DateTime> favoritedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteDailyContentTableCompanion(
                contentId: contentId,
                favoritedAt: favoritedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String contentId,
                required DateTime favoritedAt,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteDailyContentTableCompanion.insert(
                contentId: contentId,
                favoritedAt: favoritedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteDailyContentTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteDailyContentTableTable,
      FavoriteDailyContentTableData,
      $$FavoriteDailyContentTableTableFilterComposer,
      $$FavoriteDailyContentTableTableOrderingComposer,
      $$FavoriteDailyContentTableTableAnnotationComposer,
      $$FavoriteDailyContentTableTableCreateCompanionBuilder,
      $$FavoriteDailyContentTableTableUpdateCompanionBuilder,
      (
        FavoriteDailyContentTableData,
        BaseReferences<
          _$AppDatabase,
          $FavoriteDailyContentTableTable,
          FavoriteDailyContentTableData
        >,
      ),
      FavoriteDailyContentTableData,
      PrefetchHooks Function()
    >;
typedef $$AppMetadataTableTableCreateCompanionBuilder =
    AppMetadataTableCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppMetadataTableTableUpdateCompanionBuilder =
    AppMetadataTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetadataTableTable> {
  $$AppMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetadataTableTable> {
  $$AppMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetadataTableTable> {
  $$AppMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetadataTableTable,
          AppMetadataTableData,
          $$AppMetadataTableTableFilterComposer,
          $$AppMetadataTableTableOrderingComposer,
          $$AppMetadataTableTableAnnotationComposer,
          $$AppMetadataTableTableCreateCompanionBuilder,
          $$AppMetadataTableTableUpdateCompanionBuilder,
          (
            AppMetadataTableData,
            BaseReferences<
              _$AppDatabase,
              $AppMetadataTableTable,
              AppMetadataTableData
            >,
          ),
          AppMetadataTableData,
          PrefetchHooks Function()
        > {
  $$AppMetadataTableTableTableManager(
    _$AppDatabase db,
    $AppMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetadataTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataTableCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetadataTableTable,
      AppMetadataTableData,
      $$AppMetadataTableTableFilterComposer,
      $$AppMetadataTableTableOrderingComposer,
      $$AppMetadataTableTableAnnotationComposer,
      $$AppMetadataTableTableCreateCompanionBuilder,
      $$AppMetadataTableTableUpdateCompanionBuilder,
      (
        AppMetadataTableData,
        BaseReferences<
          _$AppDatabase,
          $AppMetadataTableTable,
          AppMetadataTableData
        >,
      ),
      AppMetadataTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PrayerLogsTableTableTableManager get prayerLogsTable =>
      $$PrayerLogsTableTableTableManager(_db, _db.prayerLogsTable);
  $$BatteryOptStateTableTableTableManager get batteryOptStateTable =>
      $$BatteryOptStateTableTableTableManager(_db, _db.batteryOptStateTable);
  $$DailyContentCacheTableTableTableManager get dailyContentCacheTable =>
      $$DailyContentCacheTableTableTableManager(
        _db,
        _db.dailyContentCacheTable,
      );
  $$DailyContentShownLogTableTableTableManager get dailyContentShownLogTable =>
      $$DailyContentShownLogTableTableTableManager(
        _db,
        _db.dailyContentShownLogTable,
      );
  $$FavoriteDailyContentTableTableTableManager get favoriteDailyContentTable =>
      $$FavoriteDailyContentTableTableTableManager(
        _db,
        _db.favoriteDailyContentTable,
      );
  $$AppMetadataTableTableTableManager get appMetadataTable =>
      $$AppMetadataTableTableTableManager(_db, _db.appMetadataTable);
}
