import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:get/get.dart';

class ScriptureService extends GetxService {
  static const List<Map<String, String>> _verses = [
    {
      'id': '1',
      'verseText': 'For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, to give you hope and a future.',
      'reference': 'Jeremiah 29:11',
    },
    {
      'id': '2',
      'verseText': 'Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight.',
      'reference': 'Proverbs 3:5-6',
    },
    {
      'id': '3',
      'verseText':
          'The Lord is my shepherd, I lack nothing. He makes me lie down in '
              'green pastures, he leads me beside quiet waters, he refreshes my soul.',
      'reference': 'Psalm 23:1-3',
    },
    {
      'id': '4',
      'verseText':
          'I can do all this through him who gives me strength.',
      'reference': 'Philippians 4:13',
    },
    {
      'id': '5',
      'verseText':
          'Be strong and courageous. Do not be afraid; do not be discouraged, '
              'for the Lord your God will be with you wherever you go.',
      'reference': 'Joshua 1:9',
    },
    {
      'id': '6',
      'verseText':
          'And we know that in all things God works for the good of those who '
              'love him, who have been called according to his purpose.',
      'reference': 'Romans 8:28',
    },
    {
      'id': '7',
      'verseText':
          'Do not be anxious about anything, but in every situation, by prayer '
              'and petition, with thanksgiving, present your requests to God.',
      'reference': 'Philippians 4:6',
    },
    {
      'id': '8',
      'verseText':
          'Cast all your anxiety on him because he cares for you.',
      'reference': '1 Peter 5:7',
    },
    {
      'id': '9',
      'verseText':
          'For God so loved the world that he gave his one and only Son, that '
              'whoever believes in him shall not perish but have eternal life.',
      'reference': 'John 3:16',
    },
    {
      'id': '10',
      'verseText':
          'But those who hope in the Lord will renew their strength. They will '
              'soar on wings like eagles; they will run and not grow weary, '
              'they will walk and not be faint.',
      'reference': 'Isaiah 40:31',
    },
  ];

  Future<ScriptureService> init() async {
    // Perform any initialization logic here if needed
    // For example, loading from local storage, API calls, etc.
    return this;
  }

  // Method to fetch a random scripture verse which dynamically changes each day
  DailyScripture getDailyScripture() {
    final today = DateTime.now();
    final index = today.day % _verses.length; // Change verse daily based on the day of the month
    final verseData = _verses[index];
    return DailyScripture(
      id: verseData['id']!,
      verseText: verseData['verseText']!,
      reference: verseData['reference']!,
    );
  }

  // Return a list of all scripture verses
  List<DailyScripture> getAllScriptures() {
    return _verses.map((verseData) {
      return DailyScripture(
        id: verseData['id']!,
        verseText: verseData['verseText']!,
        reference: verseData['reference']!,
      );
    }).toList();
  }

  // Method to calculate the current day of the year (1-365/366)
  int getCurrentDayOfYear() {
    final DateTime now = DateTime.now();
    final DateTime startOfYear = DateTime(now.year, 1, 1);
    return now.difference(startOfYear).inDays;
  }
}