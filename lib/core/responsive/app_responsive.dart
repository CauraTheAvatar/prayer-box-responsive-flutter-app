// lib/core/app_responsive.dart

import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static const double desktopBreakpoint = 1200;
  static const double tabletBreakpoint = 800;

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint &&
        MediaQuery.of(context).size.width < desktopBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    if (isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 80, vertical: 24);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
    } else {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }

  static double containerWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 800;
    } else if (isTablet(context)) {
      return 600;
    } else {
      return double.infinity;
    }
  }

  // This is the method your ScriptureWidget is using
  static T responsiveValue<T>(BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
}