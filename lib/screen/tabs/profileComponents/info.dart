import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/upload/AvatarCustom.dart';
import '../../../constants.dart';
import '../../../domain/Member.dart';
import '../../../providers/MemberProvider.dart';
import '../../../services/MemberService.dart';
import '../../../util/LocalStorage.dart';

class InfoScreen extends StatefulWidget {
  final LocalStorage storage = LocalStorage();

  InfoScreen();

  @override
  _InfoScreen createState() => _InfoScreen();
}

class _InfoScreen extends State<InfoScreen> {

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
    double defaultSize = 10;
    return SizedBox(
      height: defaultSize * 24, // 240
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /*Container(
                  margin: EdgeInsets.only(bottom: defaultSize), //10
                  height: defaultSize * 14, //140
                  width: defaultSize * 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: defaultSize * 0.8, //8
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/user.png"),
                    ),
                  ),
                ),*/
                AvatarCustom(),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  alignment: Alignment.center,
                  child: Consumer<MemberProvider>(
                    builder: (context, provider, child) {
                      return Text(provider.currentMember.name ?? '',
                          style: const TextStyle(
                              fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                          ));
                    },
                  ),
                ), //5
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  alignment: Alignment.center,
                  child: Consumer<MemberProvider>(
                    builder: (context, provider, child) {
                      return Text(provider.currentMember.email ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8492A2),
                          ));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}