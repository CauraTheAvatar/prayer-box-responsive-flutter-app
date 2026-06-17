import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/settings_controller.dart';
import 'package:prayer_box_flutter/controllers/scripture_controller.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/controllers/auth_controller.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/data/services/scripture_service.dart';
import 'package:prayer_box_flutter/data/services/local_storage_service.dart';
import 'package:prayer_box_flutter/routes/app_pages.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Services
  final LocalStorageService localStorageService = LocalStorageService();
  await localStorageService.init();
  Get.put(localStorageService);

  Get.put(ScriptureService());

  // Controllers 
  Get.put(PrayerController());
  Get.put(ScriptureController());
  Get.put(SettingsController());
  Get.put(AuthController()); // This triggers the auth state check immediately

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
      initialRoute: AppRoutes.login, // start at login
      getPages: AppPages.pages,
    );
  }
}