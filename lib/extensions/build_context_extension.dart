import 'package:flutter/material.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/app/settings/settings_controller.dart';

extension BuildContextExtension on BuildContext {
  ThemeMode get themeMode => getIt<SettingsController>().themeMode;

  void switchTheme() {
    getIt<SettingsController>().setTheme(themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
