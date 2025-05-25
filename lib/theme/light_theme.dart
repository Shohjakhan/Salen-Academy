import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFFffa130),
  scaffoldBackgroundColor: const Color(0xFFE3E6EC),
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
);
