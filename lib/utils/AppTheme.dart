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
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(
        color: Colors.white,
        fontSize: 22.0,
      ),
      titleMedium: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      titleSmall: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle1: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      subtitle2: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      displayLarge: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      displayMedium: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      displaySmall: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline1: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline2: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline3: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline4: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline5: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headline6: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headlineLarge: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headlineMedium: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      headlineSmall: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}
