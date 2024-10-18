library utils;

import 'package:intl/intl.dart';

class NKDateUtils {
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayFormat = DateFormat('dd');
  static final DateFormat _firstDayFormat = DateFormat('MMM dd');
  static final DateFormat _fullDayFormat = DateFormat('EEE MMM dd, yyyy');
  static final DateFormat _apiDayFormat = DateFormat('dd-MMM-yyyy');
  // static final DateFormat _apiDayFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
  static final DateFormat _fullDayWithTimeFormat =
      DateFormat('EEE MMM dd, yyyy hh:mm a');
  static final DateFormat _apiFullDayWithTimeFormat =
      DateFormat('yyyy-MM-dd hh:mm:ss');

  static final DateFormat _fullDayMonthYearTimeFormatWithTime =
      DateFormat('dd MMM yyyy,  hh:mm a');

  static String appDisplayDate(DateTime d) => _fullDayWithTimeFormat.format(d);

  static String formatMonth(DateTime d) => _monthFormat.format(d);

  static String formatDay(DateTime d) => _dayFormat.format(d);

  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);

  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);

  static String formatDuration(Duration d) => d.toString(); /// show Like "2:30:00" 

  static String formatDurationHHMMSS(Duration d) {
    return d.toString().split('.').first;
  }

  static String customFormatDate(DateTime d, {required String formatDate}) =>
      DateFormat(formatDate).format(d);

  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
  static String fullDayWithTimeFormat(DateTime d) =>
      _fullDayWithTimeFormat.format(d);

  static String fullDayWithTimeFormatCustoms(DateTime d) =>
      _fullDayMonthYearTimeFormatWithTime.format(d);

  static String apiFullDayWithTimeFormat(DateTime d) =>
      _apiFullDayWithTimeFormat.format(d);

  static const List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  static const List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    var first = firstDayOfMonth(month);
    // var daysBefore = first.weekday;
    // var firstToDisplay = first.subtract(Duration(days: daysBefore));
    var last = NKDateUtils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    // var lastToDisplay = last.add(Duration(days: daysAfter));
    return daysRange(first, last).toList();
  }

  static Iterable<DateTime> daysRange(DateTime first, DateTime last) {
    var listOfDates = List<DateTime>.generate(
        last.day, (i) => DateTime(first.year, first.month, i + 1));
    return listOfDates;
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.day <= end.day) {
      yield i;
      i = i.add(const Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(const Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(const Duration(days: 7));
  }

  static Duration difrancenceBetweenDate(DateTime a, DateTime b) {
    return b.difference(a);
  }

  static String formatDate(DateTime date) {
    //FORMAT LIKE "Thursday 03 March 2022"
    return DateFormat('EEEE dd MMMM yyyy').format(date);
  }

  static String formatDateYMD(DateTime date) {
    //FORMAT LIKE "Thursday 03 March 2022"
    return DateFormat('yMMMMd').format(date);
  }

  static String formatDateRemiders(DateTime date) {
    //FORMAT LIKE "Thursday 03 March 2022"
    return DateFormat('hh:mm').format(date);
  }

  static DateTime formatStringDateTime(String date) {
    //FORMAT LIKE "Thursday 03 March 2022"
    return DateFormat("dd-MMM-yyyy hh:mm:ss").parse(date);
  }

  static DateTime formatStringDate(String date) {
    //FORMAT LIKE "Thursday 03 March 2022"
    return DateTime.parse(date);
  }

  static String timeFormat(Duration duration) {
    int seconds = duration.inSeconds;
    int minutes = seconds ~/ 60;
    int hours = minutes ~/ 60;

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    } else if (minutes > 0) {
      return '${minutes.remainder(60).toString().padLeft(2, '0')}:${seconds.remainder(60).toString().padLeft(2, '0')}';
    } else {
      return seconds.remainder(60).toString().padLeft(2, '0');
    }
  }
}

extension StringDateToDate on String {
  DateTime get toDate => DateTime.parse(this);
}

extension StringToDuration on String {
  /// Converts a string in the format of "HH:mm:ss" or "mm:ss" or "ss" into a Duration.
  Duration get toDuration {
    // Split the string into parts by the colon (":")
    List<String> parts = split(':');
    
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    // Determine which parts are available (HH:mm:ss, mm:ss, ss)
    if (parts.length == 3) {
      // If string contains hours, minutes, and seconds
      hours = int.tryParse(parts[0]) ?? 0;
      minutes = int.tryParse(parts[1]) ?? 0;
      seconds = int.tryParse(parts[2]) ?? 0;
    } else if (parts.length == 2) {
      // If string contains minutes and seconds
      minutes = int.tryParse(parts[0]) ?? 0;
      seconds = int.tryParse(parts[1]) ?? 0;
    } else if (parts.length == 1) {
      // If string contains only seconds
      seconds = int.tryParse(parts[0]) ?? 0;
    }

    // Return a Duration based on the parsed values
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}


