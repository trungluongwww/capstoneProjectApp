import 'package:intl/intl.dart';

class UString {
  static String convertDateTimeToDescription(DateTime dateTime) {
    final now = DateTime.now().toUtc();

    DateTime utcPlus7 = DateTime.utc(
      now.year,
      now.month,
      now.day,
      now.hour + 7,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
    var difference = utcPlus7.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        final minutes = difference.inMinutes;
        return '$minutes phút trước';
      } else {
        final hours = difference.inHours;
        return '$hours giờ trước';
      }
    } else if (difference.inDays > 0 && difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ngày trước';
    } else if (difference.inDays >= 7 && difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks tuần trước';
    } else if (difference.inDays >= 30 && difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years năm trước';
    }
  }

  static String getShortTime(DateTime time) {
    return DateFormat("dd/MM HH:mm").format(time);
  }

  static String getDateWithoutTime(DateTime time) {
    return DateFormat("dd/MM/yyyy").format(time);
  }

  static String getTimeWithoutDate(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  static String getCurrentcy(int? numb) {
    if (numb == null) return "0";

    return NumberFormat("#,##0", "es_US").format(numb);
  }
}
