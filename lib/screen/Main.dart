
import 'package:english_center/screen/tabs/Home.dart';
import 'package:english_center/screen/tabs/More.dart';
import 'package:english_center/screen/tabs/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';


class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int tabIndex = 1;
  late TabController tabController = TabController(length: 3, initialIndex: tabIndex, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.schedule_sharp, color: Colors.blue),
          Icon(Icons.home, color: Colors.blue),
          Icon(Icons.menu, color: Colors.blue),
        ],
        inactiveIcons: const [
          Icon(Icons.schedule_sharp, color: Colors.black),
          Icon(Icons.home, color: Colors.black),
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
          HomeScreen(),
          MoreScreen(),
        ],
      ),
    );
  }
}

enum _SelectedTab { schedule, home, person }
