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
    BlankRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlankPage(),
      );
    }
  };
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
