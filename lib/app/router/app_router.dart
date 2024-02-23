import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:workouts/app/database/models/exercise_type.dart';
import 'package:workouts/app/router/blank_page.dart';
import 'package:workouts/features/auth/screen/auth_screen.dart';
import 'package:workouts/features/workouts/screens/exercise_types_screen.dart';
import 'package:workouts/features/workouts/screens/workout_screen.dart';
import 'package:workouts/features/workouts/screens/workouts_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: WorkoutsRoute.page,
    ),
    AutoRoute(
      path: '/workout/exercises-types',
      page: ExercisesRoute.page,
    ),
    AutoRoute(
      path: '/workout',
      page: WorkoutRoute.page,
    ),
  ];
}
