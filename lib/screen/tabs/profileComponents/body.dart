import 'package:english_center/screen/tabs/more/ChangeLanguage.dart';
import 'package:english_center/screen/tabs/profileComponents/profile_menu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../domain/Member.dart';
import '../../../providers/MemberProvider.dart';
import '../../../services/Common.dart';
import '../../../services/MemberService.dart';
import '../../../util/Enums.dart';
import '../../../util/LocalStorage.dart';
import '../../Login.dart';
import '../more/ChangePassword.dart';
import '../more/MyCourse.dart';
import '../more/UpdateInformation.dart';
import 'info.dart';

class BodyScreen extends StatefulWidget {
  final LocalStorage storage = LocalStorage();

  BodyScreen();

  @override
  _BodyScreen createState() => _BodyScreen();
}

class _BodyScreen extends State<BodyScreen> {

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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          InfoScreen(),
          const SizedBox(height: 20), //20
          ProfileMenu(
            text: AppLocalizations.of(context).updateInformation,
            icon: "assets/icons/User Icon.svg",
            press:
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateInformation(
                        Provider.of<MemberProvider>(context)
                            .currentMember)),
              );
            },
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).labelMyCourse,
            icon: "assets/icons/folder.svg",
            press:
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCourseScreen()),
              );
            },
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).changePassword,
            icon: "assets/icons/Lock.svg",
            press:
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()),
              );
            },
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).labelScore,
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).labelLanguage,
            icon: "assets/icons/language.svg",
            press:
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeLanguage(),
              ));
            },
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).logOut,
            icon: "assets/icons/Log out.svg",
            press:
                () {
              FirebaseMessaging.instance.getToken().then((v) {
                if (v != null) {
                  postAuthenticated(
                      '${Common.host}/auth/logout?token=$v', {})
                      .then((value) {
                    widget.storage.cleanToken();
                    Provider.of<MemberProvider>(context, listen: false)
                        .set(Member.fromJson({}));
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return LoginScreen();
                    }));
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }
}