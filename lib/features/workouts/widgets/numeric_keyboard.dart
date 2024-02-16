import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workouts/core/widgets/styled_text.dart';

class NumericKeyboard extends StatefulWidget {
  final FocusScopeNode focusScopeNode;
  final VoidCallback onAdd;
  final VoidCallback onCloseKeyboard;
  const NumericKeyboard({
    super.key,
    required this.focusScopeNode,
    required this.onAdd,
    required this.onCloseKeyboard,
  });

  @override
  State<NumericKeyboard> createState() => NumericKeyboardState();
}

class NumericKeyboardState extends State<NumericKeyboard> {
  // Find text field widget
  AutoSizeTextField? _findFocusedTextField(BuildContext context) {
    return widget.focusScopeNode.focusedChild?.context?.findAncestorWidgetOfExactType<AutoSizeTextField>();
  }

  void _nextFocus() {
    final currentFieldController = _findFocusedTextField(context)?.controller;
    // Check if the last symbol is comma "," and remove it;
    if (currentFieldController != null) {
      if (currentFieldController.text.indexOf(',') == currentFieldController.text.length - 1) {
        currentFieldController.text = currentFieldController.text.replaceAll(',', '');
      }
    }
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
      try {
        // Drop updating if value is comma and text must contain only digits
        if (textField!.inputFormatters != null) {
          if (textField.inputFormatters!.contains(FilteringTextInputFormatter.digitsOnly) && value == ',') return;
        }
        // Check if text not selected
        if (!controller.selection.isCollapsed) {
          controller.text = '';
        }

        // Check if 0 is single digit in the text and was typed comma
        if (controller.text == '0' && value != ',') {
          controller.text = value;
          return;
        }

        // Check if comma is first typed symbol
        if (value == ',' && controller.text.isEmpty) {
          controller.text = '0$value';
          return;
        }

        // Check if comma already exist in the text
        if (value == ',' && controller.text.contains(',')) return;

        // Check the max text length, except for the comma
        if (controller.text.replaceAll(',', '').length >= 4) return;

        controller.text = '${controller.text}$value';
      } catch (e) {
        print(e);
      }
    }
  }

  void _delete(BuildContext context) {
    final controller = _findFocusedTextField(context)?.controller;
    if (controller != null) {
      try {
        final length = controller.text.length;
        if (length > 1) {
          controller.text = controller.text.substring(0, length - 1);
        } else {
          controller.text = '0';
        }
      } catch (e) {
        print(e);
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
                  value: ',',
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
                  onTap: widget.onAdd,
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
