import 'package:flutter/material.dart';
import 'package:workouts/core/widgets/loading/loading_indicator.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.7),
      ),
      child: const LoadingIndicator(),
    );
  }
}
