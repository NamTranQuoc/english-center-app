
import 'package:english_center/screen/tabs/Home.dart';
import 'package:english_center/screen/tabs/More.dart';
import 'package:english_center/screen/tabs/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/CommonProvider.dart';


class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int tabIndex = 1;
  var language = "";
  late TabController tabController = TabController(length: 3, initialIndex: tabIndex, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          onPressed: (){
            CommandProvider provider = Provider.of<CommandProvider>(context, listen: false);
            if (provider.currentLocale.languageCode == 'vi') {
              provider.set(const Locale('en', ''));
              language = "vi";
            } else {
              provider.set(const Locale('vi', ''));
              language = "en";
            }
          },
          icon: Image.asset((language == "vi") ? 'images/GB@2x.png' : 'images/VN@2x.png'),
          splashRadius: 100,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){
              print("search");
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: (){
              print("notification");
            },
          ),
        ],
        // backgroundColor: Colors.amber,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.brown],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )
          ),
        ),
        elevation: 20,
        titleSpacing: 4,
      ),
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
