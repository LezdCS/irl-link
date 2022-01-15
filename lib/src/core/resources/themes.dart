import 'package:flutter/material.dart';

class Themes {
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xFF0e0e10),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Color(0xFF18181b),
    ),
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    primaryIconTheme: IconThemeData(color: Colors.white),
  );

  final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xFFffffff),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Color(0xFFefeff1),
    ),
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
    primaryIconTheme: IconThemeData(color: Colors.black),
  );
}
