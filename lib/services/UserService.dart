import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:week3/components/message/Notification.dart';
import 'package:week3/services/Response.dart';
import '../components/message/Notification.dart';

Future<Response> login(String username, String password) async {
  showLoader();
  final http.Response response = await http.post(
      Uri.parse('https://englishcenter-spkt-api.herokuapp.com/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password
      }));

  dismiss();
  if (response.statusCode == 200) {
    return Response.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('fail');
  }
}
