// ignore_for_file: non_constant_identifier_names

import 'package:drift/drift.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/enums.dart';

class ExerciseType implements Insertable<ExerciseType> {
  final String key;
  final ExerciseGroup type;
  final MuscleGroup muscle;
  final String name;
  final String? name_ru;

  ExerciseType({
    required this.key,
    required this.type,
    required this.muscle,
    required this.name,
    required this.name_ru,
  });

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExerciseTypesCompanion(
      key: Value(key),
      type: Value(type),
      muscle: Value(muscle),
      name: Value(name),
      name_ru: Value(name_ru),
    ).toColumns(nullToAbsent);
  }

  @override
  bool operator ==(other) {
    return (other.hashCode == hashCode);
  }

  @override
  int get hashCode => key.hashCode;
}
