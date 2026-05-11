import 'package:flutter/material.dart';

abstract class AppColors {
  // Prevent instantiation
  AppColors._();

  // PRIMARY PALETTE
  static const Color chambray = Color(0xFF79A3C3);
  static const Color espresso = Color(0xFF3A2119);
  static const Color glacier = Color(0xFFD2E2EC);
  static const Color bisque = Color(0xFFEBCDB7);
  static const Color clay = Color(0xFF957662);

  // DARK THEME COMPLEMENTARY PALETTE
  static const Color amber = Color(0xFFC3A179);
  static const Color ink = Color(0xFF1A2535);
  static const Color sand = Color(0xFF2C3545);
  static const Color sage = Color(0xFF4A6B5A);
  static const Color steel = Color(0xFF627895);
  static const Color darkSurface = Color(0xFF1E2C3A);
  static const Color darkerSurface = Color(0xFF162030);
  static const Color darkCard = Color(0xFF243447);

  // SEMANTIC ALIASES (REFERENCED THROUGHOUT THE APP)
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = glacier;
  static const Color surface = bisque;
  static const Color primary = espresso;
  static const Color accent = chambray;
  static const Color muted = clay;
  static const Color gold = chambray;
  static const Color goldLight = Color(0xFFAAC4D8);
  static const Color darkBrown = espresso;
  static const Color beige = bisque;

  // DARK THEME SEMANTIC ALIASES
  static const Color darkBackground = darkerSurface;
  static const Color darkSurfaceCard = darkCard;
  static const Color darkPrimary = amber;
  static const Color darkAccent = steel;
  static const Color darkMuted = Color(0xFF8A9BB0);
  static const Color darkText = Color(0xFFE8D5C4);
  static const Color darkTextMuted = Color(0xFF9AABBF);
  static const Color darkBorder = Color(0xFF344860);
  static const Color darkAppBar = ink;
}