import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouts/app/localization.dart';
import 'package:workouts/app/theme/data/theme_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class SettingsController extends ChangeNotifier {
  final ThemeService themeService;
  final SharedPreferences preferences;
  SettingsController({
    required this.themeService,
    required this.preferences,
  });

  Locale locale = AppLocalizations.russian;
  ThemeMode themeMode = ThemeMode.system;

  Future<void> init() async {
    themeMode = themeService.themeMode();
    try {
      final prefsData = preferences.getString('locale');
      if (prefsData == null) throw Exception('SharedPreferences error: "locale" key doesn`t exist');
      locale = prefsData.toLocale();
    } catch (e) {
      locale = AppLocalizations.russian;
    }
  }

  Future setLocale(BuildContext context, Locale l) async {
    locale = l;
    await context.setLocale(l);
    notifyListeners();
  }

  void setTheme(ThemeMode? mode) {
    if (mode == null) return;
    themeService.setThemeMode(mode);
    themeMode = mode;
    notifyListeners();
  }
}
