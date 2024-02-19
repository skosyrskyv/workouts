import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_set.dart';
import 'package:workouts/app/database/models/exercise_type.dart';
import 'package:workouts/app/router/app_router.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/app_bar.dart';
import 'package:workouts/core/widgets/menu_dialog.dart';
import 'package:workouts/core/widgets/screen/screen.dart';
import 'package:workouts/core/widgets/spacers.dart';
import 'package:workouts/core/widgets/styled_text.dart';
import 'package:workouts/extensions/duration_extension.dart';
import 'package:workouts/extensions/iterable_extension.dart';
import 'package:workouts/features/workouts/controllers/workout_controller.dart';
import 'package:workouts/features/workouts/widgets/exercise_sheet.dart';

@RoutePage()
class WorkoutScreen extends StatefulWidget {
  final String? uuid;
  final DateTime date;

  const WorkoutScreen({
    super.key,
    this.uuid,
    required this.date,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late final WorkoutController _state;
  @override
  void initState() {
    _state = WorkoutController(
      workoutUuid: widget.uuid,
      date: widget.date,
      database: getIt.get(),
    );
    super.initState();
  }

  void _showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => MenuDialog(
        alignment: Alignment.topRight,
        items: [
          MenuDialogItem(label: 'Edit name', notAvailable: true, onTap: () {}),
          MenuDialogItem(label: 'Edit exercises', notAvailable: true, onTap: () {}),
          MenuDialogItem(label: 'Edit workout', notAvailable: true, onTap: () {}),
          MenuDialogItem(
            label: 'Add exercises',
            icon: Icons.add,
            onTap: () => appRouter.popAndPush(ExercisesRoute(onDone: _state.addExercise)),
          ),
          MenuDialogItem(label: 'Save as template', notAvailable: true, icon: Icons.save_outlined, onTap: () {}),
          MenuDialogItem(
            label: 'Delete',
            icon: Icons.delete,
            onTap: _state.deleteWorkout,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, child) => Screen(
        appBar: CustomAppBar(
          title: 'Workout',
          subtitle: DateFormat('EEEE, d MMMM').format(
            widget.date,
          ),
          actionButton: IconButton(
            onPressed: () {
              _showMenu(context);
            },
            icon: Icon(Icons.more_horiz),
          ),
          centerTitle: true,
        ),
        body: _state.exercises.isEmpty
            ? _Empty()
            : ReorderableListView(
                padding: const EdgeInsets.only(top: 30, bottom: 50),
                onReorder: _state.updateExerciseNumber,
                proxyDecorator: (child, _, __) {
                  return Material(
                    type: MaterialType.canvas,
                    color: Theme.of(context).colorScheme.surface,
                    child: child,
                  );
                },
                children: [
                  ..._state.exercises.mapWithIndex(
                    (exercise, index) => _ExerciseItem(
                      key: ValueKey(exercise.uuid),
                      index: index,
                      exercise: exercise,
                      onDelete: () => _state.deleteExercise(exercise.uuid),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: _BottomBar(
          onAddTap: () => appRouter.push(
            ExercisesRoute(onDone: _state.addExercise),
          ),
        ),
      ),
    );
  }
}

//
// EXERCISE ITEM
//
class _ExerciseItem extends StatefulWidget {
  final int index;
  final Exercise exercise;
  final VoidCallback onDelete;
  const _ExerciseItem({
    required Key key,
    required this.index,
    required this.exercise,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<_ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<_ExerciseItem> {
  bool _showNumber = false;

  @override
  void initState() {
    _playAnimation();
    super.initState();
  }

  Future<void> _playAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _showNumber = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant _ExerciseItem oldWidget) {
    setState(() {
      _showNumber = false;
    });
    _playAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          label: 'Delete',
          foregroundColor: Theme.of(context).colorScheme.error,
          backgroundColor: Theme.of(context).colorScheme.background,
          onPressed: (context) => widget.onDelete(),
        ),
      ]),
      child: SizedBox(
        height: 60,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              showDragHandle: false,
              builder: (_) => ExerciseSheet(
                initExercise: widget.exercise,
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalSpacer.w16(),
              AnimatedOpacity(
                opacity: _showNumber ? 1 : 0,
                duration: Duration(milliseconds: widget.index * 200),
                child: Align(
                  alignment: Alignment.center,
                  child: StyledText(
                    widget.exercise.number.toString(),
                    style: TypographyStyle.labelLarge,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              HorizontalSpacer.w16(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacer.h2(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: StyledText(
                          widget.exercise.typeModel?.name,
                          bold: true,
                        ),
                      ),
                    ),
                    Expanded(
                        child: _Sets(
                      uuid: widget.exercise.uuid,
                      type: widget.exercise.typeModel,
                    )),
                  ],
                ),
              ),
              HorizontalSpacer.w16(),
            ],
          ),
        ),
      ),
    );
  }
}

//
// SETS
//
class _Sets extends StatefulWidget {
  final String uuid;
  final ExerciseType? type;
  const _Sets({
    required this.uuid,
    required this.type,
  });

  @override
  State<_Sets> createState() => _SetsState();
}

class _SetsState extends State<_Sets> {
  late final AppDatabase db;
  List<ExerciseSet> sets = [];
  @override
  void initState() {
    db = getIt.get();
    try {
      db.watchSets(uuid: widget.uuid).listen((event) {
        if (mounted) {
          setState(() {
            sets = event;
          });
        }
      });
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  String setsToString() {
    Map<String, List<ExerciseSet>> mapStringSet = {};

    if (widget.type == null) return '';

    sets.map((set) {
      String string = '';
      final weight = set.weight != null;
      final duration = set.duration != null;
      final reps = set.repeats != null;

      // Only weight (100 kg)
      if (weight && !duration && !reps) {
        string = set.weight?.toStringAsFixed((set.weight ?? 0) % 1 == 0 ? 0 : 1) ?? '0';
      }

      // Only duration (01:00)
      if (duration && !weight && !reps) {
        string = Duration(seconds: set.duration?.floor() ?? 0).toStringTime();
      }

      // Only repeats (5)
      if (reps && !duration && !weight) {
        string = (set.repeats ?? 0).toString();
      }

      // Weight and duration (40 kg x 1:00)
      if (weight && duration) {
        string = '${set.weight?.toStringAsFixed((set.weight ?? 0) % 1 == 0 ? 0 : 1) ?? '0'} x ${Duration(seconds: set.duration?.floor() ?? 0).toStringTime()}';
      }

      // Weight and reps (100 kg x 5 x sets)
      if (weight && reps) {
        string = '${(set.weight ?? 0).toStringAsFixed((set.weight ?? 0) % 1 == 0 ? 0 : 1)}x${set.repeats ?? 0}';
      }
      // Duration and reps (00:30 x 3 x sets)
      if (duration && reps) {
        string = '${Duration(seconds: set.duration?.floor() ?? 0).toStringTime()} x ${(set.repeats ?? 0).toString()}';
      }

      if (mapStringSet.containsKey(string)) {
        mapStringSet[string]!.add(set);
      } else {
        mapStringSet.addAll({
          string: [set]
        });
      }
    }).toList();

    String result = '';
    mapStringSet.map((key, value) {
      result += (result.length > 1 ? ', ' : '') + (value.length > 1 ? '${key}x${value.length}' : key);
      return MapEntry(key, value);
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledText(setsToString()),
      ],
    );
  }
}

//
// EXERCISES LIST EMPTY
//
class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: const StyledText(
              'Tap ( + ) button to add exercises to the Workout',
              align: TextAlign.center,
              highlighted: true,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

//
// BOTTOM BAR
//
class _BottomBar extends StatelessWidget {
  final AsyncCallback onAddTap;
  const _BottomBar({
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AddExercisesButton(
              onTap: onAddTap,
            )
          ],
        ),
      ),
    );
  }
}

class _AddExercisesButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddExercisesButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.circle,
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        highlightColor: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
