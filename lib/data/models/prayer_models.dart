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

// Represents a daily Bible scripture 
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

// Represents the user's profile information
class AppUser {
  const AppUser({
    required this.uid,
    required this.username,
    required this.email,
    this.notificationsEnabled = true,
  });

  final String uid;  
  final String username;  
  final String email;  
  final bool notificationsEnabled;  

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