import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/models/exercise.dart';
import 'package:workouts/app/database/models/exercise_set.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/screen/screen.dart';
import 'package:workouts/core/widgets/spacers.dart';
import 'package:workouts/core/widgets/styled_text.dart';
import 'package:workouts/features/workouts/controllers/exercise_sheet_controller.dart';
import 'package:workouts/features/workouts/widgets/numeric_keyboard.dart';

class ExerciseSheet extends StatefulWidget {
  final Exercise initExercise;

  const ExerciseSheet({
    super.key,
    required this.initExercise,
  });

  @override
  State<ExerciseSheet> createState() => _ExerciseSheetState();
}

class _ExerciseSheetState extends State<ExerciseSheet> {
  late final ExerciseSheetController _state;

  @override
  void initState() {
    _state = ExerciseSheetController(initExercise: widget.initExercise, database: getIt.get());
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return DraggableScrollableSheet(
      controller: _state.scrollableController,
      initialChildSize: .9,
      maxChildSize: .9,
      minChildSize: .4,
      snap: true,
      builder: (context, controller) => ListenableBuilder(
        listenable: _state,
        builder: (_, __) => Screen(
          background: Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(top: 100),
          ),
          body: GestureDetector(
            onTap: _state.closeKeyboard,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VerticalSpacer.h32(),
                  StyledText(
                    _state.current.typeModel?.name,
                    style: TypographyStyle.headlineLarge,
                    color: Theme.of(context).colorScheme.primary,
                    bold: true,
                  ),
                  VerticalSpacer.h4(),
                  StyledText(
                    _state.current.typeModel?.muscle.name.toUpperCase(),
                    style: TypographyStyle.titleSmall,
                    highlighted: true,
                    bold: true,
                  ),
                  VerticalSpacer.h16(),
                  StyledText(
                    '${_state.current.number} of ${_state.exercises.length}',
                    style: TypographyStyle.bodyMedium,
                  ),
                  Expanded(
                    child: FocusScope(
                      node: _state.node,
                      child: ListView(
                        padding: const EdgeInsets.only(top: 10, bottom: 100),
                        controller: controller,
                        children: [
                          ..._state.sets.map(
                            (set) => _SetItem(
                              set: set,
                              key: ValueKey(set.uuid),
                              showNumbers: _state.sets.length > 1,
                              onTap: () => _state.openKeyboard(context),
                              onDelete: (context, uuid) {
                                _state.closeKeyboard();
                                _state.removeSet(uuid);
                              },
                              onChangeWeight: (weight) => _state.updateWeight(set.uuid, weight),
                              onChangeReps: (repeats) => _state.updateRepeats(set.uuid, repeats),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_state.showKeyboard) const VerticalSpacer(200),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AnimatedCrossFade(
            sizeCurve: Curves.fastOutSlowIn,
            firstChild: NumericKeyboard(
              onCloseKeyboard: _state.closeKeyboard,
              focusScopeNode: _state.node,
              onAdd: _state.addSet,
            ),
            secondChild: _ControlsBar(
              onAddTap: _state.addSet,
              onHistoryTap: () {},
              onNextTap: _state.nextExercise,
              onPrevTap: _state.prevExercise,
            ),
            crossFadeState: _state.showKeyboard ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}

//
// SET ITEM
//
class _SetItem extends StatefulWidget {
  final ExerciseSet set;
  final VoidCallback onTap;
  final bool showNumbers;
  final Function(String) onChangeWeight;
  final Function(String) onChangeReps;
  final Function(BuildContext, String) onDelete;

  const _SetItem({
    super.key,
    required this.set,
    required this.onTap,
    required this.showNumbers,
    required this.onChangeWeight,
    required this.onChangeReps,
    required this.onDelete,
  });

  @override
  State<_SetItem> createState() => _SetItemState();
}

class _SetItemState extends State<_SetItem> {
  late final TextEditingController weight;
  late final TextEditingController repeats;

  @override
  void initState() {
    weight = TextEditingController(text: widget.set.weight?.toStringAsFixed(0) ?? '0')
      ..addListener(() {
        widget.onChangeWeight(weight.text);
      });

    repeats = TextEditingController(text: widget.set.repeats?.toString() ?? '0')
      ..addListener(() {
        widget.onChangeReps(repeats.text);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: widget.set.number != 1,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            foregroundColor: Theme.of(context).colorScheme.error,
            onPressed: (context) {
              widget.onDelete(context, widget.set.uuid);
            },
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HorizontalSpacer.w10(),
            Center(
              child: StyledText(
                widget.set.number.toString(),
                highlighted: true,
                color: widget.showNumbers ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.surface,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: AutoSizeTextField(
                  controller: weight,
                  textAlign: TextAlign.center,
                  enableInteractiveSelection: false,
                  maxLines: 1,
                  minLines: 1,
                  onTap: () {
                    weight.selection = TextSelection(baseOffset: 0, extentOffset: weight.text.length);
                    widget.onTap();
                  },
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 4, color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  keyboardType: TextInputType.none,
                  fullwidth: false,
                  minFontSize: 30,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: StyledText(
                'KG',
                style: TypographyStyle.bodyLarge,
                highlighted: true,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: StyledText(
                '  x ',
                style: TypographyStyle.labelLarge,
                highlighted: true,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeTextField(
                  textAlign: TextAlign.center,
                  enableInteractiveSelection: false,
                  controller: repeats,
                  maxLines: 1,
                  keyboardType: TextInputType.none,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  minLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 4, color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  onTap: () {
                    repeats.selection = TextSelection(baseOffset: 0, extentOffset: repeats.text.length);
                    widget.onTap();
                  },
                  fullwidth: false,
                  minFontSize: 30,
                ),
              ),
            ),
            HorizontalSpacer.w10(),
          ],
        ),
      ),
    );
  }
}

//
// CONTROLS BAR
//
class _ControlsBar extends StatelessWidget {
  final VoidCallback onAddTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onNextTap;
  final VoidCallback onPrevTap;

  const _ControlsBar({
    required this.onAddTap,
    required this.onHistoryTap,
    required this.onNextTap,
    required this.onPrevTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ClipRect(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onPrevTap,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            IconButton(onPressed: null, iconSize: 30, icon: const Icon(Icons.history)),
            IconButton.filled(
              onPressed: () {
                appRouter.pop();
              },
              iconSize: 40,
              icon: const Icon(Icons.keyboard_double_arrow_down_rounded),
            ),
            IconButton(onPressed: onAddTap, iconSize: 30, icon: const Icon(Icons.add)),
            IconButton(
              onPressed: onNextTap,
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
