import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/screen/Main.dart';
import 'package:week3/screen/Signup.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
