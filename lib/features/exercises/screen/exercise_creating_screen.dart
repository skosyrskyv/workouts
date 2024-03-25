import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:workouts/app/database/enums.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/app_bar.dart';
import 'package:workouts/core/widgets/screen/screen.dart';
import 'package:workouts/features/exercises/controllers/exercise_creating_controller.dart';
import 'package:workouts/features/exercises/widgets/muscles_picker.dart';

@RoutePage()
class ExerciseCreatingScreen extends StatefulWidget {
  const ExerciseCreatingScreen({super.key});

  @override
  State<ExerciseCreatingScreen> createState() => _ExerciseCreatingScreenState();
}

class _ExerciseCreatingScreenState extends State<ExerciseCreatingScreen> {
  late final ExerciseTypeCreatingController _state;
  Set<Muscle> muscles = {};
  Set<MuscleGroup> muscleGroups = {};

  changeMuscle(Muscle value) {
    if (muscles.contains(value)) {
      muscles.remove(value);
    } else {
      muscles.add(value);
    }
    setState(() {});
  }

  changeMuscleGroup(MuscleGroup value) {
    if (muscleGroups.contains(value)) {
      muscleGroups.remove(value);
    } else {
      if (muscleGroups.length >= 2) {
        muscleGroups.remove(muscleGroups.first);
      }
      muscleGroups.add(value);
    }
    setState(() {});
  }

  @override
  void initState() {
    _state = getIt.get();
    super.initState();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: CustomAppBar(
        title: 'New Exercise',
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text('name'),
            ),
          ),
          MusclesPicker(
            selectedMuscles: muscles,
            selectedMuscleGroups: muscleGroups,
            onChangeMuscle: changeMuscle,
            onChangeMuscleGroup: changeMuscleGroup,
          ),
        ],
      ),
    );
  }
}
