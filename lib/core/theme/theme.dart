import 'package:caresync/core/colors/color_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.primary,
      textColor: ColorManager.primary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      foregroundColor: ColorManager.secondary,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: ColorManager.primary,
      labelStyle: TextStyle(color: ColorManager.primary),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.secondary),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.secondary),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.secondary),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
      brightness: Brightness.light,
      secondary: ColorManager.secondary,
      primary: ColorManager.primary,
    ),

    dividerColor: ColorManager.primary,
    iconTheme: IconThemeData(color: ColorManager.primary),
    textTheme: TextTheme(
      headlineMedium: TextStyle(color: ColorManager.primary),
      headlineLarge: TextStyle(color: ColorManager.primary),
      bodyLarge: TextStyle(fontSize: 16, color: ColorManager.primary),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: ColorManager.primary,
      ),
    ),
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColorManager.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: DarkColorManager.darkAppBar,
      foregroundColor: DarkColorManager.darkText,
      elevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColorManager.darkSecondaryText),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColorManager.darkSecondaryText),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColorManager.darkSecondaryText),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    dividerColor: DarkColorManager.darkSecondaryText,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DarkColorManager.darkAppBar,
      selectedItemColor: DarkColorManager.darkText,
      unselectedItemColor: DarkColorManager.darkSecondaryText,
    ),
    iconTheme: IconThemeData(color: DarkColorManager.darkSecondaryText),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: DarkColorManager.darkText),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: DarkColorManager.darkText,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: DarkColorManager.darkText,
      brightness: Brightness.dark,
      primary: DarkColorManager.darkText,
      secondary: DarkColorManager.darkSecondaryText,
    ),
  );
}
