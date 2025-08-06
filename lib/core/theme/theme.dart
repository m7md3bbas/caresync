import 'package:caresync/core/colors/color_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.background,
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: ColorManager.primary),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
      brightness: Brightness.light,
      primary: ColorManager.primary,
      secondary: ColorManager.secondary,
      surface: ColorManager.surface,
      background: ColorManager.background,
      error: ColorManager.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ColorManager.textPrimary,
      onBackground: ColorManager.textPrimary,
      onError: Colors.white,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: ColorManager.surface,
      elevation: 2,
      shadowColor: ColorManager.textLight.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.surface,
      labelStyle: TextStyle(color: ColorManager.textSecondary),
      hintStyle: TextStyle(color: ColorManager.textLight),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.border),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.border),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.primary,
        side: BorderSide(color: ColorManager.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.surface,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.textLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.primary,
      textColor: ColorManager.textPrimary,
      tileColor: ColorManager.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: ColorManager.border,
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: ColorManager.primary, size: 24),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ColorManager.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ColorManager.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorManager.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorManager.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ColorManager.textSecondary,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: ColorManager.textPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: ColorManager.textPrimary),
      bodySmall: TextStyle(fontSize: 12, color: ColorManager.textSecondary),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColorManager.darkBackground,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: DarkColorManager.darkAppBar,
      foregroundColor: DarkColorManager.darkText,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: DarkColorManager.darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: DarkColorManager.darkText),
    ),

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: DarkColorManager.darkPrimary,
      brightness: Brightness.dark,
      primary: DarkColorManager.darkPrimary,
      secondary: DarkColorManager.darkSecondary,
      surface: DarkColorManager.darkSurface,
      background: DarkColorManager.darkBackground,
      error: ColorManager.error,
      onPrimary: DarkColorManager.darkText,
      onSecondary: DarkColorManager.darkText,
      onSurface: DarkColorManager.darkText,
      onBackground: DarkColorManager.darkText,
      onError: Colors.white,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: DarkColorManager.darkSurface,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkColorManager.darkSurface,
      labelStyle: TextStyle(color: DarkColorManager.darkSecondaryText),
      hintStyle: TextStyle(color: DarkColorManager.darkSecondaryText),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColorManager.darkBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColorManager.darkBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColorManager.darkPrimary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkColorManager.darkPrimary,
        foregroundColor: DarkColorManager.darkText,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: DarkColorManager.darkText,
        side: BorderSide(color: DarkColorManager.darkPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkColorManager.darkText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DarkColorManager.darkSurface,
      selectedItemColor: DarkColorManager.darkText,
      unselectedItemColor: DarkColorManager.darkSecondaryText,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      iconColor: DarkColorManager.darkText,
      textColor: DarkColorManager.darkText,
      tileColor: DarkColorManager.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: DarkColorManager.darkBorder,
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: DarkColorManager.darkText, size: 24),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: DarkColorManager.darkText,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: DarkColorManager.darkText,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: DarkColorManager.darkText,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: DarkColorManager.darkText,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: DarkColorManager.darkText,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: DarkColorManager.darkText,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: DarkColorManager.darkText,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: DarkColorManager.darkText,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: DarkColorManager.darkSecondaryText,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: DarkColorManager.darkText),
      bodyMedium: TextStyle(fontSize: 14, color: DarkColorManager.darkText),
      bodySmall: TextStyle(
        fontSize: 12,
        color: DarkColorManager.darkSecondaryText,
      ),
    ),
  );
}
