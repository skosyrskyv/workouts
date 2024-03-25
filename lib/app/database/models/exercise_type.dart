// ignore_for_file: non_constant_identifier_names

import 'package:drift/drift.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/enums.dart';

class ExerciseType implements Insertable<ExerciseType> {
  final String key;
  final ExerciseGroup type;
  final MuscleGroup muscleGroup;
  final List<String>? muscles;
  final String name;
  final String? nameRu;
  final bool repeatsProp;
  final bool weightProp;
  final bool durationProp;

  ExerciseType({
    required this.key,
    required this.type,
    required this.muscleGroup,
    required this.muscles,
    required this.name,
    required this.nameRu,
    required this.repeatsProp,
    required this.weightProp,
    required this.durationProp,
  });

  ExerciseType.fromDB({
    required this.key,
    required this.type,
    required this.muscleGroup,
    String? muscles,
    required this.name,
    required this.nameRu,
    required this.repeatsProp,
    required this.weightProp,
    required this.durationProp,
  }) : muscles = muscles?.split(',');

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExerciseTypesCompanion(
      key: Value(key),
      type: Value(type),
      muscleGroup: Value(muscleGroup),
      name: Value(name),
      nameRu: Value(nameRu),
      repeatsProp: Value(repeatsProp),
      weightProp: Value(weightProp),
      durationProp: Value(durationProp),
    ).toColumns(nullToAbsent);
  }

  @override
  bool operator ==(other) {
    return (other.hashCode == hashCode);
  }

  @override
  int get hashCode => key.hashCode;
}
