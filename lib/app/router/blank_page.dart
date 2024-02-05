import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:workouts/extensions/build_context_extension.dart';

@RoutePage()
class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton.tonal(
          onPressed: context.switchTheme,
          child: const Text('switch theme'),
        ),
      ),
    );
  }
}
