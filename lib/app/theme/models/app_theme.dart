import 'package:flutter/material.dart';
import 'package:workouts/app/theme/models/app_color_scheme.dart';
import 'package:workouts/app/theme/models/app_text_themes.dart';
import 'package:workouts/app/theme/models/color_pallet.dart';

import 'package:injectable/injectable.dart';

abstract class AppTheme {
  const AppTheme({
    required AppColorScheme colorScheme,
    required AppTextTheme appTextTheme,
  });

  ThemeData get lightTheme;
  ThemeData get darkTheme;
}

@Injectable(as: AppTheme)
class BaseAppTheme implements AppTheme {
  final AppColorScheme _colorScheme;
  final AppTextTheme _textScheme;

  BaseAppTheme({
    required AppColorScheme colorScheme,
    required AppTextTheme appTextTheme,
  })  : _colorScheme = colorScheme,
        _textScheme = appTextTheme;

  @override
  ThemeData get lightTheme => ThemeData(
        primaryColor: _colorScheme.lightScheme.primary,
        canvasColor: _colorScheme.lightScheme.primary,
        colorScheme: _colorScheme.lightScheme,
        textTheme: _textScheme.lightThemeTextThemes,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      );

  @override
  ThemeData get darkTheme => ThemeData(
        primaryColor: _colorScheme.darkScheme.primary,
        canvasColor: _colorScheme.darkScheme.primary,
        colorScheme: _colorScheme.darkScheme,
        textTheme: _textScheme.darkThemeTextThemes,
        scaffoldBackgroundColor: ColorPallet.black,
      );
}
