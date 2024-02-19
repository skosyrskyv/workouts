import 'package:flutter/material.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/core/widgets/styled_text.dart';

class MenuDialog extends StatelessWidget {
  final Alignment alignment;
  final List<MenuDialogItem> items;
  const MenuDialog({
    super.key,
    this.alignment = Alignment.bottomRight,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => appRouter.pop(),
      child: Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: alignment,
          child: Container(
            height: items.length * 50,
            width: 300,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20)),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: items,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuDialogItem extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final bool notAvailable;
  final VoidCallback? onTap;
  const MenuDialogItem({
    super.key,
    required this.label,
    this.icon,
    this.notAvailable = false,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: notAvailable ? () {} : onTap,
      child: Stack(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 30, right: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: StyledText(
                    label,
                    color: color,
                    style: TypographyStyle.labelSmall,
                  ),
                ),
                notAvailable
                    ? const Icon(
                        Icons.lock,
                        size: 20,
                        color: Colors.grey,
                      )
                    : Icon(
                        icon,
                        size: 20,
                        color: color ?? Theme.of(context).colorScheme.onSurface,
                      ),
              ],
            ),
          ),
          if (notAvailable)
            Container(
              height: 50,
              color: Theme.of(context).colorScheme.surface.withOpacity(.5),
              alignment: Alignment.centerRight,
            ),
        ],
      ),
    );
  }
}
