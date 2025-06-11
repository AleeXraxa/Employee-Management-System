import 'package:employee_management_system/core/app_exports.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }

  static String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required';
    }
    if (value.length < 6) {
      return 'Password must be atleast 6 characters long';
    }
    return null;
  }

  static String? validateName(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field is Required';
    }
    if (value.length < 4) {
      return 'Username must be atleast 6 characters long';
    }
    return null;
  }

  static String? requiredFiled(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field is Required';
    }
    return null;
  }

  static String? validateTimeField({
    required String? value,
    required String label,
    required String? startTimeText,
  }) {
    if (value == null || value.isEmpty) {
      return '$label is required';
    }

    if (label == 'End Time' &&
        startTimeText != null &&
        startTimeText.isNotEmpty) {
      try {
        TimeOfDay parseTime(String timeStr) {
          final parts = timeStr.split(' ');
          final timeParts = parts[0].split(':');
          int hour = int.parse(timeParts[0]);
          int minute = int.parse(timeParts[1]);
          final isPM = parts.length > 1 && parts[1].toLowerCase() == 'pm';
          if (isPM && hour != 12) hour += 12;
          if (!isPM && hour == 12) hour = 0;
          return TimeOfDay(hour: hour, minute: minute);
        }

        final start = parseTime(startTimeText);
        final end = parseTime(value);

        final now = DateTime.now();
        final startDateTime =
            DateTime(now.year, now.month, now.day, start.hour, start.minute);
        final endDateTime =
            DateTime(now.year, now.month, now.day, end.hour, end.minute);

        if (!endDateTime.isAfter(startDateTime)) {
          return 'End time must be after start time';
        }
      } catch (e) {
        return 'Invalid time format';
      }
    }

    return null;
  }
}
