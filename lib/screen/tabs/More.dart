import 'package:flutter/material.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'package:week3/components/upload/AvatarCustom.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/util/LocalStorage.dart';

class MoreScreen extends StatefulWidget {
  static const routeName = '/menu';
  final LocalStorage storage = LocalStorage();

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
                AvatarCustom(),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  alignment: Alignment.center,
                  child: const Text("Trần Quốc Nam",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ButtonCustom('Cập Nhật Thông Tin', Colors.lightBlueAccent, () {}),
                ButtonCustom('Đổi Mật Khẩu', Colors.lightBlueAccent, () {}),
                ButtonCustom('Đăng Xuất', Colors.lightBlueAccent, () {
                  widget.storage.cleanToken();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                }),
              ],
            )));
  }
}
