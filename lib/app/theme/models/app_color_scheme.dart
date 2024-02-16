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
        primary: Color.fromARGB(255, 156, 89, 255),
        onPrimary: ColorPallet.white,
        primaryContainer: ColorPallet.purpleLight,
        onPrimaryContainer: ColorPallet.purpleDark,
        secondary: Color.fromARGB(255, 255, 144, 70),
        onSecondary: ColorPallet.white,
        secondaryContainer: Color.fromARGB(255, 236, 223, 255),
        onSecondaryContainer: Color.fromARGB(255, 148, 77, 255),
        tertiary: ColorPallet.limeGreen,
        onTertiary: ColorPallet.white,
        tertiaryContainer: ColorPallet.paleGreen,
        onTertiaryContainer: ColorPallet.forestGreen,
        error: ColorPallet.indianRed,
        onError: ColorPallet.white,
        errorContainer: ColorPallet.mistyRose,
        onErrorContainer: ColorPallet.fireBrick,
        onBackground: ColorPallet.black,
        background: Color.fromARGB(255, 245, 245, 245),
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
