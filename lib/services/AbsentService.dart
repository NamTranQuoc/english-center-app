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

Future<Response> registerAbsent(String scheduleId, String classroomId) async {
  return postAuthenticated('${endpoint}register_absent', {
    "schedule_id": scheduleId,
    "classroom_id": classroomId
  });
}