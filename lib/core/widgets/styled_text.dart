import 'package:flutter/material.dart';

enum TypographyStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headerMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class StyledText extends StatelessWidget {
  final String? text;
  final TypographyStyle style;
  final Color? color;
  final TextAlign? align;
  final bool highlighted;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final bool underlined;
  final bool bold;
  final bool selectable;
  const StyledText(
    this.text, {
    super.key,
    this.style = TypographyStyle.bodyMedium,
    this.color,
    this.align,
    this.maxLines,
    this.fontSize,
    this.overflow,
    this.fontWeight = FontWeight.normal,
    this.underlined = false,
    this.highlighted = false,
    this.bold = false,
    this.selectable = false,
  });

  TextStyle? configureStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? textStyle = textTheme.bodyMedium;
    Color textColor = color == null
        ? Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white
        : color!;

    switch (style) {
      case TypographyStyle.displayLarge:
        textStyle = textTheme.displayLarge;
        break;
      case TypographyStyle.displayMedium:
        textStyle = textTheme.displayMedium;
        break;
      case TypographyStyle.displaySmall:
        textStyle = textTheme.displaySmall;
        break;
      case TypographyStyle.headlineLarge:
        textStyle = textTheme.headlineLarge;
        break;
      case TypographyStyle.headerMedium:
        textStyle = textTheme.headlineMedium;
        break;
      case TypographyStyle.headlineSmall:
        textStyle = textTheme.headlineSmall;
        break;
      case TypographyStyle.titleLarge:
        textStyle = textTheme.titleLarge;
        break;
      case TypographyStyle.titleMedium:
        textStyle = textTheme.titleMedium;
        break;
      case TypographyStyle.titleSmall:
        textStyle = textTheme.titleSmall;
        break;
      case TypographyStyle.labelLarge:
        textStyle = textTheme.labelLarge;
        break;
      case TypographyStyle.labelMedium:
        textStyle = textTheme.labelMedium;
        break;
      case TypographyStyle.labelSmall:
        textStyle = textTheme.labelSmall;
        break;
      case TypographyStyle.bodyLarge:
        textStyle = textTheme.bodyLarge;
        break;
      case TypographyStyle.bodyMedium:
        textStyle = textTheme.bodyMedium;
        break;
      case TypographyStyle.bodySmall:
        textStyle = textTheme.bodySmall;
        break;
      default:
        textStyle = textTheme.bodyMedium;
    }
    var result = textStyle?.copyWith(
      color: highlighted ? textColor.withOpacity(.5) : textColor,
      fontSize: fontSize,
      overflow: overflow,
      decoration: underlined ? TextDecoration.underline : null,
      fontWeight: bold ? FontWeight.bold : fontWeight,
    );
    return DefaultTextStyle.of(context).style.merge(result);
  }

  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return SelectableText(
        text ?? '',
        style: configureStyle(context),
        maxLines: maxLines,
        textAlign: align,
      );
    }
    return Text(
      text ?? '',
      style: configureStyle(context),
      maxLines: maxLines,
      textAlign: align,
    );
  }
}
