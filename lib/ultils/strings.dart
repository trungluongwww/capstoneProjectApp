class UString {
  static String convertDateTimeToDescription(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

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
}
