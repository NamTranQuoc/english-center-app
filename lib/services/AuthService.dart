import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/auth/';

Future<Response> login(String username, String password) async {
  return postUnauthenticated(
      '${endpoint}login',
      {
        "username": username,
        "password": password
      });
}