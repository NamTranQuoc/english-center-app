import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'package:week3/components/upload/AvatarCustom.dart';
import 'package:week3/domain/Member.dart';
import 'package:week3/providers/MemberProvider.dart';
import 'package:week3/screen/Login.dart';
import 'package:week3/services/MemberService.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MemberProvider memberProvider = Provider.of<MemberProvider>(context, listen: false);
    if (memberProvider.currentMember.id == null) {
      getCurrentMember().then((value) {
        Member member = Member.fromJson(value.payload);
        memberProvider.set(member);
      });
    }
  }

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
                  child: Consumer<MemberProvider>(
                    builder: (context, provider, child) {
                      return Text(provider.currentMember.name ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold));
                    },
                  ),
                ),
                ButtonCustom(
                    'Cập Nhật Thông Tin', Colors.lightBlueAccent, () {}),
                ButtonCustom('Đổi Mật Khẩu', Colors.lightBlueAccent, () {}),
                ButtonCustom('Đăng Xuất', Colors.lightBlueAccent, () {
                  widget.storage.cleanToken();
                  Provider.of<MemberProvider>(context, listen: false)
                      .set(Member.fromJson({}));
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                }),
              ],
            )));
  }
}
