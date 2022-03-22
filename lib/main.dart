import 'package:flutter/material.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/screen/Main.dart';
import 'package:week3/screen/Signup.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'English center',
      initialRoute: LoginScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
      builder: EasyLoading.init(),
    ),
  );
}
