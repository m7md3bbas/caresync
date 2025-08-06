import 'package:flutter/material.dart';

class ColorManager {
  // Primary Healthcare Colors
  static const Color primary = Color(0xFF2E7D8A); // Teal - Medical/Healthcare
  static const Color secondary = Color(0xFF4A90A4); // Lighter Teal
  static const Color accent = Color(0xFF5CB85C); // Green - Success/Health
  static const Color background = Color(0xFFF8F9FA); // Light Gray Background

  // Additional Healthcare Colors
  static const Color success = Color(0xFF28A745); // Success Green
  static const Color warning = Color(0xFFFFC107); // Warning Yellow
  static const Color error = Color(0xFFDC3545); // Error Red
  static const Color info = Color(0xFF17A2B8); // Info Blue

  // Text Colors
  static const Color textPrimary = Color(0xFF212529); // Dark Gray
  static const Color textSecondary = Color(0xFF6C757D); // Medium Gray
  static const Color textLight = Color(0xFFADB5BD); // Light Gray

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceVariant = Color(0xFFF8F9FA); // Light Gray
  static const Color surfaceDark = Color(0xFFE9ECEF); // Darker Gray

  // Border Colors
  static const Color border = Color(0xFFDEE2E6); // Light Border
  static const Color borderDark = Color(0xFFCED4DA); // Darker Border

  // Status Colors
  static const Color pending = Color(0xFFFFA726); // Orange
  static const Color confirmed = Color(0xFF66BB6A); // Green
  static const Color cancelled = Color(0xFFEF5350); // Red
  static const Color completed = Color(0xFF42A5F5); // Blue

  // Gradient Colors
  static const Color gradientStart = Color(0xFF2E7D8A);
  static const Color gradientEnd = Color(0xFF4A90A4);
}

class DarkColorManager {
  // Dark Theme Colors - Healthcare Focused
  static const Color darkPrimary = Color(0xFF1A3A40); // Dark Teal
  static const Color darkSecondary = Color(0xFF2C5A65); // Darker Teal
  static const Color darkBackground = Color(0xFF121212); // Dark Background
  static const Color darkSurface = Color(0xFF1E1E1E); // Dark Surface
  static const Color darkSurfaceVariant = Color(
    0xFF2D2D2D,
  ); // Dark Surface Variant

  // Dark Text Colors
  static const Color darkText = Color(0xFFE9EDEF); // Light Text
  static const Color darkSecondaryText = Color(0xFF8696A0); // Secondary Text
  static const Color darkTextLight = Color(0xFFADB5BD); // Light Text

  // Dark AppBar
  static const Color darkAppBar = Color(0xFF1A3A40); // Dark AppBar

  // Dark Status Colors
  static const Color darkPending = Color(0xFFFFB74D); // Dark Orange
  static const Color darkConfirmed = Color(0xFF81C784); // Dark Green
  static const Color darkCancelled = Color(0xFFE57373); // Dark Red
  static const Color darkCompleted = Color(0xFF64B5F6); // Dark Blue

  // Dark Border Colors
  static const Color darkBorder = Color(0xFF424242); // Dark Border
  static const Color darkBorderLight = Color(0xFF616161); // Light Dark Border
}
