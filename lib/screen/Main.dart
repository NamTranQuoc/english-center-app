
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:week3/screen/tabs/Home.dart';
import 'package:week3/screen/tabs/More.dart';
import 'package:week3/screen/tabs/Schedule.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  MainScreen();

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int selectedIndex = 0;
  TextEditingController keyword = TextEditingController();

  Widget getTab() {
    switch (selectedIndex) {
      case 0:
        return ScheduleScreen();
      case 2:
        return MoreScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Search',
              ),
            )
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )],
      ),
      body: getTab(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Colors.green,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          showSelectedItemShadow: false,
          barHeight: 70,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.schedule_sharp,
            label: 'Schedule',
            selectedBackgroundColor: Colors.purple,
          ),
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
            selectedBackgroundColor: Colors.blue,
          ),
          FFNavigationBarItem(
            iconData: Icons.menu,
            label: 'More',
            selectedBackgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
