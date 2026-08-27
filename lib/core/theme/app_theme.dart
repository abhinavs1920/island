import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xFF003ec7);
  static const primaryContainer = Color(0xFF0052ff);
  static const surface = Color(0xFFfbf8ff);
  static const onSurface = Color(0xFF191b25);
  static const outline = Color(0xFF737688);
  static const error = Color(0xFFba1a1a);
  static const success = Color(0xFF00C853); // Deep Emerald per spec
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: surface,
        error: error,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -0.64),
        headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, height: 1.33, letterSpacing: -0.24),
        bodyLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, height: 1.44),
        bodyMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, height: 1.42, letterSpacing: 0.7),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryContainer,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
