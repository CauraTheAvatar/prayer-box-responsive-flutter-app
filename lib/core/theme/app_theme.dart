import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // prevent instantiation
  AppTheme._(); 

  static final ThemeData lightTheme = ThemeData(
    // Base colours
    primaryColor: AppColors.gold,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      brightness:  Brightness.light,
      primary:     AppColors.gold,
      onPrimary:   AppColors.darkBrown,
      secondary:   AppColors.beige,
      onSecondary: AppColors.darkBrown,
      error:       Colors.red,
      onError:     AppColors.beige,
      surface:     AppColors.white,
      onSurface:   AppColors.darkBrown,
    ),

    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBrown,
      foregroundColor: AppColors.beige,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.beige),
      titleTextStyle: GoogleFonts.cormorantGaramond(
        color: AppColors.beige,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ),

    // ElevatedButton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.darkBrown,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.gold, width: 1),
        ),
        textStyle: GoogleFonts.lato(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      // Cormorant Garamond for all display and heading styles
      displayLarge: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      displayMedium: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
      displaySmall: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
      headlineLarge: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      headlineMedium: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      headlineSmall: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      // titleLarge is used by AppBar by default
      titleLarge: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      titleMedium: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.cormorantGaramond(
        color: AppColors.darkBrown,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      // Lato for all body and label styles
      bodyLarge: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
      labelMedium: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.8,
      ),
      labelSmall: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 10,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
      ),
    ),

    // Drawer theme
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.darkBrown,
    ),

    // Divider theme
    dividerTheme: const DividerThemeData(
      color: AppColors.gold,
      thickness: 0.8,
    ),

 
    // Input decoration (used in prayer form screen)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.beige,
      labelStyle: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 14,
      ),
      hintStyle: GoogleFonts.lato(
        color: AppColors.darkBrown,
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkBrown, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );

 
  // Reusable decorations — imported by screens instead of redefining inline
  // Beige background, gold border, subtle gold shadow
  static BoxDecoration get widgetDecoration => BoxDecoration(
        color: AppColors.beige,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      );

  // Dark brown background, gold border
  static BoxDecoration get buttonDecoration => BoxDecoration(
        color: AppColors.darkBrown,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gold, width: 1),
      );

  // Gold background, dark brown border — for primary action buttons
  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkBrown, width: 1),
      );
}