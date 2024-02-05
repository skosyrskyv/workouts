import 'package:auto_route/auto_route.dart';
import 'package:workouts/app/router/blank_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      initial: true,
      page: BlankRoute.page,
    ),
  ];
}
