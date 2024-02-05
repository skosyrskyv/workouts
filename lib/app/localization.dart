import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const _russianLocale = Locale('ru', 'RU');
const _englishLocale = Locale('en', 'US');

class AppLocalizations {
  static const Locale russian = _russianLocale;
  static const Locale english = _englishLocale;

  static const List<Locale> supportedLocales = [_englishLocale];

  static const path = 'assets/translations';
}

class LocalizationProvider extends StatelessWidget {
  final Widget child;
  const LocalizationProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: AppLocalizations.path,
      startLocale: AppLocalizations.english,
      fallbackLocale: AppLocalizations.english,
      supportedLocales: AppLocalizations.supportedLocales,
      child: child,
    );
  }
}
