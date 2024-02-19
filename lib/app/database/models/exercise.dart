import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise_type.dart';

class Exercise implements Insertable<Exercise> {
  final String uuid;
  final int number;
  final String type;
  final String workout;
  final DateTime created;
  final DateTime? start;
  final DateTime? finish;
  final double? duration;
  final ExerciseType? typeModel;

  Exercise({
    required this.uuid,
    required this.number,
    required this.type,
    required this.workout,
    required this.created,
    this.start,
    this.finish,
    this.duration,
    this.typeModel,
  });

  static Exercise create({
    required String workout,
    required String type,
    required int number,
    required ExerciseType typeModel,
  }) {
    return Exercise(
      uuid: const Uuid().v1(),
      type: type,
      number: number,
      workout: workout,
      typeModel: typeModel,
      created: DateTime.now(),
    );
  }

  Exercise copyWith({
    String? uuid,
    int? number,
    String? type,
    String? workout,
    DateTime? created,
    DateTime? start,
    DateTime? finish,
    double? duration,
    ExerciseType? typeModel,
  }) {
    return Exercise(
      uuid: uuid ?? this.uuid,
      number: number ?? this.number,
      type: type ?? this.type,
      workout: workout ?? this.workout,
      created: created ?? this.created,
      start: start ?? this.start,
      finish: finish ?? this.finish,
      duration: duration ?? this.duration,
      typeModel: typeModel ?? this.typeModel,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExercisesCompanion(
      uuid: Value(uuid),
      type: Value(type),
      number: Value(number),
      workout: Value(workout),
      created: Value(created),
      start: Value(start),
      finish: Value(finish),
      duration: Value(duration),
    ).toColumns(nullToAbsent);
  }

  @override
  bool operator ==(Object other) {
    return other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$uuid$number$type$workout$created$start$finish$duration$typeModel'.hashCode;
}
