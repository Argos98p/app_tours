import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

/*
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.teal,
    appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );*/

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 22.0,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle1: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      displayLarge: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      displayMedium: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      displaySmall: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline1: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline3: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline4: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline5: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline6: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headlineLarge: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headlineMedium: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headlineSmall: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}
