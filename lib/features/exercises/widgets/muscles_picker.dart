import 'package:flutter/material.dart';
import 'package:workouts/app/database/enums.dart';
import 'package:workouts/core/widgets/spacers.dart';
import 'package:workouts/core/widgets/styled_text.dart';

const double _itemHeight = 40;

const Map<MuscleGroup, List<Muscle>> _muscles = {
  MuscleGroup.arms: [
    Muscle.biceps,
    Muscle.triceps,
    Muscle.forearms,
  ],
  MuscleGroup.back: [
    Muscle.lower_back,
    Muscle.lats,
    Muscle.traps,
  ],
  MuscleGroup.chest: [],
  MuscleGroup.shoulders: [
    Muscle.anterior_deltoid,
    Muscle.posterior_deltoid,
    Muscle.lateral_deltoid,
  ],
  MuscleGroup.legs: [
    Muscle.calves,
    Muscle.adductors,
    Muscle.quads,
  ],
  MuscleGroup.fullbody: [],
  MuscleGroup.neck: [],
  MuscleGroup.abs: [],
};

//
// MUSCLES PICKER
//
class MusclesPicker extends StatefulWidget {
  final Set<MuscleGroup> selectedMuscleGroups;
  final Set<Muscle> selectedMuscles;
  final Function(Muscle) onChangeMuscle;
  final Function(MuscleGroup) onChangeMuscleGroup;

  const MusclesPicker({
    super.key,
    required this.selectedMuscleGroups,
    required this.selectedMuscles,
    required this.onChangeMuscle,
    required this.onChangeMuscleGroup,
  });

  @override
  State<MusclesPicker> createState() => _MusclesPickerState();
}

class _MusclesPickerState extends State<MusclesPicker> {
  List<Widget> _buildMuscleTiles() {
    List<Widget> result = [];
    for (final muscleGroup in _muscles.keys) {
      result.add(
        _MuscleGroupTile(
          selected: widget.selectedMuscleGroups.contains(muscleGroup),
          label: muscleGroup.name,
          value: muscleGroup,
          onTap: widget.onChangeMuscleGroup,
        ),
      );
      final List<Widget> items = [];
      for (final muscle in _muscles[muscleGroup]!) {
        items.add(
          _MuscleTile(
            selected: widget.selectedMuscles.contains(muscle),
            label: muscle.name,
            value: muscle,
            onTap: widget.onChangeMuscle,
          ),
        );
      }
      result.add(_ExpandableList(expanded: widget.selectedMuscleGroups.contains(muscleGroup), items: items));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildMuscleTiles(),
    );
  }
}

//
// Muscle Group Tile
//
class _MuscleGroupTile extends StatelessWidget {
  final bool selected;
  final String label;
  final MuscleGroup value;
  final Function(MuscleGroup) onTap;

  const _MuscleGroupTile({
    required this.selected,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ListTile(
      label: label,
      selected: selected,
      onTap: () => onTap(value),
    );
  }
}

//
// Muscle tile
//
class _MuscleTile extends StatelessWidget {
  final bool selected;
  final String label;
  final Muscle value;
  final Function(Muscle) onTap;

  const _MuscleTile({
    required this.selected,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ListTile(
      selected: selected,
      label: '    $label',
      onTap: () => onTap(value),
    );
  }
}

//
// ListTile
//
class _ListTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ListTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _itemHeight,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            HorizontalSpacer.w4(),
            SizedBox(
              width: 30,
              child: selected ? const Icon(Icons.check) : null,
            ),
            HorizontalSpacer.w4(),
            StyledText(
              label,
              style: TypographyStyle.labelMedium,
            ),
            HorizontalSpacer.w16(),
          ],
        ),
      ),
    );
  }
}

class _ExpandableList extends StatelessWidget {
  final bool expanded;
  final List<Widget> items;
  const _ExpandableList({
    required this.expanded,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: expanded ? (items.length * _itemHeight) : 0,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: items,
      ),
    );
  }
}
