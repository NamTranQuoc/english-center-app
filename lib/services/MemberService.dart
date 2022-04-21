
import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';

final endpoint = '${Common.host}/member/';

Future<Response> getCurrentMember() async {
  return getAuthenticated('${endpoint}get_current');
}

Future<Response> signUp(String name, String email, String gender, String phoneNumber, int dob) async {
  return postUnauthenticated('${endpoint}add', {
    "name": name,
    "email": email,
    "gender": gender,
    "phone_number": phoneNumber,
    "type": "student",
    "dob": dob
  });
}
