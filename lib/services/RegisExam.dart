import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/exam_schedule/';

Future<Response> getRegister() async {
  return getAuthenticated('${endpoint}get_register');
}

Future<Response> registerExam(String id) async {
  return postAuthenticated('${endpoint}register_v2', {'exam_id': id});
}
