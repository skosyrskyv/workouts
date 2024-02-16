import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/workout.dart';
import 'package:workouts/app/router/app_router.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/loading/loading_indicator.dart';
import 'package:workouts/core/widgets/styled_text.dart';
import 'package:workouts/core/widgets/spacers.dart';

class WorkoutsList extends StatefulWidget {
  final DateTime date;
  const WorkoutsList({
    super.key,
    required this.date,
  });

  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {
  late final AppDatabase _database;

  @override
  void initState() {
    _database = getIt.get();
    super.initState();
  }

  void _openWorkoutAddingScreen() {
    AutoRouter.of(context).push(WorkoutRoute(date: widget.date));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _database.watchWorkouts(date: widget.date),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            height: 200,
            child: const LoadingIndicator(),
          );
        }
        if (snapshot.data!.isEmpty) {
          return _WorkoutsListEmpty(
            onAddButtonPressed: _openWorkoutAddingScreen,
          );
        }
        return _WorkoutsListLoaded(
          workouts: snapshot.data!,
        );
      },
    );
  }
}

//
// LIST LOADED
//
class _WorkoutsListLoaded extends StatelessWidget {
  final List<Workout> workouts;
  const _WorkoutsListLoaded({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...workouts.map(
          (workout) => _WorkoutListItem(
            key: ValueKey(workout.uuid),
            workout: workout,
          ),
        ),
      ],
    );
  }
}

//
// LIST ITEM
//
class _WorkoutListItem extends StatefulWidget {
  final Workout workout;
  const _WorkoutListItem({
    Key? key,
    required this.workout,
  }) : super(key: key);

  @override
  State<_WorkoutListItem> createState() => _WorkoutListItemState();
}

class _WorkoutListItemState extends State<_WorkoutListItem> {
  late final AppDatabase database;
  List<Exercise> exercises = [];
  bool _show = false;

  @override
  void initState() {
    database = getIt.get();
    database.watchExercisesWithType(uuid: widget.workout.uuid).listen((data) {
      if (mounted) {
        setState(() {
          exercises = data;
        });
      }
    });
    _startAnimation();
    super.initState();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (mounted) {
      setState(() {
        _show = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _show ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Material(
          type: MaterialType.button,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(.05),
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                appRouter.push(
                  WorkoutRoute(
                    uuid: widget.workout.uuid,
                    date: widget.workout.created,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StyledText(
                      widget.workout.name ?? "Workout",
                      style: TypographyStyle.labelMedium,
                      bold: true,
                    ),
                    VerticalSpacer.h10(),
                    ...exercises.map(
                      (e) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(children: [
                            StyledText(
                              e.number.toString(),
                              highlighted: true,
                            ),
                            HorizontalSpacer.w8(),
                            StyledText(e.typeModel?.name),
                          ]),
                        );
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

//
// LIST EMPTY
//
class _WorkoutsListEmpty extends StatelessWidget {
  final VoidCallback onAddButtonPressed;
  const _WorkoutsListEmpty({
    required this.onAddButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(.07),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VerticalSpacer.h16(),
          StyledText(
            'Workouts',
            style: TypographyStyle.titleLarge,
            bold: true,
          ),
          VerticalSpacer.h4(),
          StyledText(
            'There`s nothing for today',
          ),
          Spacer(),
          _AddWorkoutButton(
            onTap: onAddButtonPressed,
          ),
          Spacer(),
        ],
      ),
    );
  }
}

//
// ADD WORKOUT BUTTON
//
class _AddWorkoutButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddWorkoutButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.button,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 55,
        width: 250,
        child: InkWell(
          onTap: onTap,
          highlightColor: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: Center(
              child: StyledText(
                "Add Workout",
                bold: true,
                style: TypographyStyle.labelLarge,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
