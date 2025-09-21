import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6B46C1);
  static const Color primaryLight = Color(0xFF9F7AEA);
  static const Color primaryDark = Color(0xFF553C9A);

  // Secondary Colors
  static const Color secondary = Color(0xFFED8936);
  static const Color secondaryLight = Color(0xFFF6AD55);
  static const Color secondaryDark = Color(0xFFDD6B20);

  // Accent Colors
  static const Color accent = Color(0xFF38B2AC);
  static const Color accentLight = Color(0xFF4FD1C5);
  static const Color accentDark = Color(0xFF319795);

  // Neutral Colors
  static const Color background = Color(0xFFF7FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF7F9FB);
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textHint = Color(0xFFA0AEC0);
  static const Color divider = Color(0xFFE2E8F0);
  static const Color border = Color(0xFFCBD5E0);

  // Semantic Colors
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFED8936);
  static const Color error = Color(0xFFF56565);
  static const Color info = Color(0xFF4299E1);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF1A202C);
  static const Color darkSurface = Color(0xFF2D3748);
  static const Color darkSurfaceVariant = Color(0xFF4A5568);
  static const Color darkTextPrimary = Color(0xFFF7FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E0);
  static const Color darkDivider = Color(0xFF4A5568);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkBackground, darkSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.2);

  // Overlay Colors
  static Color overlayLight = Colors.white.withOpacity(0.9);
  static Color overlayDark = Colors.black.withOpacity(0.5);
}
