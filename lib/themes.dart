import 'package:flutter/material.dart';

class Themes {
  // Dark mode colors
  static const Color darkColorPrimary = Color.fromARGB(255, 0, 90, 80);  // Rich Teal
  static const Color darkColorAccent = Color(0xFF26C6DA);   // Vibrant Cyan
  static const Color darkBG = Color(0xFF263238);            // Rich Dark Blue-Gray
  static const Color darkDarkBG = Color(0xFF1A1A1A);        // Very Dark Gray
  static const Color darkTextColor = Colors.white;          // White text

  // Light mode colors
  static const Color lightColorPrimary = Color.fromARGB(255, 0, 90, 80); // Teal
  static const Color lightColorAccent = Color(0xFF00BCD4);  // Cyan
  static const Color lightBG = Color(0xFFF5F5F5);          // Light Gray
  static const Color lightDarkBG = Color(0xFFE0E0E0);      // Medium Gray
  static const Color lightTextColor = Color(0xFF212121);    // Black text

  static ThemeData dark = ThemeData.dark().copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: darkColorPrimary, unselectedItemColor: darkDarkBG, selectedItemColor: darkColorAccent),
    cardTheme: const CardTheme(color: darkColorPrimary,),
    iconTheme: const IconThemeData(
      color: darkColorAccent,
    ),
    scaffoldBackgroundColor: darkDarkBG,
    primaryColor: darkColorPrimary,
    colorScheme: const ColorScheme.dark(
      primary: darkColorPrimary,
      secondary: darkColorAccent,
      surface: darkBG,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: darkColorAccent,),
      titleMedium: TextStyle(color: darkTextColor, fontSize: 28, decoration: TextDecoration.none,),
      titleSmall: TextStyle(color: darkColorAccent, fontSize: 20, decoration: TextDecoration.none,),

      labelLarge: TextStyle(fontSize: 20, color: darkTextColor,),
      labelMedium: TextStyle(color: darkColorAccent, fontSize: 14),
      labelSmall: TextStyle(fontSize: 14, color: darkTextColor,),
    ),
    dividerColor: darkTextColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkBG,
      hintStyle: const TextStyle(color: darkColorAccent),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: darkColorAccent),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: darkBG),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: darkColorAccent,
        backgroundColor: darkColorPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkColorAccent,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: darkBG,
      contentTextStyle: TextStyle(color: darkTextColor),
      actionTextColor: darkColorAccent,
    ),
  );
  static ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBG,
    primaryColor: lightColorPrimary,
    colorScheme: const ColorScheme.light(
      primary: lightColorPrimary,
      secondary: lightColorAccent,
      surface: lightBG,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: lightColorAccent,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightBG,
      hintStyle: const TextStyle(color: lightColorAccent),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: lightColorAccent),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: lightDarkBG),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: lightColorAccent,
        backgroundColor: lightColorPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightColorAccent,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: lightBG,
      contentTextStyle: TextStyle(color: lightTextColor),
      actionTextColor: darkColorAccent,
    ),
  );
}