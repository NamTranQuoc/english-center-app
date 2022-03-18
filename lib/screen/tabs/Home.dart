import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  HomeScreen();

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int selectedIndex = 0;
  TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Home"));
  }
}
