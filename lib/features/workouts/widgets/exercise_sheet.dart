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
                              onChangeDuration: (duration) => _state.updateDuration(set.uuid, duration),
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
              onAddSet: _state.addSet,
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
  final Function(String) onChangeDuration;

  final Function(BuildContext, String) onDelete;

  const _SetItem({
    super.key,
    required this.set,
    required this.onTap,
    required this.showNumbers,
    required this.onChangeWeight,
    required this.onChangeReps,
    required this.onChangeDuration,
    required this.onDelete,
  });

  @override
  State<_SetItem> createState() => _SetItemState();
}

class _SetItemState extends State<_SetItem> {
  late final TextEditingController weightController;
  late final TextEditingController repeatsController;
  late final TextEditingController durationMinutesController;
  late final TextEditingController durationSecondsController;

  @override
  void initState() {
    weightController = TextEditingController(text: widget.set.weight?.toStringAsFixed(0) ?? '0')
      ..addListener(() {
        widget.onChangeWeight(weightController.text);
      });
    repeatsController = TextEditingController(text: widget.set.repeats?.toString() ?? '0')
      ..addListener(() {
        widget.onChangeReps(repeatsController.text);
      });
    durationMinutesController = TextEditingController(text: widget.set.duration == null ? '0' : (widget.set.duration! % 60).toStringAsFixed(0))
      ..addListener(() {
        widget.onChangeDuration('${durationMinutesController.text}:${durationSecondsController.text}');
      });
    durationSecondsController = TextEditingController(text: (widget.set.duration?.remainder(60))?.toStringAsFixed(0).padLeft(2, '0') ?? '00')
      ..addListener(() {
        widget.onChangeDuration('${durationMinutesController.text}:${durationSecondsController.text}');
      });
    super.initState();
  }

  List<Widget> buildFields() {
    List<Widget> result = [];
    final weight = widget.set.weight != null;
    final duration = widget.set.duration != null;
    final reps = widget.set.repeats != null;

    final weightField = _WeightField(controller: weightController, onTap: widget.onTap);
    final repsField = _RepeatsField(controller: repeatsController, onTap: widget.onTap);
    final minutesDurationField = _DurationMinutesField(controller: durationMinutesController, onTap: widget.onTap);
    final secondsDurationField = _DurationSecondsField(controller: durationSecondsController, onTap: widget.onTap);

    // Only weight (100 kg)
    if (weight && !duration && !reps) {
      result = [
        const Spacer(),
        weightField,
        const _WeightUnit(),
        const Spacer(),
      ];
    }

    // Only duration (01:00)
    if (duration && !weight && !reps) {
      result = [
        Expanded(
          child: minutesDurationField,
        ),
        const _ColonSign(),
        Expanded(
          child: secondsDurationField,
        )
      ];
    }

    // Only repeats (5)
    if (reps && !duration && !weight) {
      result = [
        const Spacer(),
        repsField,
        const Spacer(),
      ];
    }

    // Weight and duration (40 kg x 1:00)
    if (weight && duration) {
      result = [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            weightField,
            const _WeightUnit(),
          ],
        )),
        const _CrossSign(),
        Expanded(
          child: Row(
            children: [
              minutesDurationField,
              const _ColonSign(),
              secondsDurationField,
            ],
          ),
        ),
      ];
    }

    // Weight and reps (100 kg x 5 x sets)
    if (weight && reps) {
      result = [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            weightField,
            const _WeightUnit(),
          ],
        )),
        const _CrossSign(),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: repsField,
          ),
        ),
      ];
    }

    // Duration and reps (00:30 x 3 x sets)
    if (duration && reps) {
      result = [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              minutesDurationField,
              const _ColonSign(),
              secondsDurationField,
            ],
          ),
        ),
        const _CrossSign(),
        Expanded(
          child: Align(alignment: Alignment.centerLeft, child: repsField),
        ),
      ];
    }

    return result;
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
            Align(
              alignment: Alignment.centerLeft,
              child: StyledText(
                widget.set.number.toString(),
                highlighted: true,
                color: widget.showNumbers ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.surface,
              ),
            ),
            ...buildFields(),
            HorizontalSpacer.w10(),
          ],
        ),
      ),
    );
  }
}

//
// WEIGHT FIELD
//
class _WeightField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const _WeightField({
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      controller: controller,
      textAlign: TextAlign.center,
      enableInteractiveSelection: false,
      inputFormatters: [
        _WeightFormatter(),
      ],
      maxLines: 1,
      minLines: 1,
      onTap: () {
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
        onTap();
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
    );
  }
}

//
// REPEATS FIELD
//
class _RepeatsField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  const _RepeatsField({
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      textAlign: TextAlign.center,
      enableInteractiveSelection: false,
      controller: controller,
      maxLines: 1,
      keyboardType: TextInputType.none,
      inputFormatters: [
        _RepeatsFormatter(),
      ],
      minLines: 1,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 4, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      onTap: () {
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
        onTap();
      },
      fullwidth: false,
      minFontSize: 30,
    );
  }
}

//
// DURATION MINUTES FIELD
//
class _DurationMinutesField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  const _DurationMinutesField({
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: AutoSizeTextField(
        textAlign: TextAlign.center,
        enableInteractiveSelection: false,
        controller: controller,
        maxLines: 1,
        keyboardType: TextInputType.none,
        inputFormatters: [_MinutesFormatter()],
        minLines: 1,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 4, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        onTap: () {
          controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
          onTap();
        },
        fullwidth: false,
        minFontSize: 30,
      ),
    );
  }
}

//
// DURATION SECONDS FIELD
//
class _DurationSecondsField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  const _DurationSecondsField({
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AutoSizeTextField(
        textAlign: TextAlign.center,
        enableInteractiveSelection: false,
        controller: controller,
        maxLines: 1,
        keyboardType: TextInputType.none,
        inputFormatters: [_SecondsFormatter()],
        minLines: 1,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 4, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        onTap: () {
          controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
          onTap();
        },
        fullwidth: false,
        minFontSize: 30,
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
            const IconButton(onPressed: null, iconSize: 30, icon: Icon(Icons.history)),
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

//
// WEIGHT UNIT
//
class _WeightUnit extends StatelessWidget {
  const _WeightUnit();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: const StyledText(
        'KG',
        style: TypographyStyle.bodyLarge,
        highlighted: true,
      ),
    );
  }
}

//
// CROSS SIGN
//
class _CrossSign extends StatelessWidget {
  const _CrossSign();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: StyledText(
        ' x ',
        style: TypographyStyle.labelLarge,
        highlighted: true,
      ),
    );
  }
}

//
// CROSS SIGN
//
class _ColonSign extends StatelessWidget {
  const _ColonSign();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: StyledText(
        ':',
        fontSize: 25,
      ),
    );
  }
}

////////////////////////////////////////////////////
// FORMATTERS
////////////////////////////////////////////////////

class _WeightFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    const int maxLength = 5;

    // if text empty set value to 0
    if (newValue.text.isEmpty) return const TextEditingValue(text: '0');

    // if removing
    if (newValue.text.length < oldValue.text.length) return newValue;

    // Check if text selected
    if (!oldValue.selection.isCollapsed) {
      return newValue.copyWith(text: newValue.text.substring(oldValue.text.length));
    }

    // Check if last typed symbol is '.'
    if (newValue.text.length == maxLength && newValue.text.characters.last == '.') return oldValue;

    // Check if 0 is single digit in the text and was typed comma
    if (oldValue.text == '0' && newValue.text.contains('.')) return newValue;

    // Check if field was empty and replace 0 to new symbol
    if (oldValue.text == '0') return newValue.copyWith(text: newValue.text.substring(1));

    // Check if comma is first typed symbol
    if (newValue.text.contains('.') && oldValue.text.isEmpty) return newValue.copyWith(text: '0.');

    // Check if comma already exist in the text
    if (oldValue.text.contains('.')) {
      if (newValue.text.substring(oldValue.text.indexOf('.') + 1).contains('.')) return oldValue;
    }

    // Check the max text length, except for the comma
    if (newValue.text.length > maxLength) return oldValue;

    return newValue;
  }
}

class _RepeatsFormatter extends TextInputFormatter {
  final int maxLength = 4;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // if text empty set value to 0
    if (newValue.text.isEmpty) return const TextEditingValue(text: '0');

    // Check if text selected
    if (!oldValue.selection.isCollapsed) {
      return newValue.copyWith(text: newValue.text.substring(oldValue.text.length));
    }

    // if removing
    if (newValue.text.length < oldValue.text.length) return newValue;

    // Deny "." symbol
    if (newValue.text.contains('.')) return oldValue;

    // Check if field was empty and replace 0 to new symbol
    if (oldValue.text == '0') return newValue.copyWith(text: newValue.text.substring(1));

    // Check the max text length
    if (newValue.text.length > maxLength) return oldValue;

    return newValue;
  }
}

class _MinutesFormatter extends TextInputFormatter {
  final int maxLength = 3;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // if text empty set value to 0
    if (newValue.text.isEmpty) return const TextEditingValue(text: '0');

    // Check if text selected
    if (!oldValue.selection.isCollapsed) {
      return newValue.copyWith(text: newValue.text.substring(oldValue.text.length));
    }

    // if removing
    if (newValue.text.length < oldValue.text.length) return newValue;

    // Deny "." symbol
    if (newValue.text.contains('.')) return oldValue;

    // Check if field was empty and replace 0 to new symbol
    if (oldValue.text == '0') return newValue.copyWith(text: newValue.text.substring(1));

    // Check the max text length
    if (newValue.text.length > maxLength) return oldValue;

    return newValue;
  }
}

class _SecondsFormatter extends TextInputFormatter {
  final int maxLength = 2;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // if text empty set value to 0
    if (newValue.text.isEmpty) return const TextEditingValue(text: '00');

    // if removing
    if (newValue.text.length < oldValue.text.length) {
      if (newValue.text.characters.first == '0') {
        return newValue.copyWith(text: '00');
      } else {
        return newValue.copyWith(text: newValue.text.padLeft(1, '0'));
      }
    }

    // Deny "." symbol
    if (newValue.text.contains('.')) return oldValue;

    // Check if field was empty and replace 0 to new symbol
    if (oldValue.text == '00') {
      final s = newValue.copyWith(text: '0${newValue.text.substring(2)}');
      return RegExp(r'[0-5]').hasMatch(s.text) ? s : oldValue;
    }

    if (oldValue.text.characters.first == '0') {
      final firstDigit = int.tryParse(oldValue.text.substring(1, 2));
      if (firstDigit == null) return oldValue;
      return newValue.copyWith(text: (firstDigit < 5 ? oldValue.text.substring(1, 2) : '5') + newValue.text.characters.last);
    }

    // Check the max text length
    if (newValue.text.length > maxLength) return oldValue;

    return newValue;
  }
}
