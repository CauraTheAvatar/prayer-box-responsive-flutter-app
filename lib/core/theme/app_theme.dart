import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // prevent instantiation
  AppTheme._(); 

  // LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    // Base colours
    primaryColor: AppColors.chambray,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      brightness:  Brightness.light,
      primary:     AppColors.chambray,
      onPrimary:   AppColors.espresso,
      secondary:   AppColors.bisque,
      onSecondary: AppColors.espresso,
      error:       Colors.red,
      onError:     AppColors.bisque,
      surface:     AppColors.glacier,
      onSurface:   AppColors.espresso,
    ),

    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.espresso,
      foregroundColor: AppColors.glacier,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.bisque),
      titleTextStyle: GoogleFonts.cormorantGaramond(
        color: AppColors.bisque,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ),

    // ElevatedButton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.chambray,
        foregroundColor: AppColors.espresso,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.chambray, width: 1),
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
        color: AppColors.espresso,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      displayMedium: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
      displaySmall: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
      headlineLarge: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      headlineMedium: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      headlineSmall: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      // titleLarge is used by AppBar by default
      titleLarge: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      titleMedium: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.cormorantGaramond(
        color: AppColors.espresso,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      // Lato for all body and label styles
      bodyLarge: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
      labelMedium: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.8,
      ),
      labelSmall: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 10,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
      ),
    ),

    // Drawer theme
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.espresso,
    ),

    // Divider theme
    dividerTheme: const DividerThemeData(
      color: AppColors.chambray,
      thickness: 0.8,
    ),

 
    // Input decoration (used in prayer form screen)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bisque,
      labelStyle: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 14,
      ),
      hintStyle: GoogleFonts.lato(
        color: AppColors.espresso,
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.chambray, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.espresso, width: 1.5),
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

 
  // Reusable decorations 
  static BoxDecoration get widgetDecoration => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.chambray.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      );

  // Dark brown background, chambray border
  static BoxDecoration get buttonDecoration => BoxDecoration(
        color: AppColors.espresso,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.chambray, width: 1),
      );

  // For primary action buttons
  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        color: AppColors.chambray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.espresso, width: 1),
      );

  // DARK THEME
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.amber,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.amber,
      onPrimary: AppColors.ink,
      secondary: AppColors.steel,
      error: Color(0xFFCF6679),
      onError: AppColors.ink,
      surface: AppColors.darkSurfaceCard,
      onSurface: AppColors.darkText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.darkText),
      titleTextStyle: GoogleFonts.cormorantGaramond(
        color: AppColors.darkText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.amber,
        foregroundColor: AppColors.ink,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.steel, width: 1),
        ),
        textStyle: GoogleFonts.lato(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    ),
    textTheme: _buildTextTheme(
      headingColor: AppColors.darkText,
      bodyColor: AppColors.darkText,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.darkSurface,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 0.8,
    ),
    inputDecorationTheme: _buildInputTheme(
      fillColor: AppColors.darkSurfaceCard,
      labelColor: AppColors.darkText,
      borderColor: AppColors.steel,
      focusColor: AppColors.amber,
    ),
  );

  // SHARED TEXT THEME BUILDER
}