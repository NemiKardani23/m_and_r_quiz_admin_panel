class DateTimeFormatter {
  DateTime dateTimeFormat(String? date, {bool? withTime = false}) {
    String finalDate = date.toString();
    finalDate = '${finalDate.toString().replaceAll(" ", 'T')}Z';
    return DateTime.parse(date.toString()).toUtc().toLocal();
  }

  /// TimeAgo format
  String timeAgo({String? dateTime}) {
    DateTime startTime = dateTimeFormat(dateTime);
    DateTime currentTime = DateTime.now();
    int diffDy = currentTime.difference(startTime).inDays;
    int diffHr = currentTime.difference(startTime).inHours;
    int diffMn = currentTime.difference(startTime).inMinutes;
    // print("*********${startTime}");
    Duration diff = DateTime.now().difference(startTime);

    /// To Display Today at Time
    if (isSameDay(startTime, currentTime)) {
      return "Today at ${formatTime(startTime)}";
    }

    /// To Display Yesterday at Time
    if (isYesterday(startTime, currentTime)) {
      return "Yesterday at ${formatTime(startTime)}";
    }

    /// To Display Years
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }

    /// To Display Months
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }

    /// To Display Weeks
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }

    /// To Display Days
    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    }

    /// To Display Hours
    if (diff.inMinutes > 60 && diff.inHours <= 24) {
      return "${diff.inHours} hours ago";
    }

    /// To Display Minutes
    if (diff.inMinutes > 0 && diff.inMinutes <= 60) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  String formatTime(DateTime time) {
    String period = time.hour >= 12 ? 'PM' : 'AM';
    int hour = time.hour > 12 ? time.hour - 12 : time.hour;
    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = time.minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr $period';
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isYesterday(DateTime date1, DateTime date2) {
    final difference = date2.difference(date1);
    return difference.inDays == 1 &&
        isSameDay(date1, date2.subtract(Duration(days: 1)));
  }
}
