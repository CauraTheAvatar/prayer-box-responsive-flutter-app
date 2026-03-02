import 'package:get/get.dart';
import 'package:prayer_box_flutter/data/services/local_storage_service.dart';

class SettingsController extends GetxController {
  // Reactive notification toggle
  RxBool notificationsEnabled = false.obs;

  final LocalStorageService _localStorageService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    super.onInit();
    getFromLocalStorage();
  }

  // Load settings from local storage
  Future<void> getFromLocalStorage() async {
    notificationsEnabled.value = await _localStorageService.loadNotificationPreference() ?? false;
  }

  // Flips the notification toggle and saves the new state to local storage
  Future<void> toggleNotifications() async {
    notificationsEnabled.value = !notificationsEnabled.value;
    await _localStorageService.saveNotificationPreference(notificationsEnabled.value);
  }

  // Persist current notification setting to local storage
  Future<void> saveToLocalStorage() async {
    await _localStorageService.saveNotificationPreference(notificationsEnabled.value);
  }
}

