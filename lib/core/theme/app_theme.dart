import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.fromSwatch().copyWith(background: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.blue,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    labelStyle: TextStyle(color: Colors.blue),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blue, // updated from primary
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // updated from primary
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blue, // updated from primary
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.blueGrey,
  colorScheme: ColorScheme.fromSwatch().copyWith(background: Colors.black),
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.tealAccent),
    ),
    labelStyle: TextStyle(color: Colors.tealAccent),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blueGrey, // updated from primary
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey, // updated from primary
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blueGrey, // updated from primary
    ),
  ),
);
