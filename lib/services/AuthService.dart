import 'dart:async';

import 'package:week3/services/Common.dart';
import 'package:week3/services/Response.dart';
import 'package:week3/util/Enums.dart';

final endpoint = '${Common.host}/auth/';

Future<Response> login(String username, String password) async {
  return postUnauthenticated(
      '${endpoint}login',
      {
        "username": username,
        "password": password
      });
}
