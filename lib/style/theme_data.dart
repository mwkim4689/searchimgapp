import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appThemeData(BuildContext context) {


  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(),
    useMaterial3: true,
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 16,
      ),
      bodyMedium: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 14,
      ),
      bodySmall: GoogleFonts.getFont(
        'Noto Sans',
        fontSize: 12,
      ),
    ),
  );
}