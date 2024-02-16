import 'package:flutter/material.dart';
import 'package:workouts/core/widgets/loading/loading.dart';

class Screen extends StatelessWidget {
  final Widget body;

  final Key? scaffoldKey;

  /// App bar text.
  final String? title;

  /// Custom app bar.
  final PreferredSizeWidget? appBar;

  /// Custom bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Use safe area
  final bool safeArea;

  /// Show loading indicator body instead
  final bool loading;

  /// Widget that will placed under main content
  final Widget background;

  final Widget? floatingActionButton;

  final bool resizeToAvoidBottomInset;

  final bool extendBodyBehindAppBar;

  final bool placeBodyUnderAppBar;

  final bool extendBodyBehindBottomNavbar;

  const Screen({
    super.key,
    this.scaffoldKey,
    this.title,
    this.appBar,
    this.bottomNavigationBar,
    this.safeArea = false,
    this.loading = false,
    this.background = const ThemeBackground(),
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.placeBodyUnderAppBar = false,
    this.extendBodyBehindBottomNavbar = false,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      Widget result = body;
      if (safeArea) {
        result = SafeArea(child: body);
      }

      return result;
    }

    return Stack(
      children: [
        Positioned.fill(
          child: background,
        ),
        Positioned.fill(
          child: Scaffold(
            key: scaffoldKey,
            appBar: placeBodyUnderAppBar ? null : appBar,
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            bottomNavigationBar: extendBodyBehindBottomNavbar ? null : bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            body: buildBody(),
          ),
        ),
        if (placeBodyUnderAppBar && appBar != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: appBar!,
          ),
        if (extendBodyBehindBottomNavbar && bottomNavigationBar != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: bottomNavigationBar!,
            ),
          ),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !loading,
            child: AnimatedOpacity(
              opacity: loading ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Loading(),
            ),
          ),
        ),
      ],
    );
  }
}

class ThemeBackground extends StatelessWidget {
  const ThemeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
    );
  }
}
