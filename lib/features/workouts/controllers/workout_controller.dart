import 'package:flutter/material.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_type.dart';
import 'package:workouts/app/database/models/workout.dart';
import 'package:workouts/extensions/iterable_extension.dart';

class WorkoutController extends ChangeNotifier {
  final String? workoutUuid;
  final DateTime date;
  final AppDatabase database;
  WorkoutController({
    this.workoutUuid,
    required this.date,
    required this.database,
  }) {
    _init();
  }

  bool loading = false;
  String? error;
  late Workout workout;
  List<Exercise> exercises = [];

  Future<void> _init() async {
    workout = Workout.create(date: date);
    if (workoutUuid == null) {
      await database.createWorkout(workout: workout);
    }
    database.watchWorkout(uuid: workoutUuid ?? workout.uuid).listen(_workoutUpdatesListener);
    database.watchExercisesWithType(uuid: workoutUuid ?? workout.uuid).listen(_exercisesUpdatesListener);
  }

  void _workoutUpdatesListener(Workout? data) {
    if (data != workout && data != null) {
      workout = data;
      notifyListeners();
    }
  }

  void _exercisesUpdatesListener(List<Exercise>? data) {
    if (data != exercises && data != null) {
      exercises = data;
      notifyListeners();
    }
  }

  Future<void> updateExerciseNumber(int index, int newIndex) async {
    if (index == newIndex) return;
    final exercise = exercises[index];
    exercises.insert(newIndex, exercise);
    if (index < newIndex) {
      exercises.removeAt(index);
    } else {
      exercises.removeAt(index + 1);
    }
    notifyListeners();
    try {
      await database.updateExercisesOrder(exercises);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteExercise(String uuid) async {
    try {
      await database.deleteExercise(exerciseUuid: uuid, workoutUuid: workout.uuid);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteWorkout() async {
    try {
      await database.deleteWorkout(uuid: workout.uuid);
      appRouter.popUntilRoot();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addExercise(Set<ExerciseType>? exercisesTypes) async {
    try {
      if (exercisesTypes != null) {
        final exercises =
            exercisesTypes.mapWithIndex((type, index) => Exercise.create(workout: workout.uuid, type: type.key, number: index + 1, typeModel: type)).toList();
        await database.createExercises(newExercises: exercises);
      }
    } catch (e) {
      print(e);
    }
  }
}
