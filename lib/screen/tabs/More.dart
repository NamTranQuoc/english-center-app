
import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/upload/AvatarCustom.dart';
import 'package:english_center/domain/Member.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/screen/Login.dart';
import 'package:english_center/screen/tabs/more/ChangePassword.dart';
import 'package:english_center/services/MemberService.dart';
import 'package:english_center/util/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    AppLocalizations.of(context).loginWithGoogle, Colors.lightBlueAccent, () {}),
                ButtonCustom(AppLocalizations.of(context).changePassword, Colors.lightBlueAccent, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                }),
                ButtonCustom(AppLocalizations.of(context).logOut, Colors.lightBlueAccent, () {
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
