// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../core/network/client/dio_client.dart' as _i5;
import '../core/network/client/http_client.dart' as _i7;
import 'runner.dart' as _i13;
import 'settings/settings_controller.dart' as _i12;
import 'theme/data/theme_service.dart' as _i9;
import 'theme/models/app_color_scheme.dart' as _i10;
import 'theme/models/app_text_themes.dart' as _i3;
import 'theme/models/app_theme.dart' as _i11;
import 'theme/models/color_pallet.dart' as _i4;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectableModule = _$InjectableModule();
  gh.factory<_i3.AppTextTheme>(() => _i3.BaseAppTextTheme());
  gh.factory<_i4.ColorPallet>(() => _i4.ColorPallet());
  gh.singleton<_i5.DioClient>(const _i5.DioClient());
  await gh.singletonAsync<_i6.FlutterSecureStorage>(
    () => injectableModule.secureStore,
    preResolve: true,
  );
  await gh.singletonAsync<_i7.IHttpClient>(
    () => injectableModule.client,
    preResolve: true,
  );
  await gh.singletonAsync<_i8.SharedPreferences>(
    () => injectableModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i9.ThemeService>(
      _i9.ThemeService(prefs: gh<_i8.SharedPreferences>()));
  gh.factory<_i10.AppColorScheme>(
      () => _i10.BaseAppColorScheme(colorPallet: gh<_i4.ColorPallet>()));
  gh.factory<_i11.AppTheme>(() => _i11.BaseAppTheme(
        colorScheme: gh<_i10.AppColorScheme>(),
        appTextTheme: gh<_i3.AppTextTheme>(),
      ));
  gh.singleton<_i12.SettingsController>(_i12.SettingsController(
    themeService: gh<_i9.ThemeService>(),
    preferences: gh<_i8.SharedPreferences>(),
  ));
  return getIt;
}

class _$InjectableModule extends _i13.InjectableModule {}
