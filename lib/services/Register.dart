import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/register/';

Future<Response> registerClassroom(String classId) async {
  return postAuthenticated(
      '${endpoint}add_v2', {"class_id": classId, "status": "unpaid"});
}
