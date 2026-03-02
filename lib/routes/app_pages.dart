import 'package:get/get.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';

import 'package:prayer_box_flutter/views/screens/landing_screen.dart';
import 'package:prayer_box_flutter/views/screens/prayer_list_screen.dart';
import 'package:prayer_box_flutter/views/screens/prayer_form_screen.dart';
import 'package:prayer_box_flutter/views/screens/prayer_detail_screen.dart';
import 'package:prayer_box_flutter/views/screens/answered_prayers_screen.dart';
import 'package:prayer_box_flutter/views/screens/settings_screen.dart';
import 'package:prayer_box_flutter/views/screens/stats_screen.dart';

// GetPage route definitions
abstract class AppPages {
  // Initial route consumed by GetMaterialApp
  static const String initial = AppRoutes.landing;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.landing,
      page: () => LandingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.prayerList,
      page: () => const PrayerListScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.prayerForm,
      page: () => const PrayerFormScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.prayerDetail,
      page: () => const PrayerDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.answeredPrayers,
      page: () => const AnsweredPrayersScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stats,
      page: () => const StatsScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}