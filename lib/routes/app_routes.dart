import 'package:get/get.dart';
import 'package:prayer_box_flutter/screens/landing_screen.dart';
import 'package:prayer_box_flutter/screens/prayer_list_screen.dart';
import 'package:prayer_box_flutter/screens/prayer_form_screen.dart';
import 'package:prayer_box_flutter/screens/prayer_detail_screen.dart';
import 'package:prayer_box_flutter/screens/answered_prayers_screen.dart';
import 'package:prayer_box_flutter/screens/settings_screen.dart';

class AppRoutes {
  static const landing = '/';
  static const prayerList = '/prayer-list';
  static const prayerForm = '/prayer-form';
  static const prayerDetail = '/prayer-detail';
  static const answeredPrayers = '/answered-prayers';
  static const settings = '/settings';

  // GetPage route definitions
  static final List<GetPage> routes = [
    GetPage(
      name: landing, 
      page: () => LandingScreen(),
    ),
    GetPage(
      name: prayerList, 
      page: () => PrayerListScreen(),
    ),
    GetPage(
      name: prayerForm, 
      page: () => PrayerFormScreen(),
    ),
    GetPage(
      name: prayerDetail, 
      page: () => PrayerDetailScreen(),
    ),
    GetPage(
      name: answeredPrayers, 
      page: () => AnsweredPrayersScreen(),
    ),
    GetPage(
      name: settings, 
      page: () => SettingsScreen(),
    ),
  ];
}