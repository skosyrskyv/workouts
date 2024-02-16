import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_set.dart';

class ExerciseSheetController extends ChangeNotifier {
  final AppDatabase database;

  ExerciseSheetController({required Exercise initExercise, required this.database}) {
    current = initExercise;
    init();
  }

  final DraggableScrollableController scrollableController = DraggableScrollableController();
  final FocusScopeNode node = FocusScopeNode();
  late bool showKeyboard;

  late StreamSubscription<List<Exercise>> exercisesSubscription;
  late StreamSubscription<List<ExerciseSet>> setsSubscription;

  /// All workout exercises
  List<Exercise> exercises = [];

  /// Current selected exercise
  late Exercise current;

  /// All sets of current exercise
  List<ExerciseSet> sets = [];

  init() {
    exercisesSubscription = database.watchExercisesWithType(uuid: current.workout).listen(_newExercisesListener);
    setsSubscription = database.watchSets(uuid: current.uuid).listen(_newSetsListener);
    scrollableController.addListener(_closeSheetListener);
    showKeyboard = false;
  }

  void nextExercise() {
    if (exercises.indexOf(current) == exercises.length - 1) {
      current = exercises.first;
    } else {
      current = exercises[(current.number).clamp(0, exercises.length - 1)];
    }
    _updateSubscriptions();
    notifyListeners();
  }

  void prevExercise() {
    if (exercises.indexOf(current) == 0) {
      current = exercises.last;
    } else {
      current = exercises[(current.number - 2).clamp(0, exercises.length - 1)];
    }
    _updateSubscriptions();
    notifyListeners();
  }

  void openKeyboard(BuildContext context) {
    showKeyboard = true;
    notifyListeners();
  }

  void closeKeyboard() {
    showKeyboard = false;
    node.unfocus();
    notifyListeners();
  }

  void updateWeight(String uuid, String value) {
    try {
      if (value.contains(',')) return;
      database.updateSetWeight(uuid: uuid, weight: double.parse(value));
    } catch (e) {
      print(e);
    }
  }

  void updateRepeats(String uuid, String value) {
    try {
      database.updateSetRepeats(uuid: uuid, repeats: int.parse(value));
    } catch (e) {
      print(e);
    }
  }

  void addSet() {
    try {
      database.addExerciseSet(newSet: ExerciseSet.create(number: sets.last.number + 1, exercise: current.uuid, workout: current.workout));
    } catch (e) {
      print(e);
    }
  }

  void removeSet(String uuid) {
    try {
      database.removeExerciseSet(setUuid: uuid, exerciseUuid: current.uuid);
    } catch (e) {
      print(e);
    }
  }

  void _updateSubscriptions() {
    exercisesSubscription.cancel();
    setsSubscription.cancel();
    exercisesSubscription = database.watchExercisesWithType(uuid: current.workout).listen(_newExercisesListener);
    setsSubscription = database.watchSets(uuid: current.uuid).listen(_newSetsListener);
  }

  void _closeSheetListener() {
    if (scrollableController.size <= .5) {
      appRouter.popUntilRouteWithPath('/workout');
    }
  }

  void _newSetsListener(List<ExerciseSet> data) {
    sets = data;
    notifyListeners();
  }

  void _newExercisesListener(List<Exercise> data) {
    exercises = data;
    notifyListeners();
  }

  @override
  void dispose() {
    exercisesSubscription.cancel();
    setsSubscription.cancel();
    super.dispose();
  }
}
