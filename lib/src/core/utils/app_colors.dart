import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color white = Color(0xFFFFFFFF);
  static const Color light = Color(0xFFFAFAFA);
  static const Color black = Color(0xFF000000);
  static const Color blackWith40Opacity = Color(0x66000000);
  static const Color blue = Color(0xFF3797EF);
  static const Color lightBlue = Color(0xFF3797EF);
  static const Color red = Color(0xFFFF0000);
  static const Color princetonOrange = Color(0xFFF58529);
  static const Color vividCerise = Color(0xFFDD2A7B);
  static const Color grape = Color(0xFF8134AF);
  static const Color iris = Color(0xFF515BD4);
  static Gradient gradient = const RadialGradient(
    center: Alignment.bottomCenter,
    focalRadius: 50.0,
    radius: 2.5,
    colors: [princetonOrange, vividCerise, grape, iris],
  );
  static const List<Color> storyTextColors = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.deepPurple,
    Colors.black,
    Colors.pink,
    Colors.teal,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.cyan,
  ];
}
