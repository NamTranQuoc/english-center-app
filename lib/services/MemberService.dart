import 'dart:async';

import 'package:week3/services/Common.dart';
import 'package:week3/services/Response.dart';
import 'package:week3/util/Enums.dart';

final endpoint = '${Common.host}/member/';

Future<Response> getCurrentMember() async {
  return getAuthenticated('${endpoint}get_current');
}
