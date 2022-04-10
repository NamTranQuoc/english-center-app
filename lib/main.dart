import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week3/providers/CommonProvider.dart';
import 'package:week3/providers/MemberProvider.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/screen/Main.dart';
import 'package:week3/screen/Signup.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MemberProvider()),
      ChangeNotifierProvider(create: (context) => CommandProvider()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      locale: Provider.of<CommandProvider>(context).currentLocale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('vi', ''), // Spanish, no country code
      ],
      builder: EasyLoading.init(),
    );
  }
}
