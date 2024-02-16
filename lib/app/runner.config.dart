// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../core/network/client/dio_client.dart' as _i6;
import '../core/network/client/http_client.dart' as _i8;
import '../features/auth/controllers/auth_controller.dart' as _i4;
import 'runner.dart' as _i14;
import 'settings/settings_controller.dart' as _i13;
import 'theme/data/theme_service.dart' as _i10;
import 'theme/models/app_color_scheme.dart' as _i11;
import 'theme/models/app_text_themes.dart' as _i3;
import 'theme/models/app_theme.dart' as _i12;
import 'theme/models/color_pallet.dart' as _i5;

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
  gh.singleton<_i4.AuthController>(_i4.AuthController());
  gh.factory<_i5.ColorPallet>(() => _i5.ColorPallet());
  gh.singleton<_i6.DioClient>(const _i6.DioClient());
  await gh.singletonAsync<_i7.FlutterSecureStorage>(
    () => injectableModule.secureStore,
    preResolve: true,
  );
  await gh.singletonAsync<_i8.IHttpClient>(
    () => injectableModule.client,
    preResolve: true,
  );
  await gh.singletonAsync<_i9.SharedPreferences>(
    () => injectableModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i10.ThemeService>(
      _i10.ThemeService(prefs: gh<_i9.SharedPreferences>()));
  gh.factory<_i11.AppColorScheme>(
      () => _i11.BaseAppColorScheme(colorPallet: gh<_i5.ColorPallet>()));
  gh.factory<_i12.AppTheme>(() => _i12.BaseAppTheme(
        colorScheme: gh<_i11.AppColorScheme>(),
        appTextTheme: gh<_i3.AppTextTheme>(),
      ));
  gh.singleton<_i13.SettingsController>(_i13.SettingsController(
    themeService: gh<_i10.ThemeService>(),
    preferences: gh<_i9.SharedPreferences>(),
  ));
  return getIt;
}

class _$InjectableModule extends _i14.InjectableModule {}
