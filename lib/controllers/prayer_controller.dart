import 'dart:ui';

import 'package:get/get.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/data/services/local_storage_service.dart';

class PrayerController extends GetxController {
  // Reactive list of unanswered prayers
  final RxList<PrayerRequest> unansweredPrayers = <PrayerRequest>[].obs;

  // Reactive list of answered prayers
  final RxList<PrayerRequest> answeredPrayers = <PrayerRequest>[].obs;

  final LocalStorageService _storageService = LocalStorageService();

  // Return 3 most recent unanswered prayers
  List<PrayerRequest> get recentUnansweredPrayers => unansweredPrayers.take(3).toList();

  @override
  void onInit() {
    super.onInit();
    loadFromLocalStorage();
  }

  // Load prayers from local storage and separate them into answered and unanswered lists
  Future<void> loadFromLocalStorage() async {
    final List<PrayerRequest> allPrayers = await _storageService.loadPrayerRequests();
    final List<PrayerRequest> unanswered = [];
    final List<PrayerRequest> answered = [];

    unanswered.assignAll(allPrayers.where((prayer) => !prayer.isAnswered).toList());
    answered.assignAll(allPrayers.where((prayer) => prayer.isAnswered).toList());

    for (var prayer in allPrayers) {
      if (prayer.isAnswered) {
        answered.add(prayer);
      } else {
        unanswered.add(prayer);
      }
    }

    // Update reactive lists
    unansweredPrayers.assignAll(unanswered);
    answeredPrayers.assignAll(answered);
  }

  // Persists the current state of prayers to local storage
  Future<void> saveToLocalStorage() async {
    final List<PrayerRequest> allPrayers = [...unansweredPrayers, ...answeredPrayers];
    await _storageService.savePrayerRequests(allPrayers);
  }

  // Add a new prayer request and persist addition
  Future<void> addPrayerRequest({
    required String title,
    required String content,
    required String? meditationScripture,
  }) async {
    final PrayerRequest newPrayer= PrayerRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      meditationScripture: meditationScripture ?? '',
    );

    // Index = 0 so that prayer appears at the top of the list
    unansweredPrayers.insert(0, newPrayer);
    await saveToLocalStorage();
  }

  // Deletes a prayer request and persist deletion
  Future<void> deletePrayerRequest(String id) async {
    unansweredPrayers.removeWhere((p) => p.id == id);
    answeredPrayers.removeWhere((p) => p.id == id);
    await saveToLocalStorage();
  }

  // Move a prayer request from unanswered to answered and persist change
  Future<void> markAsAnswered(String id) async {
    final int index = unansweredPrayers.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final PrayerRequest answeredPrayer = unansweredPrayers[index].copyWith(
      isAnswered: true,
      answeredAt: DateTime.now(),
    );

    unansweredPrayers.removeAt(index);
    // Index = 0 so that answered prayer appears at the top of the list
    answeredPrayers.insert(0, answeredPrayer);
    await saveToLocalStorage();
  }

  // Edit an existing prayer request and persist change
  Future<void> editPrayerRequest({
    required String id,
    String? title,
    String? content,
    String? meditationScripture,
  }) async {
    final int index = unansweredPrayers.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final PrayerRequest updatedPrayer = unansweredPrayers[index].copyWith(
      title: title ?? unansweredPrayers[index].title,
      content: content ?? unansweredPrayers[index].content,
      meditationScripture: meditationScripture ?? unansweredPrayers[index].meditationScripture,
    );

    unansweredPrayers[index] = updatedPrayer;
    await saveToLocalStorage();
  }
}