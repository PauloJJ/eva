import 'package:flutter/material.dart';

class AppTextStyleTheme {
  static TextStyle get h1 => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get h3 => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get title => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get title02 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );

  static TextStyle get subTitle => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade700,
  );

  static TextStyle get caption => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
}
