import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/class/';

Future<Response> getClassRoomByCourse(String id) async {
  return getAuthenticated('${endpoint}get_by_course_id/$id');
}

Future<Response> getByKeyword(String keyword) async {
  return getAuthenticated('${endpoint}get_by_keyword?keyword=$keyword');
}
