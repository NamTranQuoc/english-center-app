import 'package:flutter/material.dart';
import 'package:week3/screen/Home.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/screen/Signup.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'English center',
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
    ),
  );
}
