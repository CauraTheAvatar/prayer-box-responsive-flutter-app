import 'package:get/get.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/data/services/scripture_service.dart';

class ScriptureController extends GetxController {
  // Observable for the daily scripture
  final Rx<DailyScripture?> dailyScripture = Rxn<DailyScripture>();
  
  // Observable for loading state
  final RxBool isLoading = false.obs;
  
  late final ScriptureService _scriptureService;

  @override
  void onInit() {
    super.onInit();
    _scriptureService = Get.find<ScriptureService>();
    loadDailyScripture();
  }

  // Method to load/refresh the daily scripture
  Future<void> loadDailyScripture() async {
    try {
      isLoading.value = true;
      // Short delay to simulate loading state (optional)
      await Future.delayed(const Duration(milliseconds: 300));
      dailyScripture.value = _scriptureService.getDailyScripture();
    } catch (e) {
      print('Error loading daily scripture: $e');
      dailyScripture.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}