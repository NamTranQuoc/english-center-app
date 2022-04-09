import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:week3/components/message/Notification.dart';
import 'package:week3/services/Response.dart';
import 'package:week3/util/LocalStorage.dart';
import '../components/message/Notification.dart';

Future<Response> postUnauthenticated(String endpoint, Object body) async {
  showLoader();
  final http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body));

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(response.body));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    throw Exception('authentication');
  }
}

Future<Response> postAuthenticated(String endpoint, Object body) async {
  showLoader();
  String token = await LocalStorage().getToken();
  final http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body));

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(response.body));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    LocalStorage().cleanToken();
    throw Exception('authentication');
  }
}

Future<Response> putUnauthenticated(String endpoint, Object body) async {
  showLoader();
  final http.Response response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body));

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(response.body));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    throw Exception('authentication');
  }
}

Future<Response> putAuthenticated(String endpoint, Object body) async {
  showLoader();
  String token = await LocalStorage().getToken();
  final http.Response response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body));

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(response.body));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    LocalStorage().cleanToken();
    throw Exception('authentication');
  }
}

Future<Response> getUnauthenticated(String endpoint, Object body) async {
  showLoader();
  final http.Response response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      });

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(response.body));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    throw Exception('authentication');
  }
}

Future<Response> getAuthenticated(String endpoint) async {
  showLoader();
  String token = await LocalStorage().getToken();
  final http.Response response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(response.body));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    LocalStorage().cleanToken();
    throw Exception('authentication');
  }
}
