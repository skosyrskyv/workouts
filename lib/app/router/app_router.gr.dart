// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    BlankRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlankPage(),
      );
    },
    ExerciseCreatingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExerciseCreatingScreen(),
      );
    },
    ExercisesRoute.name: (routeData) {
      final args = routeData.argsAs<ExercisesRouteArgs>(
          orElse: () => const ExercisesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExercisesScreen(
          key: args.key,
          initialSelected: args.initialSelected,
          onDone: args.onDone,
        ),
      );
    },
    WorkoutRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutScreen(
          key: args.key,
          uuid: args.uuid,
          date: args.date,
        ),
      );
    },
    WorkoutsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkoutsScreen(),
      );
    },
  };
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BlankPage]
class BlankRoute extends PageRouteInfo<void> {
  const BlankRoute({List<PageRouteInfo>? children})
      : super(
          BlankRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlankRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseCreatingScreen]
class ExerciseCreatingRoute extends PageRouteInfo<void> {
  const ExerciseCreatingRoute({List<PageRouteInfo>? children})
      : super(
          ExerciseCreatingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseCreatingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExercisesScreen]
class ExercisesRoute extends PageRouteInfo<ExercisesRouteArgs> {
  ExercisesRoute({
    Key? key,
    Set<ExerciseType> initialSelected = const {},
    dynamic Function(Set<ExerciseType>)? onDone,
    List<PageRouteInfo>? children,
  }) : super(
          ExercisesRoute.name,
          args: ExercisesRouteArgs(
            key: key,
            initialSelected: initialSelected,
            onDone: onDone,
          ),
          initialChildren: children,
        );

  static const String name = 'ExercisesRoute';

  static const PageInfo<ExercisesRouteArgs> page =
      PageInfo<ExercisesRouteArgs>(name);
}

class ExercisesRouteArgs {
  const ExercisesRouteArgs({
    this.key,
    this.initialSelected = const {},
    this.onDone,
  });

  final Key? key;

  final Set<ExerciseType> initialSelected;

  final dynamic Function(Set<ExerciseType>)? onDone;

  @override
  String toString() {
    return 'ExercisesRouteArgs{key: $key, initialSelected: $initialSelected, onDone: $onDone}';
  }
}

/// generated route for
/// [WorkoutScreen]
class WorkoutRoute extends PageRouteInfo<WorkoutRouteArgs> {
  WorkoutRoute({
    Key? key,
    String? uuid,
    required DateTime date,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutRoute.name,
          args: WorkoutRouteArgs(
            key: key,
            uuid: uuid,
            date: date,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutRoute';

  static const PageInfo<WorkoutRouteArgs> page =
      PageInfo<WorkoutRouteArgs>(name);
}

class WorkoutRouteArgs {
  const WorkoutRouteArgs({
    this.key,
    this.uuid,
    required this.date,
  });

  final Key? key;

  final String? uuid;

  final DateTime date;

  @override
  String toString() {
    return 'WorkoutRouteArgs{key: $key, uuid: $uuid, date: $date}';
  }
}

/// generated route for
/// [WorkoutsScreen]
class WorkoutsRoute extends PageRouteInfo<void> {
  const WorkoutsRoute({List<PageRouteInfo>? children})
      : super(
          WorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
