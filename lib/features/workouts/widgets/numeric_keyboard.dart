import 'package:flutter/material.dart';
import 'package:workouts/core/widgets/styled_text.dart';

class NumericKeyboard extends StatefulWidget {
  final FocusScopeNode focusScopeNode;
  final VoidCallback onAddSet;
  final VoidCallback onCloseKeyboard;
  const NumericKeyboard({
    super.key,
    required this.focusScopeNode,
    required this.onAddSet,
    required this.onCloseKeyboard,
  });

  @override
  State<NumericKeyboard> createState() => NumericKeyboardState();
}

class NumericKeyboardState extends State<NumericKeyboard> {
  // Find text field widget
  TextField? _findFocusedTextField(BuildContext context) {
    return widget.focusScopeNode.focusedChild?.context?.findAncestorWidgetOfExactType<TextField>();
  }

  void _nextFocus() {
    // Change focus
    widget.focusScopeNode.nextFocus();
    final textFieldController = _findFocusedTextField(context)?.controller;
    // Select all text
    if (textFieldController != null) {
      textFieldController.selection = TextSelection(baseOffset: 0, extentOffset: textFieldController.text.length);
    }
  }

  void _addValue(BuildContext context, String value) {
    final textField = _findFocusedTextField(context);
    final controller = textField?.controller;
    if (controller != null) {
      TextEditingValue formattedValue = controller.value.copyWith(text: controller.text + value);
      try {
        if (textField!.inputFormatters != null) {
          formattedValue = textField.inputFormatters!.map((e) => e.formatEditUpdate(controller.value, formattedValue)).last;
        }
        controller.text = formattedValue.text;
      } catch (e) {
        print(e);
      }
    }
  }

  void _delete(BuildContext context) {
    final field = _findFocusedTextField(context);
    final controller = field?.controller;
    if (controller != null) {
      final length = controller.text.length;
      try {
        var result = const TextEditingValue();
        final newValue = controller.value.copyWith(
          text: length > 1 ? controller.text.substring(0, length - 1) : '',
        );
        if (field!.inputFormatters != null) {
          result = field.inputFormatters!.first.formatEditUpdate(controller.value, newValue);
        }
        controller.text = result.text;
      } catch (e) {
        print('DELETE ERROR: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _KeyboardKey(value: '1', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(value: '4', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(value: '7', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(
                  value: '.',
                  onTap: (value) => _addValue(context, value),
                  flex: 3,
                ),
              ],
            ),
          ),
          const _VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                _KeyboardKey(value: '2', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(value: '5', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(value: '8', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(
                  value: '0',
                  onTap: (value) => _addValue(context, value),
                  flex: 3,
                ),
              ],
            ),
          ),
          const _VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                _KeyboardKey(value: '3', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(value: '6', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(value: '9', onTap: (value) => _addValue(context, value)),
                const _HorizontalDivider(),
                _KeyboardKey(
                  value: 'delete',
                  onTap: (s) => _delete(context),
                  flex: 3,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: Column(
              children: [
                _NextFocusButton(
                  onTap: _nextFocus,
                ),
                _AddKeyboardButton(
                  onTap: widget.onAddSet,
                ),
                _CloseKeyboardButton(
                  onTap: widget.onCloseKeyboard,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//
// ADD KEYBOARD BUTTON
//
class _AddKeyboardButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddKeyboardButton({
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

//
// CLOSE KEYBOARD BUTTON
//
class _CloseKeyboardButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseKeyboardButton({
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Icon(
              Icons.keyboard_double_arrow_down_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

//
// NEXT FOCUS BUTTON
//
class _NextFocusButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NextFocusButton({
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Icon(
              Icons.navigate_next_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

//
// KEYBOARD KEY
//
class _KeyboardKey extends StatelessWidget {
  final String value;
  final Function(String value)? onTap;
  final int flex;
  const _KeyboardKey({
    required this.value,
    required this.onTap,
    this.flex = 2,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Material(
        color: Theme.of(context).colorScheme.background,
        child: InkWell(
          onTap: onTap != null ? () => onTap!(value) : null,
          child: Center(
            child: StyledText(
              value,
              style: TypographyStyle.labelMedium,
              fontWeight: FontWeight.w500,
              highlighted: onTap == null,
            ),
          ),
        ),
      ),
    );
  }
}

//
// HORIZONTAL DIVIDER
//
class _HorizontalDivider extends StatelessWidget {
  const _HorizontalDivider();
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
    );
  }
}

//
// VERTICAL DIVIDER
//
class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();
  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: 1,
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
    );
  }
}
