import 'package:flutter/material.dart';
import 'package:workouts/constants/shared_preferences_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class ThemeService {
  final SharedPreferences prefs;
  ThemeService({required this.prefs});

  ThemeMode themeMode() {
    final String? themeMode = prefs.getString(SharedPreferencesKeys.theme);

    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode mode) {
    prefs.setString(SharedPreferencesKeys.theme, mode.name);
  }
}
