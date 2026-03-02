abstract class AppStrings {
  AppStrings._();

  // General app
  static const String appName = 'Prayer Box';
  static const String appTagline = 'Your virtual prayer box';

  // App bar titles
  static const String appBarWelcome = 'Welcome,';
  static const String appBarPrayerList = 'Prayer Requests';
  static const String appBarPrayerForm = 'Add New Prayer Request';
  static const String appBarPrayerDetail = 'Prayer Details';
  static const String appBarAnswered = 'Answered Prayers';
  static const String appBarSettings = 'Settings';
  static const String appBarStats = 'Statistics';

  // Nav drawer labels
  static const String navPrayerRequests = 'PRAYER REQUESTS';
  static const String navAddNewPrayer = 'ADD PRAYER';
  static const String navAnsweredPrayers = 'ANSWERED PRAYERS';
  static const String navDailyScripture = 'DAILY SCRIPTURE';
  static const String navStatistics = 'STATISTICS';
  static const String navSettings = 'Settings';
  static const String navLogout = 'Logout';

  // Landing screen
  static const String verseOfTheDay = 'Verse of the day';
  static const String prayerRequests = 'Prayer Requests';
  static const String defaultUsername = 'Laura';
  static const String footerMotivation = 'Faith means taking the first step even when you do not see the whole staircase.';

  // Prayer preview tile and checklist
  static const String noPrayersYet = 'No prayer requests yet.';
  static const String tapAddToStart = 'Tap "ADD" below to get started';
  static const String buttonView = 'VIEW';
  static const String buttonAdd = 'ADD';

  // Prayer form screen
  static const String formTitleLabel = 'Prayer Title';
  static const String formTitleHint = 'Enter a title for your prayer...';
  static const String formContentLabel = 'Prayer Request';
  static const String formContentHint = 'Write your prayer request here...';
  static const String formScriptureLabel = 'Meditation Scripture';
  static const String formScriptureHint = 'e.g. Exodus 14:14';
  static const String formTitleRequired = 'Please enter a title';
  static const String formContentRequired = 'Please enter your prayer request';
  static const String formContentLimit = 'Content cannot exceed 15,000 characters.';
  static const String buttonSave = 'SAVE';
  static const String buttonClear = 'CLEAR';

  // Prayer details screen
  static const String buttonEdit = 'EDIT';
  static const String buttonBack = 'BACK';
  static const String buttonDelete = 'DELETE';
  static const String buttonMArkAsAnswered = 'MARK AS ANSWERED';

  // Delete confirmation dialogue
  static const String deleteDialogTitle = 'Delete Prayer';
  static const String deleteDialogMessage = 'Are you sure you want to permanently delete this prayer request?';
  static const String deleteDialogContinue = 'Continue';
  static const String deleteDialogCancel = 'Cancel';

  // Answered prayers screen
  static const String noAnsweredPrayers = 'No answered prayers yet. Keep the faith.';
  
  // Settings screen
  static const String settingsNotifications = 'Prayer Notifications';
  static const String settingsNotificationsSubtitle = 'Receive daily reminders to pray';
  static const String settingsLogout = 'Logout';

  // Stats screen
  static const String statsTotalSubmitted = 'Total Prayers Submitted';
  static const String statsAnswered = 'Answered Prayers';
  static const String statsAwaiting = 'Awaiting breakthrough';
  static const String statsProgressLabel = 'Answered vs Unanswered';

  // General UI
  static const String loading = 'Loading';
  static const String noScripture = 'No scripture available.';
  static const String errorGeneric = 'Something went wrong. Please try again later.';
}