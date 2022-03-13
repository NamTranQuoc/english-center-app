
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.schedule_sharp),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.menu),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("SCHEDULE PAGE"),
            ),
            Center(
              child: Text("HOME PAGE"),
            ),
            Center(
              child: Text("MENU PAGE"),
            ),
          ],
        ),
      ),
    );
  }
}
