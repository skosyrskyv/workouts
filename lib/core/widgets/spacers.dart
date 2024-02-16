import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double height;
  const VerticalSpacer(this.height, {Key? key}) : super(key: key);

  factory VerticalSpacer.h2() {
    return const VerticalSpacer(2);
  }

  factory VerticalSpacer.h4() {
    return const VerticalSpacer(4);
  }

  factory VerticalSpacer.h8() {
    return const VerticalSpacer(8);
  }

  factory VerticalSpacer.h10() {
    return const VerticalSpacer(10);
  }

  factory VerticalSpacer.h16() {
    return const VerticalSpacer(16);
  }

  factory VerticalSpacer.h20() {
    return const VerticalSpacer(20);
  }

  factory VerticalSpacer.h32() {
    return const VerticalSpacer(32);
  }

  factory VerticalSpacer.h64() {
    return const VerticalSpacer(64);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HorizontalSpacer extends StatelessWidget {
  final double width;
  const HorizontalSpacer(
    this.width, {
    Key? key,
  }) : super(key: key);

  factory HorizontalSpacer.w2() {
    return const HorizontalSpacer(2);
  }

  factory HorizontalSpacer.w4() {
    return const HorizontalSpacer(4);
  }

  factory HorizontalSpacer.w8() {
    return const HorizontalSpacer(8);
  }

  factory HorizontalSpacer.w10() {
    return const HorizontalSpacer(10);
  }

  factory HorizontalSpacer.w20() {
    return const HorizontalSpacer(20);
  }

  factory HorizontalSpacer.w16() {
    return const HorizontalSpacer(16);
  }

  factory HorizontalSpacer.w32() {
    return const HorizontalSpacer(32);
  }

  factory HorizontalSpacer.w64() {
    return const HorizontalSpacer(64);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

enum SafeAreaSide {
  top,
  bottom,
  right,
  left,
}

class SafeAreaSpacer extends StatelessWidget {
  final SafeAreaSide side;
  const SafeAreaSpacer({
    super.key,
    required this.side,
  });

  factory SafeAreaSpacer.top() {
    return const SafeAreaSpacer(
      side: SafeAreaSide.top,
    );
  }

  factory SafeAreaSpacer.bottom() {
    return const SafeAreaSpacer(
      side: SafeAreaSide.bottom,
    );
  }

  factory SafeAreaSpacer.left() {
    return const SafeAreaSpacer(
      side: SafeAreaSide.left,
    );
  }

  factory SafeAreaSpacer.right() {
    return const SafeAreaSpacer(
      side: SafeAreaSide.right,
    );
  }

  double calculateHorizontalPadding(BuildContext context) {
    final safeAreaPadding = MediaQuery.of(context).viewPadding;
    switch (side) {
      case SafeAreaSide.left:
        return safeAreaPadding.left;
      case SafeAreaSide.right:
        return safeAreaPadding.right;
      default:
        return 0;
    }
  }

  double calculateVerticalPadding(BuildContext context) {
    final safeAreaPadding = MediaQuery.of(context).viewPadding;
    switch (side) {
      case SafeAreaSide.top:
        return safeAreaPadding.top;
      case SafeAreaSide.bottom:
        return safeAreaPadding.bottom;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: calculateVerticalPadding(context),
      width: calculateHorizontalPadding(context),
    );
  }
}
