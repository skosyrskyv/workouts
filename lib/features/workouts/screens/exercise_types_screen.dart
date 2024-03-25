import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/database/enums.dart';
import 'package:workouts/app/database/models/exercise_type.dart';
import 'package:workouts/app/router/app_router.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/app_bar.dart';
import 'package:workouts/core/widgets/screen/screen.dart';
import 'package:workouts/core/widgets/styled_text.dart';
import 'package:workouts/features/workouts/controllers/exercises_controller.dart';
import 'package:workouts/core/widgets/spacers.dart';

@RoutePage()
class ExercisesScreen extends StatefulWidget {
  final Set<ExerciseType> initialSelected;
  final Function(Set<ExerciseType>)? onDone;
  const ExercisesScreen({super.key, this.initialSelected = const {}, this.onDone});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late ExercisesController _state;

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == 0) return const SizedBox();
    final item = _state.exercises[index - 1];
    return _ExerciseListItem(
      exercise: item,
      selected: _state.selected.map((e) => e.key).contains(item.key),
      onChange: (bool? value) => _state.changeSelected(item, value),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Column(
        children: [
          _TypeSeparator(type: _state.exercises[index].type),
          _MuscleGroupSeparator(
            muscleGroup: _state.exercises[index].muscleGroup,
          ),
        ],
      );
    }
    if (_state.exercises[index - 1].type != _state.exercises[index].type) {
      return Column(
        children: [
          VerticalSpacer.h20(),
          _TypeSeparator(type: _state.exercises[index].type),
          _MuscleGroupSeparator(
            muscleGroup: _state.exercises[index].muscleGroup,
          ),
        ],
      );
    }

    if (_state.exercises[index - 1].muscleGroup != _state.exercises[index].muscleGroup) {
      return _MuscleGroupSeparator(
        muscleGroup: _state.exercises[index].muscleGroup,
      );
    }
    return const SizedBox();
  }

  @override
  void initState() {
    _state = ExercisesController(
      db: getIt.get(),
      onDone: widget.onDone,
      initialSelected: widget.initialSelected,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, _) => Screen(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: 'Exercises',
          actionButton: IconButton(
            onPressed: () => appRouter.push(const ExerciseCreatingRoute()),
            icon: const Icon(Icons.add),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacer.h10(),
              _SearchBar(
                autofocus: _state.exercises.isEmpty,
                onSearch: _state.search,
              ),
              Expanded(
                child: _state.error != null
                    ? _Error(
                        error: _state.error,
                        onReload: () {},
                      )
                    : _state.exercises.isEmpty
                        ? const _Empty()
                        : ListView.separated(
                            itemCount: _state.exercises.length + 1,
                            padding: const EdgeInsets.only(top: 30, bottom: 60),
                            itemBuilder: _itemBuilder,
                            separatorBuilder: _separatorBuilder,
                          ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _state.selected.isNotEmpty
            ? SafeArea(
                top: false,
                child: _DoneButton(
                  active: _state.selected.isNotEmpty,
                  onPressed: () => _state.popScreen(context),
                ),
              )
            : null,
      ),
    );
  }
}

//
// DONE BUTTON
//
class _DoneButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool active;
  const _DoneButton({
    required this.onPressed,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: FilledButton(
          onPressed: active ? onPressed : null,
          child: const Text('Done'),
        ),
      ),
    );
  }
}

//
// Type separator
//
class _TypeSeparator extends StatelessWidget {
  final ExerciseGroup type;
  const _TypeSeparator({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: StyledText(
        type.name,
        style: TypographyStyle.titleLarge,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

//
//  Muscle group separator
//
class _MuscleGroupSeparator extends StatelessWidget {
  final MuscleGroup muscleGroup;
  const _MuscleGroupSeparator({super.key, required this.muscleGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(
            muscleGroup.name,
            style: TypographyStyle.titleMedium,
            bold: true,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Divider(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.1),
          ),
        ],
      ),
    );
  }
}

//
// EXERCISE LIST ITEM
//
class _ExerciseListItem extends StatelessWidget {
  final ExerciseType exercise;
  final bool selected;
  final Function(bool?) onChange;

  const _ExerciseListItem({
    required this.exercise,
    required this.selected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      side: BorderSide(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.3),
      ),
      checkboxShape: const CircleBorder(),
      controlAffinity: ListTileControlAffinity.leading,
      title: StyledText(
        exercise.name,
        style: TypographyStyle.labelMedium,
      ),
      onChanged: onChange,
    );
  }
}

//
// SEARCH BAR
//
class _SearchBar extends StatefulWidget {
  final Function(String input) onSearch;
  final bool autofocus;
  const _SearchBar({
    required this.onSearch,
    required this.autofocus,
  });

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  late final TextEditingController _controller;
  late final KeyboardVisibilityController _keyboardController;
  bool _isFocused = false;

  void _keyboardListener(bool isOpened) {
    _setFocus(isOpened);
  }

  void _setFocus(bool value) {
    if (value == _isFocused) return;
    setState(() {
      _isFocused = value;
    });
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _keyboardController = KeyboardVisibilityController();
    _keyboardController.onChange.listen(_keyboardListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          width: _isFocused ? MediaQuery.of(context).size.width - 100 : MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: KeyboardVisibilityProvider(
              controller: _keyboardController,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                onChanged: widget.onSearch,
                autofocus: true,
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                  ),
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(.3),
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          padding: const EdgeInsets.only(right: 5),
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          width: _isFocused ? 100 : 0,
          height: _isFocused ? 40 : 0,
          child: TextButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onSearch('');
              _controller.clear();
            },
            child: const Text('cancel'),
          ),
        ),
      ],
    );
  }
}

//
// EMPTY
//
class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: StyledText(
              'Start typing the name of the exercise',
              highlighted: true,
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}

//
// ERROR
//
class _Error extends StatelessWidget {
  final String? error;
  final VoidCallback onReload;
  const _Error({
    required this.error,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const StyledText(
            "Error",
            style: TypographyStyle.titleSmall,
            bold: true,
          ),
          VerticalSpacer.h4(),
          StyledText(
            error,
            align: TextAlign.center,
          ),
          VerticalSpacer.h32(),
          FilledButton.tonalIcon(
            onPressed: onReload,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Reload'),
          ),
        ],
      ),
    );
  }
}
