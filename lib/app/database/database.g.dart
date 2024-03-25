// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExerciseTypesTable extends ExerciseTypes
    with TableInfo<$ExerciseTypesTable, ExerciseType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseGroup, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ExerciseGroup>($ExerciseTypesTable.$convertertype);
  static const VerificationMeta _muscleGroupMeta =
      const VerificationMeta('muscleGroup');
  @override
  late final GeneratedColumnWithTypeConverter<MuscleGroup, String> muscleGroup =
      GeneratedColumn<String>('muscle_group', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MuscleGroup>(
              $ExerciseTypesTable.$convertermuscleGroup);
  static const VerificationMeta _musclesMeta =
      const VerificationMeta('muscles');
  @override
  late final GeneratedColumn<String> muscles = GeneratedColumn<String>(
      'muscles', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameRuMeta = const VerificationMeta('nameRu');
  @override
  late final GeneratedColumn<String> nameRu = GeneratedColumn<String>(
      'name_ru', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _repeatsPropMeta =
      const VerificationMeta('repeatsProp');
  @override
  late final GeneratedColumn<bool> repeatsProp = GeneratedColumn<bool>(
      'repeats_prop', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("repeats_prop" IN (0, 1))'));
  static const VerificationMeta _weightPropMeta =
      const VerificationMeta('weightProp');
  @override
  late final GeneratedColumn<bool> weightProp = GeneratedColumn<bool>(
      'weight_prop', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("weight_prop" IN (0, 1))'));
  static const VerificationMeta _durationPropMeta =
      const VerificationMeta('durationProp');
  @override
  late final GeneratedColumn<bool> durationProp = GeneratedColumn<bool>(
      'duration_prop', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("duration_prop" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        key,
        type,
        muscleGroup,
        muscles,
        name,
        nameRu,
        repeatsProp,
        weightProp,
        durationProp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_types';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_muscleGroupMeta, const VerificationResult.success());
    if (data.containsKey('muscles')) {
      context.handle(_musclesMeta,
          muscles.isAcceptableOrUnknown(data['muscles']!, _musclesMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_ru')) {
      context.handle(_nameRuMeta,
          nameRu.isAcceptableOrUnknown(data['name_ru']!, _nameRuMeta));
    }
    if (data.containsKey('repeats_prop')) {
      context.handle(
          _repeatsPropMeta,
          repeatsProp.isAcceptableOrUnknown(
              data['repeats_prop']!, _repeatsPropMeta));
    } else if (isInserting) {
      context.missing(_repeatsPropMeta);
    }
    if (data.containsKey('weight_prop')) {
      context.handle(
          _weightPropMeta,
          weightProp.isAcceptableOrUnknown(
              data['weight_prop']!, _weightPropMeta));
    } else if (isInserting) {
      context.missing(_weightPropMeta);
    }
    if (data.containsKey('duration_prop')) {
      context.handle(
          _durationPropMeta,
          durationProp.isAcceptableOrUnknown(
              data['duration_prop']!, _durationPropMeta));
    } else if (isInserting) {
      context.missing(_durationPropMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  ExerciseType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseType.fromDB(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      type: $ExerciseTypesTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      muscleGroup: $ExerciseTypesTable.$convertermuscleGroup.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}muscle_group'])!),
      muscles: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}muscles']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      nameRu: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ru']),
      repeatsProp: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}repeats_prop'])!,
      weightProp: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}weight_prop'])!,
      durationProp: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}duration_prop'])!,
    );
  }

  @override
  $ExerciseTypesTable createAlias(String alias) {
    return $ExerciseTypesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExerciseGroup, String, String> $convertertype =
      const EnumNameConverter<ExerciseGroup>(ExerciseGroup.values);
  static JsonTypeConverter2<MuscleGroup, String, String> $convertermuscleGroup =
      const EnumNameConverter<MuscleGroup>(MuscleGroup.values);
}

class ExerciseTypesCompanion extends UpdateCompanion<ExerciseType> {
  final Value<String> key;
  final Value<ExerciseGroup> type;
  final Value<MuscleGroup> muscleGroup;
  final Value<String?> muscles;
  final Value<String> name;
  final Value<String?> nameRu;
  final Value<bool> repeatsProp;
  final Value<bool> weightProp;
  final Value<bool> durationProp;
  final Value<int> rowid;
  const ExerciseTypesCompanion({
    this.key = const Value.absent(),
    this.type = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.muscles = const Value.absent(),
    this.name = const Value.absent(),
    this.nameRu = const Value.absent(),
    this.repeatsProp = const Value.absent(),
    this.weightProp = const Value.absent(),
    this.durationProp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseTypesCompanion.insert({
    required String key,
    required ExerciseGroup type,
    required MuscleGroup muscleGroup,
    this.muscles = const Value.absent(),
    required String name,
    this.nameRu = const Value.absent(),
    required bool repeatsProp,
    required bool weightProp,
    required bool durationProp,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        type = Value(type),
        muscleGroup = Value(muscleGroup),
        name = Value(name),
        repeatsProp = Value(repeatsProp),
        weightProp = Value(weightProp),
        durationProp = Value(durationProp);
  static Insertable<ExerciseType> custom({
    Expression<String>? key,
    Expression<String>? type,
    Expression<String>? muscleGroup,
    Expression<String>? muscles,
    Expression<String>? name,
    Expression<String>? nameRu,
    Expression<bool>? repeatsProp,
    Expression<bool>? weightProp,
    Expression<bool>? durationProp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (type != null) 'type': type,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (muscles != null) 'muscles': muscles,
      if (name != null) 'name': name,
      if (nameRu != null) 'name_ru': nameRu,
      if (repeatsProp != null) 'repeats_prop': repeatsProp,
      if (weightProp != null) 'weight_prop': weightProp,
      if (durationProp != null) 'duration_prop': durationProp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseTypesCompanion copyWith(
      {Value<String>? key,
      Value<ExerciseGroup>? type,
      Value<MuscleGroup>? muscleGroup,
      Value<String?>? muscles,
      Value<String>? name,
      Value<String?>? nameRu,
      Value<bool>? repeatsProp,
      Value<bool>? weightProp,
      Value<bool>? durationProp,
      Value<int>? rowid}) {
    return ExerciseTypesCompanion(
      key: key ?? this.key,
      type: type ?? this.type,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      muscles: muscles ?? this.muscles,
      name: name ?? this.name,
      nameRu: nameRu ?? this.nameRu,
      repeatsProp: repeatsProp ?? this.repeatsProp,
      weightProp: weightProp ?? this.weightProp,
      durationProp: durationProp ?? this.durationProp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $ExerciseTypesTable.$convertertype.toSql(type.value));
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(
          $ExerciseTypesTable.$convertermuscleGroup.toSql(muscleGroup.value));
    }
    if (muscles.present) {
      map['muscles'] = Variable<String>(muscles.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameRu.present) {
      map['name_ru'] = Variable<String>(nameRu.value);
    }
    if (repeatsProp.present) {
      map['repeats_prop'] = Variable<bool>(repeatsProp.value);
    }
    if (weightProp.present) {
      map['weight_prop'] = Variable<bool>(weightProp.value);
    }
    if (durationProp.present) {
      map['duration_prop'] = Variable<bool>(durationProp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTypesCompanion(')
          ..write('key: $key, ')
          ..write('type: $type, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('muscles: $muscles, ')
          ..write('name: $name, ')
          ..write('nameRu: $nameRu, ')
          ..write('repeatsProp: $repeatsProp, ')
          ..write('weightProp: $weightProp, ')
          ..write('durationProp: $durationProp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v1());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
      'start', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _finishMeta = const VerificationMeta('finish');
  @override
  late final GeneratedColumn<DateTime> finish = GeneratedColumn<DateTime>(
      'finish', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<double> duration = GeneratedColumn<double>(
      'duration', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, name, created, start, finish, duration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<Workout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    }
    if (data.containsKey('finish')) {
      context.handle(_finishMeta,
          finish.isAcceptableOrUnknown(data['finish']!, _finishMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      start: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start']),
      finish: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}finish']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}duration']),
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<String> uuid;
  final Value<String?> name;
  final Value<DateTime> created;
  final Value<DateTime?> start;
  final Value<DateTime?> finish;
  final Value<double?> duration;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.created = const Value.absent(),
    this.start = const Value.absent(),
    this.finish = const Value.absent(),
    this.duration = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    required DateTime created,
    this.start = const Value.absent(),
    this.finish = const Value.absent(),
    this.duration = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : created = Value(created);
  static Insertable<Workout> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<DateTime>? created,
    Expression<DateTime>? start,
    Expression<DateTime>? finish,
    Expression<double>? duration,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (created != null) 'created': created,
      if (start != null) 'start': start,
      if (finish != null) 'finish': finish,
      if (duration != null) 'duration': duration,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<String>? uuid,
      Value<String?>? name,
      Value<DateTime>? created,
      Value<DateTime?>? start,
      Value<DateTime?>? finish,
      Value<double?>? duration,
      Value<int>? rowid}) {
    return WorkoutsCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      created: created ?? this.created,
      start: start ?? this.start,
      finish: finish ?? this.finish,
      duration: duration ?? this.duration,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (finish.present) {
      map['finish'] = Variable<DateTime>(finish.value);
    }
    if (duration.present) {
      map['duration'] = Variable<double>(duration.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('created: $created, ')
          ..write('start: $start, ')
          ..write('finish: $finish, ')
          ..write('duration: $duration, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v1());
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercise_types ("key")'));
  static const VerificationMeta _workoutMeta =
      const VerificationMeta('workout');
  @override
  late final GeneratedColumn<String> workout = GeneratedColumn<String>(
      'workout', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workouts (uuid)'));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
      'start', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _finishMeta = const VerificationMeta('finish');
  @override
  late final GeneratedColumn<DateTime> finish = GeneratedColumn<DateTime>(
      'finish', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<double> duration = GeneratedColumn<double>(
      'duration', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, number, type, workout, created, start, finish, duration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('workout')) {
      context.handle(_workoutMeta,
          workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta));
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    }
    if (data.containsKey('finish')) {
      context.handle(_finishMeta,
          finish.isAcceptableOrUnknown(data['finish']!, _finishMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      workout: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workout'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      start: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start']),
      finish: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}finish']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}duration']),
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> uuid;
  final Value<int> number;
  final Value<String> type;
  final Value<String> workout;
  final Value<DateTime> created;
  final Value<DateTime?> start;
  final Value<DateTime?> finish;
  final Value<double?> duration;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.uuid = const Value.absent(),
    this.number = const Value.absent(),
    this.type = const Value.absent(),
    this.workout = const Value.absent(),
    this.created = const Value.absent(),
    this.start = const Value.absent(),
    this.finish = const Value.absent(),
    this.duration = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.uuid = const Value.absent(),
    required int number,
    required String type,
    required String workout,
    this.created = const Value.absent(),
    this.start = const Value.absent(),
    this.finish = const Value.absent(),
    this.duration = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : number = Value(number),
        type = Value(type),
        workout = Value(workout);
  static Insertable<Exercise> custom({
    Expression<String>? uuid,
    Expression<int>? number,
    Expression<String>? type,
    Expression<String>? workout,
    Expression<DateTime>? created,
    Expression<DateTime>? start,
    Expression<DateTime>? finish,
    Expression<double>? duration,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (number != null) 'number': number,
      if (type != null) 'type': type,
      if (workout != null) 'workout': workout,
      if (created != null) 'created': created,
      if (start != null) 'start': start,
      if (finish != null) 'finish': finish,
      if (duration != null) 'duration': duration,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith(
      {Value<String>? uuid,
      Value<int>? number,
      Value<String>? type,
      Value<String>? workout,
      Value<DateTime>? created,
      Value<DateTime?>? start,
      Value<DateTime?>? finish,
      Value<double?>? duration,
      Value<int>? rowid}) {
    return ExercisesCompanion(
      uuid: uuid ?? this.uuid,
      number: number ?? this.number,
      type: type ?? this.type,
      workout: workout ?? this.workout,
      created: created ?? this.created,
      start: start ?? this.start,
      finish: finish ?? this.finish,
      duration: duration ?? this.duration,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (workout.present) {
      map['workout'] = Variable<String>(workout.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (finish.present) {
      map['finish'] = Variable<DateTime>(finish.value);
    }
    if (duration.present) {
      map['duration'] = Variable<double>(duration.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('uuid: $uuid, ')
          ..write('number: $number, ')
          ..write('type: $type, ')
          ..write('workout: $workout, ')
          ..write('created: $created, ')
          ..write('start: $start, ')
          ..write('finish: $finish, ')
          ..write('duration: $duration, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetsTable extends ExerciseSets
    with TableInfo<$ExerciseSetsTable, ExerciseSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => _uuid.v1());
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      check: () => number.isBiggerThanValue(0),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _exerciseMeta =
      const VerificationMeta('exercise');
  @override
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
      'exercise', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (uuid)'));
  static const VerificationMeta _workoutMeta =
      const VerificationMeta('workout');
  @override
  late final GeneratedColumn<String> workout = GeneratedColumn<String>(
      'workout', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workouts (uuid)'));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
      'created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
      'start', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _finishMeta = const VerificationMeta('finish');
  @override
  late final GeneratedColumn<DateTime> finish = GeneratedColumn<DateTime>(
      'finish', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<double> duration = GeneratedColumn<double>(
      'duration', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _repeatsMeta =
      const VerificationMeta('repeats');
  @override
  late final GeneratedColumn<int> repeats = GeneratedColumn<int>(
      'repeats', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        number,
        exercise,
        workout,
        created,
        start,
        finish,
        duration,
        repeats,
        weight
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_sets';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('exercise')) {
      context.handle(_exerciseMeta,
          exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta));
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('workout')) {
      context.handle(_workoutMeta,
          workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta));
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    }
    if (data.containsKey('finish')) {
      context.handle(_finishMeta,
          finish.isAcceptableOrUnknown(data['finish']!, _finishMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('repeats')) {
      context.handle(_repeatsMeta,
          repeats.isAcceptableOrUnknown(data['repeats']!, _repeatsMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  ExerciseSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSet(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      exercise: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise'])!,
      workout: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workout'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      start: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start']),
      finish: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}finish']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}duration']),
      repeats: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repeats']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
    );
  }

  @override
  $ExerciseSetsTable createAlias(String alias) {
    return $ExerciseSetsTable(attachedDatabase, alias);
  }
}

class ExerciseSetsCompanion extends UpdateCompanion<ExerciseSet> {
  final Value<String> uuid;
  final Value<int> number;
  final Value<String> exercise;
  final Value<String> workout;
  final Value<DateTime> created;
  final Value<DateTime?> start;
  final Value<DateTime?> finish;
  final Value<double?> duration;
  final Value<int?> repeats;
  final Value<double?> weight;
  final Value<int> rowid;
  const ExerciseSetsCompanion({
    this.uuid = const Value.absent(),
    this.number = const Value.absent(),
    this.exercise = const Value.absent(),
    this.workout = const Value.absent(),
    this.created = const Value.absent(),
    this.start = const Value.absent(),
    this.finish = const Value.absent(),
    this.duration = const Value.absent(),
    this.repeats = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetsCompanion.insert({
    this.uuid = const Value.absent(),
    required int number,
    required String exercise,
    required String workout,
    this.created = const Value.absent(),
    this.start = const Value.absent(),
    this.finish = const Value.absent(),
    this.duration = const Value.absent(),
    this.repeats = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : number = Value(number),
        exercise = Value(exercise),
        workout = Value(workout);
  static Insertable<ExerciseSet> custom({
    Expression<String>? uuid,
    Expression<int>? number,
    Expression<String>? exercise,
    Expression<String>? workout,
    Expression<DateTime>? created,
    Expression<DateTime>? start,
    Expression<DateTime>? finish,
    Expression<double>? duration,
    Expression<int>? repeats,
    Expression<double>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (number != null) 'number': number,
      if (exercise != null) 'exercise': exercise,
      if (workout != null) 'workout': workout,
      if (created != null) 'created': created,
      if (start != null) 'start': start,
      if (finish != null) 'finish': finish,
      if (duration != null) 'duration': duration,
      if (repeats != null) 'repeats': repeats,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetsCompanion copyWith(
      {Value<String>? uuid,
      Value<int>? number,
      Value<String>? exercise,
      Value<String>? workout,
      Value<DateTime>? created,
      Value<DateTime?>? start,
      Value<DateTime?>? finish,
      Value<double?>? duration,
      Value<int?>? repeats,
      Value<double?>? weight,
      Value<int>? rowid}) {
    return ExerciseSetsCompanion(
      uuid: uuid ?? this.uuid,
      number: number ?? this.number,
      exercise: exercise ?? this.exercise,
      workout: workout ?? this.workout,
      created: created ?? this.created,
      start: start ?? this.start,
      finish: finish ?? this.finish,
      duration: duration ?? this.duration,
      repeats: repeats ?? this.repeats,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (workout.present) {
      map['workout'] = Variable<String>(workout.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (finish.present) {
      map['finish'] = Variable<DateTime>(finish.value);
    }
    if (duration.present) {
      map['duration'] = Variable<double>(duration.value);
    }
    if (repeats.present) {
      map['repeats'] = Variable<int>(repeats.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('number: $number, ')
          ..write('exercise: $exercise, ')
          ..write('workout: $workout, ')
          ..write('created: $created, ')
          ..write('start: $start, ')
          ..write('finish: $finish, ')
          ..write('duration: $duration, ')
          ..write('repeats: $repeats, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ExerciseTypesTable exerciseTypes = $ExerciseTypesTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseSetsTable exerciseSets = $ExerciseSetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exerciseTypes, workouts, exercises, exerciseSets];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
