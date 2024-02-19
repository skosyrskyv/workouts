import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:workouts/app/database/database.dart';

class ExerciseSet implements Insertable<ExerciseSet> {
  final String uuid;
  final int number;
  final String exercise;
  final String workout;
  final DateTime created;
  final DateTime? start;
  final DateTime? finish;
  final double? duration;
  final int? repeats;
  final double? weight;

  ExerciseSet({
    required this.uuid,
    required this.number,
    required this.exercise,
    required this.workout,
    required this.created,
    this.start,
    this.finish,
    this.duration,
    this.repeats,
    this.weight,
  });

  static ExerciseSet create({
    required int number,
    required String exercise,
    required String workout,
    int? repeats,
    double? duration,
    double? weight,
  }) {
    return ExerciseSet(
      uuid: const Uuid().v1(),
      number: number,
      workout: workout,
      exercise: exercise,
      repeats: repeats,
      duration: duration,
      weight: weight,
      created: DateTime.now(),
    );
  }

  ExerciseSet copyWith({
    String? uuid,
    int? number,
    String? exercise,
    String? workout,
    DateTime? created,
    DateTime? start,
    DateTime? finish,
    double? duration,
    int? repeats,
    double? weight,
  }) {
    return ExerciseSet(
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
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExerciseSetsCompanion(
      uuid: Value(uuid),
      number: Value(number),
      exercise: Value(exercise),
      workout: Value(workout),
      created: Value(created),
      start: Value(start),
      finish: Value(finish),
      duration: Value(duration),
      repeats: Value(repeats),
      weight: Value(weight),
    ).toColumns(nullToAbsent);
  }
}
