import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/schedule/';

Future<Response> getSchedule(DateTime start, DateTime end) async {
  return postAuthenticated('${endpoint}gets_v2', {
    "from_date": start.millisecondsSinceEpoch,
    "to_date": end.millisecondsSinceEpoch + 86399999
  });
}
