
import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/member/';

Future<Response> getCurrentMember() async {
  return getAuthenticated('${endpoint}get_current');
}
