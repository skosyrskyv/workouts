import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workouts/core/widgets/styled_text.dart';
import 'package:workouts/core/widgets/spacers.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final TypographyStyle? titleStyle;
  final String? subtitle;
  final Widget? actionButton;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool centerTitle;
  final Widget? background;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBackButtonPressed;
  const CustomAppBar({
    super.key,
    this.title = '',
    this.titleStyle = TypographyStyle.displayLarge,
    this.subtitle,
    this.onBackButtonPressed,
    this.actionButton,
    this.background,
    this.centerTitle = false,
    this.foregroundColor,
    this.backgroundColor = Colors.transparent,
    this.automaticallyImplyLeading = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 55);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Widget buildActionButton() {
    Widget? child;

    if (widget.actionButton != null) {
      child = widget.actionButton!;
    }
    return SizedBox(
      height: 65,
      width: 65,
      child: child,
    );
  }

  Widget buildBackButton(BuildContext context, LeadingType leadingType, VoidCallback? callback, Color color) {
    return BackButton(
      color: color,
      onPressed: widget.onBackButtonPressed ?? callback,
    );
  }

  SystemUiOverlayStyle _systemOverlayStyleForBrightness(Brightness brightness, [Color? backgroundColor]) {
    final SystemUiOverlayStyle style = brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    return SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarBrightness: style.statusBarBrightness,
      statusBarIconBrightness: style.statusBarIconBrightness,
      systemStatusBarContrastEnforced: style.systemStatusBarContrastEnforced,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color backgroundColor = widget.backgroundColor ?? theme.colorScheme.primary;
    Color foregroundColor = widget.foregroundColor ??
        (backgroundColor.alpha == 0
            ? theme.colorScheme.onBackground
            : backgroundColor.computeLuminance() <= 0.5
                ? Colors.white
                : Colors.black);

    SystemUiOverlayStyle overlayStyle = _systemOverlayStyleForBrightness(Theme.of(context).brightness, backgroundColor);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.background ??
                Container(
                  color: backgroundColor,
                ),
          ),
          SafeArea(
            bottom: false,
            child: SizedBox(
              height: 55,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (Navigator.canPop(context))
                    SizedBox(
                      width: 65,
                      child: AutoLeadingButton(
                        builder: (context, type, callback) => buildBackButton(context, type, callback, foregroundColor),
                      ),
                    ),
                  if (!Navigator.canPop(context)) HorizontalSpacer(widget.centerTitle ? 65 : 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: widget.centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          widget.title,
                          style: widget.titleStyle ?? TypographyStyle.headerMedium,
                          align: TextAlign.center,
                          bold: true,
                          color: foregroundColor,
                        ),
                        if (widget.subtitle != null)
                          StyledText(
                            widget.subtitle,
                            style: TypographyStyle.bodyMedium,
                            align: TextAlign.center,
                            color: foregroundColor,
                          )
                      ],
                    ),
                  ),
                  buildActionButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
