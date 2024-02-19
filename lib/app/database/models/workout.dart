import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:workouts/app/database/database.dart';

class Workout implements Insertable<Workout> {
  final String uuid;
  final String? name;
  final DateTime created;
  final DateTime? start;
  final DateTime? finish;
  final double? duration;

  const Workout({
    required this.uuid,
    this.name,
    required this.created,
    this.start,
    this.finish,
    this.duration,
  });

  static Workout create({required DateTime date}) {
    return Workout(uuid: const Uuid().v1(), created: date);
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return WorkoutsCompanion(
      uuid: Value(uuid),
      name: Value(name),
      created: Value(created),
      start: Value(start),
      finish: Value(finish),
      duration: Value(duration),
    ).toColumns(nullToAbsent);
  }

  @override
  bool operator ==(other) {
    return (other.hashCode == hashCode);
  }

  @override
  int get hashCode => uuid.hashCode;
}
