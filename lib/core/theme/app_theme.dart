import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xFF003EC7);
  static const primaryContainer = Color(0xFF0052FF);
  static const surface = Color(0xFFFBF8FF);
  static const onSurface = Color(0xFF191B25);
  static const onSurfaceVariant = Color(0xFF434656);
  static const outline = Color(0xFF737688);
  static const outlineVariant = Color(0xFFC3C5D9);
  static const error = Color(0xFFBA1A1A);
  
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, height: 1.25, letterSpacing: -0.64, color: onSurface),
      headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, height: 1.33, letterSpacing: -0.24, color: onSurface),
      titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: onSurface),
      bodyLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, height: 1.44, color: onSurface),
      bodyMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, color: onSurfaceVariant),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, height: 1.42, letterSpacing: 0.7, color: primary),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: Color(0xFFDFE3FF),
        secondary: Color(0xFF00875A), // Success green
        onSecondary: Colors.white,
        error: error,
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF93000A),
        background: surface,
        onBackground: onSurface,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        surfaceVariant: Color(0xFFE1E1EF),
      ),
      scaffoldBackgroundColor: surface,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
        titleTextStyle: TextStyle(color: primary, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Inter'),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          disabledBackgroundColor: const Color(0xFFE1E1EF),
          foregroundColor: Colors.white,
          disabledForegroundColor: onSurfaceVariant,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: outline, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
