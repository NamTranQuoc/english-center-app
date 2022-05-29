import 'dart:convert';

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:english_center/domain/Schedule.dart';
import 'package:english_center/main.dart';
import 'package:english_center/providers/ScheduleProvider.dart';
import 'package:english_center/screen/tabs/DashBoard.dart';
import 'package:english_center/screen/tabs/More.dart';
import 'package:english_center/screen/tabs/RegisExam.dart';
import 'package:english_center/screen/tabs/Schedule.dart';
import 'package:english_center/screen/tabs/schedules/DetalSchedule.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int tabIndex = 1;
  var language = "";
  late TabController tabController =
      TabController(length: 4, initialIndex: tabIndex, vsync: this);

  @override
  void initState() {
    super.initState();

    var initAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: ' + message.data["id"]);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
            payload: json.encode(message.data));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        onSelectNotification(json.encode(message.data));
      }
    });
  }

  Future<dynamic> onSelectNotification(String? payload) async {
    print("onSelectNotification");
    Map<String, dynamic> data = json.decode(payload ?? "{}");
    switch (data["type"]) {
      case "schedule":
      case "exam-schedule":
        ScheduleProvider scheduleProvider =
            Provider.of<ScheduleProvider>(context, listen: false);
        scheduleProvider.set(<String, List<Schedule>>{});
        Schedule schedule = Schedule(
            title: data['title'],
            id: data['id'],
            teacher: data['teacher'],
            room: data['room'],
            start: int.parse(data['start']),
            end: int.parse(data['end']),
            session: int.parse(data['session']),
            courseId: data['course_id'],
            maxStudent: int.parse(data['max_student']),
            tookPlace: data['took_place'] == 'true',
            classroomId: data['classroom_id'],
            isAbsent: data['is_absent'] == 'true',
            isExam: data['is_exam'] == 'true');
        DateTime datetime =
            DateTime.fromMillisecondsSinceEpoch(schedule.start!);
        String key = '${datetime.year}-${datetime.month}-${datetime.day}';
        List<Schedule> a = [];
        a.add(schedule);
        scheduleProvider.putIfAbsent(key, a);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailSchedule(key, 0)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.schedule_sharp, color: Colors.blue),
          Icon(Icons.home, color: Colors.blue),
          Icon(Icons.check, color: Colors.blue),
          Icon(Icons.menu, color: Colors.blue),
        ],
        inactiveIcons: const [
          Icon(Icons.schedule_sharp, color: Colors.black),
          Icon(Icons.home, color: Colors.black),
          Icon(Icons.check, color: Colors.black),
          Icon(Icons.menu, color: Colors.black),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        initIndex: tabIndex,
        onChanged: (v) {
          tabIndex = v;
          tabController.animateTo(v);
          setState(() {});
        },
        // tabCurve: ,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.blue,
        elevation: 10,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          ScheduleScreen(),
          const DashBoardScreen(),
          RegisExamScreen(),
          MoreScreen(),
        ],
      ),
    );
  }
}
