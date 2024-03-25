import 'dart:io';

import 'package:dart_date/dart_date.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:uuid/uuid.dart';
import 'package:workouts/app/database/enums.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_set.dart';
import 'package:workouts/app/database/models/exercise_type.dart';
import 'package:workouts/app/database/models/workout.dart';
import 'package:workouts/app/database/tables.dart';
import 'package:workouts/extensions/iterable_extension.dart';
part 'database.g.dart';

const _uuid = Uuid();

@DriftDatabase(tables: [ExerciseTypes, Exercises, ExerciseSets, Workouts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Stream<List<Workout>> watchAllWorkouts() {
    return select(workouts).watch();
  }

  Stream<List<Workout>> watchWorkouts({required DateTime date}) {
    return (select(workouts)
          ..where((workout) {
            return workout.created.month.equals(date.toUTC.month) & workout.created.year.equals(date.toUTC.year) & workout.created.day.equals(date.toUTC.day);
          }))
        .watch();
  }

  Future deleteWorkout({required String uuid}) async {
    return transaction(() async {
      await (delete(workouts)..where((workout) => workout.uuid.equals(uuid))).go();
      await (delete(exercises)..where((exercise) => exercise.workout.equals(uuid))).go();
      await (delete(exerciseSets)..where((set) => set.workout.equals(uuid))).go();
    });
  }

  Future deleteExercise({required String exerciseUuid, required String workoutUuid}) async {
    return transaction(() async {
      await (delete(exercises)..where((exercise) => exercise.uuid.equals(exerciseUuid))).go();
      await (delete(exerciseSets)..where((set) => set.exercise.equals(exerciseUuid))).go();
      await _recalculateExerciseNumbers(workoutUuid);
    });
  }

  Future<void> updateExercisesOrder(List<Exercise> reorderExercises) async {
    reorderExercises.mapWithIndex(
      (exercise, index) async {
        await into(exercises).insertOnConflictUpdate(exercise.copyWith(number: index + 1));
      },
    ).toList();
  }

  Future<void> _recalculateExerciseNumbers(String uuid) async {
    final results = await (select(exercises)
          ..where((exercise) => exercise.workout.equals(uuid))
          ..orderBy([(exercise) => OrderingTerm.asc(exercise.number)]))
        .get();
    for (int i = 0; i < results.length; i++) {
      await into(exercises).insertOnConflictUpdate(results[i].copyWith(number: i + 1));
    }
  }

  Future addExerciseSet({required ExerciseSet newSet}) async {
    return into(exerciseSets).insert(newSet);
  }

  Future removeExerciseSet({required String setUuid, required String exerciseUuid}) async {
    return transaction(
      () async {
        await (delete(exerciseSets)..where((set) => set.uuid.equals(setUuid))).go();
        await _recalculateSetsNumbers(exerciseUuid);
      },
    );
  }

  Future _recalculateSetsNumbers(String uuid) async {
    final sets = await (select(exerciseSets)
          ..where((set) => set.exercise.equals(uuid))
          ..orderBy([(set) => OrderingTerm.asc(set.number)]))
        .get();
    final updatedSets = sets.mapWithIndex((set, index) => set.copyWith(number: index + 1)).toList();
    for (final set in updatedSets) {
      await into(exerciseSets).insertOnConflictUpdate(set);
    }
  }

  Future updateSetWeight({required String uuid, required double? weight}) async {
    return (update(exerciseSets)..where((set) => set.uuid.equals(uuid))).write(
      ExerciseSetsCompanion(
        weight: Value(weight),
      ),
    );
  }

  Future updateSetRepeats({required String uuid, required int? repeats}) async {
    return (update(exerciseSets)..where((set) => set.uuid.equals(uuid))).write(
      ExerciseSetsCompanion(
        repeats: Value(repeats),
      ),
    );
  }

  Future updateSetDuration({required String uuid, required int duration}) async {
    return (update(exerciseSets)..where((set) => set.uuid.equals(uuid))).write(
      ExerciseSetsCompanion(
        duration: Value(duration.toDouble()),
      ),
    );
  }

  Future<Workout?> getWorkout({required String uuid}) async {
    return (select(workouts)..where((workout) => workout.uuid.equals(uuid))).getSingleOrNull();
  }

  /// workout uuid
  Stream<Workout?> watchWorkout({required String uuid}) {
    return (select(workouts)..where((workout) => workout.uuid.equals(uuid))).watchSingleOrNull();
  }

  /// workout uuid
  Stream<List<Exercise>> watchExercisesWithType({required String uuid}) {
    try {
      final rows = (select(exercises)
            ..where((exercise) => exercise.workout.equals(uuid))
            ..orderBy([(exercise) => OrderingTerm.asc(exercise.number)]))
          .join([
        leftOuterJoin(exerciseTypes, exerciseTypes.key.equalsExp(exercises.type)),
      ]).watch();
      return rows.map((row) => row.map((e) {
            final a = e.readTable(exercises);
            final b = e.readTable(exerciseTypes);
            return a.copyWith(typeModel: b);
          }).toList());
    } catch (e) {}
    throw Exception();
  }

  /// exercise uuid
  Stream<List<ExerciseSet>> watchSets({required String uuid}) {
    return (select(exerciseSets)..where((set) => set.exercise.equals(uuid))).watch();
  }

  Future<void> createWorkout({required Workout workout}) async {
    into(workouts).insert(workout);
  }

  Future<void> createExercises({required Iterable<Exercise> newExercises}) async {
    await batch((batch) {
      final sets = newExercises
          .map(
            (exercise) => ExerciseSet.create(
              number: 1,
              exercise: exercise.uuid,
              workout: exercise.workout,
              duration: exercise.typeModel!.durationProp ? 0 : null,
              weight: exercise.typeModel!.weightProp ? 0 : null,
              repeats: exercise.typeModel!.repeatsProp ? 0 : null,
            ),
          )
          .toList();
      batch.insertAll(exercises, newExercises);
      batch.insertAll(exerciseSets, sets);
      _recalculateExerciseNumbers(newExercises.first.workout);
    });
  }

  Future<List<ExerciseType>> getAllExerciseTypes() {
    return (select(exerciseTypes)..orderBy([(t) => OrderingTerm(expression: t.type, mode: OrderingMode.desc), (t) => OrderingTerm(expression: t.muscleGroup)]))
        .get();
  }

  Future<List<ExerciseSet>> getExerciseSets({required String exerciseUuid}) {
    return (select(exerciseSets)
          ..where((set) => set.exercise.equals(exerciseUuid))
          ..orderBy([(set) => OrderingTerm(expression: set.number)]))
        .get();
  }

  Future<List<ExerciseType>> searchExerciseTypes({required String pattern}) {
    return (select(exerciseTypes)
          ..where((item) => Expression.or([item.name.like("%$pattern%"), item.nameRu.like("%$pattern%")]))
          ..orderBy([(t) => OrderingTerm(expression: t.type, mode: OrderingMode.desc), (t) => OrderingTerm(expression: t.muscleGroup)]))
        .get();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    print(file);
    if (!await file.exists()) {
      // Extract the pre-populated database file from assets
      final blob = await rootBundle.load('assets/files/database.sqlite');
      final buffer = blob.buffer;
      await file.writeAsBytes(buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
    }

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // // Make sqlite3 pick a more suitable location for temporary files - the
    // // one from the system may be inaccessible due to sandboxing.
    // final cachebase = (await getTemporaryDirectory()).path;
    // // We can't access /tmp on Android, which sqlite3 would try by default.
    // // Explicitly tell it about the correct temporary directory.
    // sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
