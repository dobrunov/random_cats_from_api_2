//
//
class DateTimeConvert {
  static String simplyFormat(DateTime datetime) {
    String year = datetime.year.toString();
    String month = datetime.month.toString().padLeft(2, '0');
    String day = datetime.day.toString().padLeft(2, '0');
    String hour = datetime.hour.toString().padLeft(2, '0');
    String minute = datetime.minute.toString().padLeft(2, '0');
    String second = datetime.second.toString().padLeft(2, '0');

    return "$year-$month-$day $hour:$minute:$second";
  }
}
