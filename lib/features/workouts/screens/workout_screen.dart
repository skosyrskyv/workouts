import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_set.dart';
import 'package:workouts/app/router/app_router.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/app_bar.dart';
import 'package:workouts/core/widgets/screen/screen.dart';
import 'package:workouts/core/widgets/spacers.dart';
import 'package:workouts/core/widgets/styled_text.dart';
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
      builder: (ctx) => GestureDetector(
        onTap: () => appRouter.pop(),
        child: Material(
          type: MaterialType.transparency,
          color: Colors.black.withOpacity(.1),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 224,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(20),
              width: double.maxFinite,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(30)),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    ...List.generate(
                      4,
                      (index) => ListTile(
                        onTap: () {},
                        title: Center(child: StyledText('Button')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
        body: ReorderableListView(
          padding: EdgeInsets.only(top: 30, bottom: 50),
          onReorder: _state.updateExerciseNumber,
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
          onDelete: _state.deleteWorkout,
          onAdd: () => appRouter.push(
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
                    Expanded(child: _Sets(uuid: widget.exercise.uuid)),
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
  const _Sets({required this.uuid});

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
    sets.map((set) {
      final string = '${(set.weight ?? 0).toStringAsFixed((set.weight ?? 0) % 1 == 0 ? 0 : 1)}x${set.repeats ?? 0}';
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
// BOTTOM BAR
//
class _BottomBar extends StatelessWidget {
  final AsyncCallback onAdd;
  final VoidCallback onDelete;
  const _BottomBar({
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          HorizontalSpacer.w10(),
          IconButton.filledTonal(onPressed: onDelete, icon: const Icon(Icons.delete)),
          const Spacer(),
          IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.edit)),
          const Spacer(),
          IconButton.filledTonal(onPressed: onAdd, icon: const Icon(Icons.add)),
          HorizontalSpacer.w10(),
        ],
      ),
    );
  }
}
