import 'package:get/get.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/data/services/scripture_service.dart';

class ScriptureController extends GetxController {
  final Rx<DailyScripture?> dailyScripture = Rxn<DailyScripture?>();
  final ScriptureService _scriptureService = ScriptureService();

  @override
  void onInit() {
    super.onInit();
    fetchDailyScripture();
  }

  // Fetch the daily scripture from the service
  void fetchDailyScripture() {
    dailyScripture.value = _scriptureService.getDailyScripture();
  }
}
