
import 'package:english_center/screen/tabs/Home.dart';
import 'package:english_center/screen/tabs/More.dart';
import 'package:english_center/screen/tabs/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';


class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainScreen> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  Widget getTab() {
    switch (_selectedTab) {
      case _SelectedTab.schedule:
        return ScheduleScreen();
      case _SelectedTab.person:
        return MoreScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: getTab(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Colors.black,
          backgroundColor: Colors.cyan,
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [

            /// Likes
            DotNavigationBarItem(
              icon: const Icon(Icons.schedule),
              selectedColor: const Color(0xff73544C),
            ),

            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: const Color(0xff73544C),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: const Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { schedule, home, person }
