import 'package:intl/intl.dart';

abstract class DateFormatter {
  DateFormatter._();

  // Full date used in footer widget
  static String formatFullDate(DateTime date) =>
      DateFormat('EEEE, dd MMMM yyyy').format(date);

  // Short date and time format
  static String formatShortDateTime(DateTime date) => 
      DateFormat('dd MMM yyyy | HH:mm').format(date);

  // Date only
  static String formatDate(DateTime date) =>
      DateFormat('dd MMMM yyyy').format(date);

  // Time only
  static String formatTimeOnly(DateTime date) => 
      DateFormat('HH:mm').format(date);

  // Answered prayer timestamp
  static String formatAnsweredAt(DateTime date) => 
      'Answered on ${DateFormat('dd MMM yyyy').format(date)} '
      'at ${DateFormat('HH:mm').format(date)}';

  // Prayer request addition timestamp
  static String formatCreatedAt(DateTime date) => 
      'Created ${DateFormat('dd MMM yyyy').format(date)} '
      'at ${DateFormat('HH:mm').format(date)}';
}