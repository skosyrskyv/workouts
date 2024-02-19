import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise_type.dart';

class ExercisesController extends ChangeNotifier {
  final AppDatabase db;
  final Function(Set<ExerciseType>)? onDone;
  final Set<ExerciseType> initialSelected;

  ExercisesController({
    required this.db,
    required this.initialSelected,
    this.onDone,
  }) {
    selected.addAll(initialSelected);
  }

  List<ExerciseType> exercises = [];
  Set<ExerciseType> selected = {};

  bool loading = false;
  String? error;

  Future<void> search(String? pattern) async {
    if (pattern == null) {
      exercises = selected.toList();
      notifyListeners();
      return;
    }
    if (pattern.trim().isEmpty) {
      exercises = selected.toList();
      notifyListeners();
      return;
    }
    try {
      exercises = await db.searchExerciseTypes(pattern: pattern.trim());
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void changeSelected(ExerciseType exerciseType, bool? value) {
    if (value == null) return;
    if (value) {
      selected.add(exerciseType);
    } else {
      selected.remove(exerciseType);
    }
    notifyListeners();
  }

  void popScreen(BuildContext context) {
    if (onDone != null) {
      onDone!(selected);
    }
    AutoRouter.of(context).pop<Set<ExerciseType>>(selected);
  }
}
