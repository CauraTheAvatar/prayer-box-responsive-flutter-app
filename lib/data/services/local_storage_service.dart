import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class _Keys {
  static const String prayers = 'prayers_requests';
  static const String notifications = 'notifications_enabled';
}

class LocalStorageService extends GetxService {
  Future<LocalStorageService> init() async {
    // Initialize your local storage here
    // Example: await _initializeHiveBoxes();
    return this;
  }

  // Prayer Requests
  // Converts a list of PrayerRequest objects to JSON and saves it in SharedPreferences
  Future<void> savePrayerRequests(List<PrayerRequest> prayers) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String encoded = jsonEncode(
        prayers.map((prayer) => prayer.toMap()).toList(),
      );
      await prefs.setString(_Keys.prayers, encoded);
    } catch (e) {
      debugPrint('Error saving prayer requests: $e');
    }
  }

  // Retrieves the JSON string from SharedPreferences, decodes it, 
  // and converts it back to a list of PrayerRequest objects
  Future<List<PrayerRequest>> loadPrayerRequests() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? encoded = prefs.getString(_Keys.prayers);
      if (encoded == null) return [];

      final List<dynamic> decoded = jsonDecode(encoded) as List<dynamic>;
      return decoded
          .map((item) => PrayerRequest.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error loading prayer requests: $e');
      return [];
    }
  }

  // Permanently deletes all saved prayer requests in local storage
  Future<void> clearPrayerRequests() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_Keys.prayers);
    } catch (e) {
      debugPrint('Error clearing prayer requests: $e');
    }
  }

  // Notification Settings
  // Saves the user's notification preference (enabled/disabled) in SharedPreferences
  Future<void> saveNotificationPreference(bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_Keys.notifications, value);
    } catch (e) {
      debugPrint('Error saving notification preference: $e');
    }
  }

  // Load user's notification preference from SharedPreferences, 
  // returns false if not set
  Future<bool> loadNotificationPreference() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_Keys.notifications) ?? false;
    } catch (e) {
      debugPrint('Error loading notification preference: $e');
      return true;
    }
  }
}