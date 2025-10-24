import 'package:flutter/material.dart';

abstract final class IColors {
  static const MaterialColor primary = MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFFCEAEA),
    100: Color(0xFFF7BEBE),
    200: Color(0xFFF39E9E),
    300: Color(0xFFED7272),
    400: Color(0xFFE95656),
    500: Color(_primaryValue),
    600: Color(0xFFCF2828),
    700: Color(0xFFA21F1F),
    800: Color(0xFF7D1818),
    900: Color(0xFF601212),
  });
  static const int _primaryValue = 0xFFE42C2C;

  static const MaterialColor secondary = MaterialColor(_secondaryValue, <int, Color>{
    50: Color(0xFFE9E9E9),
    100: Color(0xFFBBBBBB),
    200: Color(0xFF9A9A9A),
    300: Color(0xFF6C6C6C),
    400: Color(0xFF4F4F4F),
    500: Color(_secondaryValue),
    600: Color(0xFF191919),
    700: Color(0xFF131313),
    800: Color(0xFF0F0F0F),
    900: Color(0xFF232323),
  });
  static const int _secondaryValue = 0xFF202020;
}
