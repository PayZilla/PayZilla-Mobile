import 'dart:math';

import 'package:intl/intl.dart';

extension DateUtil on DateTime {
  String getDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String getDateAsWords() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String getTime() {
    return DateFormat('h:mm a').format(this);
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference.inSeconds.abs() <= 0) {
      return 'now';
    }
    if (difference.inSeconds.abs() < 60) {
      if (difference.inSeconds.abs() == 1) {
        return 'a second ago';
      }
      return '${difference.inSeconds} seconds ago';
    }
    if (difference.inMinutes.abs() < 60) {
      if (difference.inMinutes.abs() == 1) {
        return 'a minute ago';
      }
      return '${difference.inMinutes} minutes ago';
    }
    if (difference.inHours.abs() < 24) {
      if (difference.inHours.abs() == 1) {
        return 'an hour ago';
      }
      return '${difference.inHours} hours ago';
    }
    if (difference.inDays.abs() < 7) {
      if (difference.inDays.abs() == 1) {
        return 'a day ago';
      }
      return '${difference.inDays} days ago';
    }
    return getDateAsWords();
  }

  static DateTime randomPastDate() {
    return DateTime.now().subtract(Duration(days: Random().nextInt(365)));
  }

  static DateTime covertStringToDate(String date) {
    return DateTime.parse(date);
  }
}

class DateFormatUtil {
  DateFormatUtil._();

  static String formatDate(DateFormat dateFormat, String time) {
    return dateFormat.format(DateTime.parse(time));
  }

  static DateFormat getDateFormat(String pattern) {
    return DateFormat(pattern);
  }

  static String formatFullMonthOfYear(DateTime date) {
    var suffix = 'th';
    final digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ['st', 'nd', 'rd'][digit - 1];
    }
    return DateFormat("d'$suffix' of MMMM, yyyy").format(date);
  }

  static String dayOfMonth(int day) {
    final _dayMap = {1: 'st', 2: 'nd', 3: 'rd'};
    return "$day${_dayMap[day] ?? 'th'}";
  }
}

// format types
final utcTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
final dateTimeFormatWithMeridian = DateFormat('dd MMM yyyy, hh:mm a');
final dateTimeFormat = DateFormat('dd MMM, yyyy hh:mm:ss');
final dateFormat = DateFormat('dd MMM yyyy');
final dateFormat1 = DateFormat('dd MMMM yyyy');
final dateFormat2 = DateFormat('dd/MMM/yyyy');
final timeFormat = DateFormat('hh:mm a');
final timeFormat2 = DateFormat('HH:mm a');
final dateMonthTimeFormat = DateFormat('dd MMM, hh:mm a');
final dateMonthFormat = DateFormat('dd MMM');
final dayFormat = DateFormat('E');
final dayNumberFormat = DateFormat('d');
final apiRangeFormat = DateFormat('yyyy-MM-dd');
final fullMonthYearFormat = DateFormat('MMMM, yyyy');
final fullMonthOfYearFormat = DateFormat('dd of MMMM, yyyy');
