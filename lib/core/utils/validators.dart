abstract class Validators {
  Validators._();

  // Prayer content characer limit
  static const int contentCharacterLimit = 15000;

  // Prayer title validator
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title for your prayer request.';
    }
    if (value.trim().length > 100) {
      return 'Title cannot exceed 100 characters.';
    }
    return null;
  }

  // Prayer content validator
  static String? validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your prayer request.';
    }
    if (value.trim().length > contentCharacterLimit) {
      return 'Prayer request cannot exceed $contentCharacterLimit characters';
    }
    return null;
  }

  // Meditation scripture validator
  static String? validateScripture(String? value) {
    return null;
  }

  // Generic required field validator
  static String? validateRequired(
    String? value, 
    {String? fieldName}
  ) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName is required.'
          : 'This field is required.';
    }
    return null;
  }

  // Character count helper
  static String characterCount(String? value) {
    final int current = value?.length ?? 0;
    return '$current / $contentCharacterLimit characters';
  }

  // Character limit check
  static bool isWithinContentLimit(String? value) {
    return (value?.length ?? 0) <= contentCharacterLimit;
  }
}