import 'package:date_time_format/date_time_format.dart';

String getDateTime(String time) {
  return DateTimeFormat.format(
      new DateTime.fromMillisecondsSinceEpoch(int.parse(time)),
      format: DateTimeFormats.american);
}
