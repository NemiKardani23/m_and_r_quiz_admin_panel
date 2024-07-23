import 'package:flutter/material.dart';

class AdaptiveTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    hintColor: Colors.orange,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
    // Add other light mode-specific properties here
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    hintColor: Colors.deepOrange,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
    // Add other dark mode-specific properties here
  );

  static ThemeData getTheme({bool isDarkMode = false}) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
