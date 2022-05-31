import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/document/';

Future<Response> getDocumentByStudent(String id) async {
  return getAuthenticated('${endpoint}get_by_class?id=$id');
}