import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/settings_controller.dart';
import 'package:prayer_box_flutter/controllers/scripture_controller.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';

import 'package:prayer_box_flutter/data/services/scripture_service.dart';
import 'package:prayer_box_flutter/data/services/local_storage_service.dart';
import 'package:prayer_box_flutter/routes/app_pages.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise services first because controllers depend on them
  final LocalStorageService localStorageService = LocalStorageService();
  await localStorageService.init();
  Get.put(localStorageService);

  final ScriptureService scriptureService = ScriptureService();
  Get.put(scriptureService);

  // Initialise controllers are registered globally for the app lifetime
  // Get.find() in any screen or widget will locate these instances
  Get.put(PrayerController());
  Get.put(ScriptureController());
  Get.put(SettingsController());

  runApp(const PrayerBoxApp());
}

class PrayerBoxApp extends StatelessWidget {
  const PrayerBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Prayer Box',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.landing,
      getPages: AppPages.pages,
    );
  }
}