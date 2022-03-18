import 'package:flutter/material.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'package:week3/screen/Login.dart';

class MoreScreen extends StatefulWidget {
  static const routeName = '/menu';

  MoreScreen();

  @override
  _MoreScreen createState() => _MoreScreen();
}

class _MoreScreen extends State<MoreScreen> {
  int selectedIndex = 0;
  TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 150,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/englishcenter-2021.appspot.com/o/images%2Favatar.png?alt=media')),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  alignment: Alignment.center,
                  child: const Text("Trần Quốc Nam",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ButtonCustom(
                    'CẬP NHẬT THÔNG TIN', Colors.lightBlueAccent, () {}),
                ButtonCustom('ĐỔI MẬT KHẨU', Colors.lightBlueAccent, () {}),
                ButtonCustom('ĐĂNG XUẤT', Colors.lightBlueAccent, () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                }),
              ],
            )));
  }
}
