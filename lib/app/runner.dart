import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workouts/app/app.dart';
import 'package:workouts/app/app_loading.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/localization.dart';
import 'package:workouts/app/runner.config.dart';
import 'package:workouts/core/network/client/dio_client.dart';
import 'package:workouts/core/network/client/http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouts/firebase_options.dart';

final getIt = GetIt.instance;

class Runner {
  static Future<void> run() async {
    runZonedGuarded(_runApp, _errorHandler);
  }

  static Future<void> _initializeFlutterPluginsAndDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await configureDependencies();
  }

  static Future<void> _initializeServices() async {
    // TODO: Add services init.
  }

  static _runApp() async {
    runApp(const AppLoading());
    await _initializeFlutterPluginsAndDependencies();
    await _initializeServices();
    runApp(
      const LocalizationProvider(
        child: App(),
      ),
    );
  }

  static Future<void> _errorHandler(exception, stacktrace) async {
    // TODO: Add sentry.
  }
}

// GET IT INITIALIZATION
@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
@module
abstract class InjectableModule {
  @preResolve
  @singleton
  Future<FlutterSecureStorage> get secureStore async => const FlutterSecureStorage();

  @preResolve
  @singleton
  Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();

  @preResolve
  @singleton
  Future<IHttpClient> get client async => const DioClient();
}

Future<void> configureDependencies() async {
  await $initGetIt(getIt);

  getIt.registerSingleton(AppDatabase());
}
