import 'package:intl/intl.dart';

class DateHelper{

  static String getCurrentDateInWords(){
    final now = DateTime.now().add(Duration(days: 5));
    final dayFormat = DateFormat('dd');
    final monthFormat = DateFormat('MMM');
    final yearFormat = DateFormat('yyyy');

    final day = dayFormat.format(now);
    final month = monthFormat.format(now);
    final year = yearFormat.format(now);

    return "$day${getDaySuffix(int.parse(day))} $month $year";
  }

  static String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
}