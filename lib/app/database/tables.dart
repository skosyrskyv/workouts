// ignore_for_file: recursive_getters, non_constant_identifier_names

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:workouts/app/database/enums.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_set.dart';
import 'package:workouts/app/database/models/exercise_type.dart';
import 'package:workouts/app/database/models/workout.dart';

const _uuid = Uuid();

//
//  EXERCISE TYPE
//
@UseRowClass(ExerciseType, constructor: 'fromDB')
class ExerciseTypes extends Table {
  TextColumn get key => text()();
  TextColumn get type => textEnum<ExerciseGroup>()();
  TextColumn get muscleGroup => textEnum<MuscleGroup>()();
  TextColumn get muscles => text().nullable()();
  TextColumn get name => text()();
  TextColumn get nameRu => text().nullable()();
  BoolColumn get repeatsProp => boolean()();
  BoolColumn get weightProp => boolean()();
  BoolColumn get durationProp => boolean()();

  @override
  Set<Column> get primaryKey => {key};
}

//
// EXERCISE
//
@UseRowClass(Exercise)
class Exercises extends Table {
  TextColumn get uuid => text().clientDefault(() => _uuid.v1())();
  IntColumn get number => integer()();
  TextColumn get type => text().references(ExerciseTypes, #key)();
  TextColumn get workout => text().references(Workouts, #uuid)();
  DateTimeColumn get created => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get start => dateTime().nullable()();
  DateTimeColumn get finish => dateTime().nullable()();
  RealColumn get duration => real().nullable()();
  @override
  Set<Column> get primaryKey => {uuid};
}

//
// EXERCISE SET
//
@UseRowClass(ExerciseSet)
class ExerciseSets extends Table {
  TextColumn get uuid => text().clientDefault(() => _uuid.v1())();
  IntColumn get number => integer().check(number.isBiggerThanValue(0))();
  TextColumn get exercise => text().references(Exercises, #uuid)();
  TextColumn get workout => text().references(Workouts, #uuid)();
  DateTimeColumn get created => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get start => dateTime().nullable()();
  DateTimeColumn get finish => dateTime().nullable()();
  RealColumn get duration => real().nullable()();
  IntColumn get repeats => integer().nullable()();
  RealColumn get weight => real().nullable()();

  @override
  Set<Column> get primaryKey => {uuid};
}

//
// WORKOUT
//
@UseRowClass(Workout)
class Workouts extends Table {
  TextColumn get uuid => text().clientDefault(() => _uuid.v1())();
  TextColumn get name => text().nullable()();
  DateTimeColumn get created => dateTime()();
  DateTimeColumn get start => dateTime().nullable()();
  DateTimeColumn get finish => dateTime().nullable()();
  RealColumn get duration => real().nullable()();

  @override
  Set<Column> get primaryKey => {uuid};
}
