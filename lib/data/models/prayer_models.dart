import 'package:get/get.dart';
import 'package:prayer_box_flutter/data/services/scripture_service.dart';

class PrayerRequest {
  PrayerRequest({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.meditationScripture = '',
    this.isAnswered = false,
    this.answeredAt,
  });

  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String meditationScripture;
  final bool isAnswered;
  final DateTime? answeredAt;

  // Create a copy of the prayer request with updated fields
  PrayerRequest copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    String? meditationScripture,
    bool? isAnswered,
    DateTime? answeredAt,
  }) {
    return PrayerRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      meditationScripture: meditationScripture ?? this.meditationScripture,
      isAnswered: isAnswered ?? this.isAnswered,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  // Convert the prayer request to a Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'meditationScripture': meditationScripture,
      'isAnswered': isAnswered,
      'answeredAt': answeredAt?.toIso8601String(),
    };
  }

  // Create a prayer request from a Map
  factory PrayerRequest.fromMap(Map<String, dynamic> map) {
    return PrayerRequest(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      meditationScripture: map['meditationScripture'] as String? ?? '',
      isAnswered: map['isAnswered'] as bool? ?? false,
      answeredAt: map['answeredAt'] != null 
          ? DateTime.parse(map['answeredAt'] as String) 
          : null,
    );
  }
}

// This represents a daily Bible scripture fetched from the YouVersion API
class DailyScripture {
  DailyScripture({
    required this.id,
    required this.verseText,
    required this.reference,
  });

  final String id;
  final String verseText;
  final String reference;

  // Convert the daily scripture to a Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'verseText': verseText,
      'reference': reference,
    }; 
  }

  // Create a daily scripture from a Map
  factory DailyScripture.fromMap(Map<String, dynamic> map) {
    return DailyScripture(
      id: map['id'] as String,
      verseText: map['verseText'] as String,
      reference: map['reference'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'verseText': verseText,
        'reference': reference,
      };
}

// Represents the authenticated user's profile information
class AppUser {
  const AppUser({
    required this.uid,
    required this.username,
    required this.email,
    this.notificationsEnabled = true,
  });

  final String uid;  // Unique identifier for the user
  final String username;  // User's display username
  final String email;  // User's email address
  final bool notificationsEnabled;  // Whether the user has enabled prayer notifications (toggle in settings)

  AppUser copyWith({
    String? uid,
    String? username,
    String? email,
    bool? notificationsEnabled,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  // Convert the user profile to a Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'username': username,
      'email': email,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  // Create a user profile from a Map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      notificationsEnabled: map['notificationsEnabled'] as bool? ?? true,
    );
  }
}

// GetX reactive controller to manage the state of prayer requests and user profile
class PrayerController extends GetxController {
  // Reactive list of prayer requests (answered and unanswered)
  final RxList<PrayerRequest> _prayerRequests = <PrayerRequest>[].obs;

  // Reactive user profile
  var userProfile = Rxn<AppUser>();

  // Unanswered prayer requests are derived from the main list (ascending order)
  List<PrayerRequest> get unansweredPrayers => _prayerRequests
      .where((request) => !request.isAnswered)
      .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  // Three most recent answered prayer requests displayed on landing page
  List<PrayerRequest> get recentRequests => unansweredPrayers.take(3)
      .toList();

  // Method to add a new prayer request
  void addPrayerRequest({
    required String title,
    required String content,
    String meditationScripture = '',
  }) {
    final newRequest = PrayerRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      meditationScripture: meditationScripture,
    );
    _prayerRequests.add(newRequest);
  }

  // Method to update an existing prayer request
  void updatePrayerRequest(String id, PrayerRequest updatedRequest) {
    int index = _prayerRequests.indexWhere((p) => p.id == updatedRequest.id);
    if (index != -1) {
      _prayerRequests[index] = updatedRequest;
    }
  }

  // Method to mark a prayer request as answered
  void markAsAnswered(String id) {
    final index = _prayerRequests.indexWhere((p) => p.id == id);
    if (index != -1) {
      final request = _prayerRequests[index];
      _prayerRequests[index] = request.copyWith(
        isAnswered: true,
        answeredAt: DateTime.now(),
      );
    }
  }

  // Method to delete a prayer request
  void deletePrayerRequest(String id) {
    _prayerRequests.removeWhere((p) => p.id == id);
  }

  // Method to find a prayer request by ID
  PrayerRequest? findPrayerById(String id) {
    try {
      return _prayerRequests.firstWhere((p) => p.id == id);
    } catch (e) {
      return null; // Return null if not found
    }
  }

  // Method to set the user profile
  void setUserProfile(AppUser? user) {
    userProfile.value = user;
  }
}

// GetX reactive controller for daily scripture widget
class ScriptureController extends GetxController {
  final Rxn<DailyScripture?> dailyScripture = Rxn<DailyScripture>();
  late final ScriptureService _scriptureService;

  @override
  void onInit() {
    super.onInit();
    _scriptureService = Get.find<ScriptureService>();
    fetchDailyScripture();
  }

  void fetchDailyScripture() {
    try {
      dailyScripture.value = _scriptureService.getDailyScripture();
    } catch (e) {
      print('Error fetching daily scripture: $e');
    }
  }
}

// Simulates user logging in and setting their profile information
void login(String uid, String username, String email) {
  final user = AppUser(uid: uid, username: username, email: email);
  Get.find<PrayerController>().setUserProfile(user);
}

void logout() {
  Get.find<PrayerController>().setUserProfile(null);
}

void toggleNotifications() {
  final controller = Get.find<PrayerController>();
  if (controller.userProfile.value == null) return; // No user logged in
  controller.userProfile.value = controller.userProfile.value!.copyWith(
    notificationsEnabled: !controller.userProfile.value!.notificationsEnabled,
  );
}

bool get notificationsEnabled => 
    Get.find<PrayerController>().userProfile.value?.notificationsEnabled ?? false;

String get username => Get.find<PrayerController>().userProfile.value?.username ?? 'Guest';