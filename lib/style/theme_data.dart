import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String appFontFamily = 'Noto Sans';

ThemeData appThemeData(BuildContext context) {


  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(),
    useMaterial3: true,
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 16,
      ),
      bodyMedium: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 14,
      ),
      bodySmall: GoogleFonts.getFont(
        appFontFamily,
        fontSize: 12,
      ),
    ),
  );
}