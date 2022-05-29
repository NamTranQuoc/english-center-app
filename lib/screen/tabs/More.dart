import 'package:english_center/domain/Member.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/screen/tabs/profileComponents/body.dart';
import 'package:english_center/services/MemberService.dart';
import 'package:english_center/util/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    MemberProvider memberProvider =
        Provider.of<MemberProvider>(context, listen: false);
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
      body: BodyScreen(),
    );
  }
}
