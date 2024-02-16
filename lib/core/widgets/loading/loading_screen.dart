import 'package:flutter/material.dart';
import 'package:workouts/core/widgets/loading/loading.dart';
import 'package:workouts/core/widgets/screen/screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Loading(),
    );
  }
}
