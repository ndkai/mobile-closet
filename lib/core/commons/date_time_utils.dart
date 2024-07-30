import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTime(String isoString,
      {bool showHour = true, bool showDay = true}) {
    print("isoString ${isoString}");
    try {
      Map<int, String> monthMap = {
        1: 'Jan',
        2: 'Feb',
        3: 'Mar',
        4: 'Apr',
        5: 'May',
        6: 'Jun',
        7: 'Jul',
        8: 'Aug',
        9: 'Sep',
        10: 'Oct',
        11: 'Nov',
        12: 'Dec',
      };
      DateTime dateTime = DateTime.parse(isoString);
      if (showHour) {
        return "${showDay ? dateTime.day : ""} ${monthMap[dateTime.month]}, ${dateTime.year}, ${dateTime.hour}:${dateTime.minute}";
      } else {
        return "${showDay ? "${dateTime.day} " : ""}${monthMap[dateTime.month]}, ${dateTime.year}";
      }
      // return "${dateTime.day} ${monthMap[dateTime.month]}, ${dateTime.year}, ${dateTime.hour}:${dateTime.minute}";
    } catch (e) {
      return "";
    }
  }

  static String formatDate(DateTime date, {bool showDate = true}) {
    if(showDate){
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(date);
    } else {
      final DateFormat formatter = DateFormat('yyyy-MM');
      return formatter.format(date);
    }
  }

  static String getBirthday(DateTime date) {
    try{
      return "${date.day}/${date.month}/${date.year}";
    } catch(e){
      return "";
    }
  }

  static (DateTime, DateTime) getWeekRange(DateTime currentDate) {
    int currentDayOfWeek = currentDate.weekday;
    int daysToMonday = currentDayOfWeek - DateTime.monday;
    int daysToSunday = DateTime.sunday - currentDayOfWeek;
    DateTime fromDate = currentDate.add(Duration(days: daysToMonday));
    DateTime toDate = currentDate.add(Duration(days: daysToSunday));
    return (fromDate, toDate);
  }
}
