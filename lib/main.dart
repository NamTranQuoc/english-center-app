import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/screen/Main.dart';
import 'package:week3/screen/Signup.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('vi', ''),
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('vi', ''), // Spanish, no country code
      ],
      builder: EasyLoading.init(),
    ),
  );
}
