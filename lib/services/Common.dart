
import 'dart:async';
import 'dart:convert';

import 'package:english_center/services/Response.dart';
import 'package:english_center/util/LocalStorage.dart';
import 'package:http/http.dart' as http;
import '../components/message/Notification.dart';

Future<Response> postUnauthenticated(String endpoint, Object body) async {
  showLoader();
  final http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(body));

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    throw Exception('authentication');
  }
}

Future<Response> postAuthenticated(String endpoint, Object body, {String? token, bool? loader}) async {
  if (loader != false) {
    showLoader();
  }
  String _token = token ?? await LocalStorage().getToken();
  final http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_token'
      },
      body: jsonEncode(body));

  if (loader != false) {
    dismiss();
  }
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(body));

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    throw Exception('authentication');
  }
}

Future<Response> putAuthenticated(String endpoint, Object body, {String? token, bool? loader}) async {
  if (loader != false) {
    showLoader();
  }
  String _token = await LocalStorage().getToken();
  final http.Response response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_token'
      },
      body: jsonEncode(body));

  if (loader != false) {
    dismiss();
  }
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
        'Content-Type': 'application/json; charset=utf-8',
      });

  dismiss();
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    if (result.code != 9999) {
      showError(result.message!);
      throw Exception(result.message);
    }
    return result;
  } else {
    throw Exception('authentication');
  }
}

Future<Response> getAuthenticated(String endpoint, {String? token, bool? loader}) async {
  if (loader != false) {
    showLoader();
  }
  String _token = await LocalStorage().getToken();
  final http.Response response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_token'
      });

  if (loader != false) {
    dismiss();
  }
  if (response.statusCode == 200) {
    Response result = Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
