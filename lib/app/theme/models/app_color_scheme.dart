import 'package:flutter/material.dart';
import 'package:workouts/app/theme/models/color_pallet.dart';
import 'package:injectable/injectable.dart';

abstract class AppColorScheme {
  ColorScheme get lightScheme;
  ColorScheme get darkScheme;
}

@Injectable(as: AppColorScheme)
class BaseAppColorScheme implements AppColorScheme {
  BaseAppColorScheme({required ColorPallet colorPallet});
  @override
  ColorScheme get lightScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: ColorPallet.red,
        onPrimary: ColorPallet.white,
        primaryContainer: ColorPallet.lightCoral,
        onPrimaryContainer: ColorPallet.darkRed,
        secondary: ColorPallet.teal,
        onSecondary: ColorPallet.white,
        secondaryContainer: ColorPallet.paleTurquoise,
        onSecondaryContainer: ColorPallet.darkTeal,
        tertiary: ColorPallet.limeGreen,
        onTertiary: ColorPallet.white,
        tertiaryContainer: ColorPallet.paleGreen,
        onTertiaryContainer: ColorPallet.forestGreen,
        error: ColorPallet.indianRed,
        onError: ColorPallet.white,
        errorContainer: ColorPallet.mistyRose,
        onErrorContainer: ColorPallet.fireBrick,
        onBackground: ColorPallet.black,
        background: Color(0xFFF9F9F9),
        surface: ColorPallet.white,
        onSurface: ColorPallet.black,
      );

  @override
  ColorScheme get darkScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: ColorPallet.teal,
        onPrimary: ColorPallet.white,
        primaryContainer: ColorPallet.paleTurquoise,
        onPrimaryContainer: ColorPallet.darkTeal,
        secondary: ColorPallet.red,
        onSecondary: ColorPallet.white,
        secondaryContainer: ColorPallet.lightCoral,
        onSecondaryContainer: ColorPallet.darkRed,
        tertiary: ColorPallet.limeGreen,
        onTertiary: ColorPallet.white,
        tertiaryContainer: ColorPallet.paleGreen,
        onTertiaryContainer: ColorPallet.forestGreen,
        error: ColorPallet.indianRed,
        onError: ColorPallet.white,
        errorContainer: ColorPallet.mistyRose,
        onErrorContainer: ColorPallet.fireBrick,
        background: Color(0xFFF9F9F9),
        onBackground: ColorPallet.black,
        surface: ColorPallet.white,
        onSurface: ColorPallet.black,
      );
}
