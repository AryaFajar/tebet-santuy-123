import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String fullDate() {
    return DateFormat.yMMMMd('in_ID').format(
        DateTime.fromMicrosecondsSinceEpoch((this).microsecondsSinceEpoch));
  }
}
