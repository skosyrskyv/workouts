import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ColorPallet {
  // Blue-green shades
  static const Color paleTurquoise = Color(0xFFD6E6E8);
  static const Color teal = Color(0xFF34828D);
  static const Color darkTeal = Color(0xFF2A6871);

  // Red shades
  static const Color lightCoral = Color(0xFFFADCDD);
  static const Color red = Color(0xFFE45155);
  static const Color darkRed = Color(0xFFB64144);
  static const Color mistyRose = Color(0xFFFADEDD);
  static const Color indianRed = Color(0xFFE85C55);
  static const Color fireBrick = Color(0xFFBA4A44);

  // Green shades
  static const Color paleGreen = Color(0xFFE4F4DC);
  static const Color limeGreen = Color(0xFF77C950);
  static const Color forestGreen = Color(0xFF5FA140);

  // Core colors
  static const Color black = Color(0xFF292929);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF666666);
}
