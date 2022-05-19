import 'package:english_center/providers/CommonProvider.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/providers/ScheduleProvider.dart';
import 'package:english_center/screen/Login.dart';
import 'package:english_center/screen/Main.dart';
import 'package:english_center/screen/Signup.dart';
import 'package:english_center/screen/tabs/Home.dart';
import 'package:english_center/screen/tabs/More.dart';
import 'package:english_center/screen/tabs/more/ChangePassword.dart';
import 'package:english_center/screen/tabs/schedules/DetalSchedule.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MemberProvider()),
      ChangeNotifierProvider(create: (context) => CommandProvider()),
      ChangeNotifierProvider(create: (context) => ScheduleProvider()),
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
        Locale('en', ''),
        Locale('vi', ''),
      ],
      builder: EasyLoading.init(),
    );
  }
}
