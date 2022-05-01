import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/absent/';

Future<Response> getClassroomAbsent(String scheduleId) async {
  return postAuthenticated('${endpoint}get_classroom_absents', {
    "schedule_id": scheduleId
  });
}
