
import 'package:intl/intl.dart';

int StringToTimeStamp(String s) {
  return DateFormat("dd-MM-yyyy").parse(s).millisecondsSinceEpoch;
}
