import 'dart:async';

import 'package:english_center/services/Common.dart';
import 'package:english_center/services/Response.dart';
import 'package:english_center/util/Enums.dart';
import 'package:google_sign_in/google_sign_in.dart';

final endpoint = '${Common.host}/auth/';

Future<Response> login(String username, String password) async {
  return postUnauthenticated(
      '${endpoint}login', {"username": username, "password": password});
}

Future<Response> changePassword(
    String oldPassword, String newPassword, String confirmPassword) async {
  return postAuthenticated('${endpoint}change_password', {
    "old_password": oldPassword,
    "confirm_password": confirmPassword,
    "new_password": newPassword
  });
}

Future<Response> requestForgetPassword(String email) async {
  return getUnauthenticated(
      '${endpoint}request_code_forget_password/$email', {});
}

Future<Response> forgetPassword(String newPassword, String confirmPassword,
    String code, String email) async {
  return postUnauthenticated('${endpoint}forget_password/code', {
    "confirm_password": confirmPassword,
    "new_password": newPassword,
    "code": code,
    "username": email
  });
}

Future<Response> loginWithGoogle() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

  return postUnauthenticated('${endpoint}sign_with_google', {
    "avatar": googleSignInAccount!.photoUrl,
    "email": googleSignInAccount.email,
    "name": googleSignInAccount.displayName,
    "phone_number": null
  });
}
