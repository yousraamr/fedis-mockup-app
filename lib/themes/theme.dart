import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFB35537),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  background: Color(0xFFF1F1F1),
  onBackground: Color(0xFF1A1C18),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFF8A8E87),
  surface: Color(0xFFF9FAF3),
  onSurface: Color(0xFF1A1C18),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF90CAF9),
  onPrimary: Color(0xFF000000),
  secondary: Color(0xFF64B5F6),
  onSecondary: Color(0xFF000000),
  error: Color(0xFFEF5350),
  onError: Color(0xFFFFFFFF),
  background: Color(0xFF121212),
  onBackground: Color(0xFFE0E0E0),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFF424242),
  surface: Color(0xFF1E1E1E),
  onSurface: Color(0xFFE0E0E0),
);


ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    titleTextStyle: TextStyle(
      color: lightColorScheme.onBackground,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: lightColorScheme.onBackground),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(color: lightColorScheme.primary, fontSize: 30, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: lightColorScheme.onBackground, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: lightColorScheme.onBackground),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    titleTextStyle: TextStyle(
      color: darkColorScheme.onBackground,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: darkColorScheme.onBackground),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(color: darkColorScheme.primary, fontSize: 30, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: darkColorScheme.onBackground, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: darkColorScheme.onBackground),
  ),
);