import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/enums.dart';

@injectable
class ExerciseTypeCreatingController extends ChangeNotifier {
  final AppDatabase _database;
  ExerciseTypeCreatingController({required AppDatabase database}) : _database = database;

  String name = '';
  ExerciseGroup? group;
  MuscleGroup? muscle;
  String? nameRu;
  bool repeatsProp = true;
  bool weightProp = true;
  bool durationProp = false;

  createExercise() {
    _database;
  }
}
