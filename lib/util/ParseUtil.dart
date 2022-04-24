
import 'package:intl/intl.dart';

int stringToTimeStamp(String s) {
  return DateFormat("dd-MM-yyyy").parse(s).millisecondsSinceEpoch;
}


String timestampToString(int timestamp) {
  return DateFormat("dd-MM-yyyy hh:mm").format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}
