import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';

  ScheduleScreen();

  @override
  _ScheduleScreen createState() => _ScheduleScreen();
}

class _ScheduleScreen extends State<ScheduleScreen> {
  int selectedIndex = 0;
  TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Schedule"));
  }
}
