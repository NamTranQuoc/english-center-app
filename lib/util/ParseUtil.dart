import 'package:intl/intl.dart';

int stringToTimeStamp(String s) {
  return DateFormat("dd-MM-yyyy").parse(s).millisecondsSinceEpoch;
}

String timestampToString(int timestamp, {String? format}) {
  return DateFormat(format ?? "dd-MM-yyyy HH:mm")
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String timestampToDate(int timestamp) {
  return DateFormat("dd-MM-yyyy")
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String listToString(List<dynamic> dow) {
  String temp = "Thứ ";
  String result = "";
  for (var element in dow) {
    if (element != 8) {
      result += temp + element.toString() + " - ";
    } else {
      result += "Chủ nhật - ";
    }
  }
  if (result != "") {
    result = result.substring(0, result.length - 3);
  }
  return result;
}
