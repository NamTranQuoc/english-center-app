import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/category_course/';

Future<Response> getStudyProgram() async {
  return getAuthenticated('${endpoint}get_all');
}