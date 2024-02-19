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
  final bool repeats_prop;
  final bool weight_prop;
  final bool duration_prop;

  ExerciseType({
    required this.key,
    required this.type,
    required this.muscle,
    required this.name,
    required this.name_ru,
    required this.repeats_prop,
    required this.weight_prop,
    required this.duration_prop,
  });

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExerciseTypesCompanion(
      key: Value(key),
      type: Value(type),
      muscle: Value(muscle),
      name: Value(name),
      name_ru: Value(name_ru),
      repeats_prop: Value(repeats_prop),
      weight_prop: Value(weight_prop),
      duration_prop: Value(duration_prop),
    ).toColumns(nullToAbsent);
  }

  @override
  bool operator ==(other) {
    return (other.hashCode == hashCode);
  }

  @override
  int get hashCode => key.hashCode;
}
