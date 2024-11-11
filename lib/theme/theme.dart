import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const int _primaryColorValue = 0xFF2563EB; // Blue-600

  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(_primaryColorValue),
    brightness: Brightness.light,
    primary: const Color(_primaryColorValue),
    secondary: const Color(0xFF3B82F6), // Blue-500
    tertiary: const Color(0xFF1D4ED8), // Blue-700
    surface: Colors.white,
    error: const Color(0xFFDC2626), // Red-600
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme,
    fontFamily: GoogleFonts.lexend().fontFamily,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: _colorScheme.primary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.lexend(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _colorScheme.primary,
      ),
      iconTheme: IconThemeData(
        color: _colorScheme.primary,
      ),
      actionsIconTheme: IconThemeData(
        color: _colorScheme.primary,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _colorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: TextStyle(color: _colorScheme.onSurface.withOpacity(0.7)),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _colorScheme.primary,
      unselectedItemColor: _colorScheme.onSurface.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.lexend(
        fontSize: 12,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.lexend(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.lexend(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _colorScheme.onSurface,
      ),
      displayMedium: GoogleFonts.lexend(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _colorScheme.onSurface,
      ),
      displaySmall: GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _colorScheme.onSurface,
      ),
      headlineMedium: GoogleFonts.lexend(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _colorScheme.onSurface,
      ),
      titleLarge: GoogleFonts.lexend(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: _colorScheme.onSurface,
      ),
      bodyLarge: GoogleFonts.lexend(
        fontSize: 16,
        color: _colorScheme.onSurface,
      ),
      bodyMedium: GoogleFonts.lexend(
        fontSize: 14,
        color: _colorScheme.onSurface,
      ),
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.lexend(),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(4),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),

    scaffoldBackgroundColor: Colors.white,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      extendedTextStyle: GoogleFonts.lexend(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
