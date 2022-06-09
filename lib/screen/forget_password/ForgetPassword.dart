import 'package:english_center/components/background/background.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:english_center/screen/Login.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/forget_password';

  final String email;

  ForgetPassword(this.email);

  @override
  _ForgetPassword createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController code = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      forgetPassword(
              newPassword.text, confirmPassword.text, code.text, widget.email)
          .then((value) {
        if (value.code == 9999) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return LoginScreen();
          }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
            isShowIcon: true,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 130.0, left: 10),
                  child: Text(
                    AppLocalizations.of(context).password,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xFF2661FA),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputCustom("Code", code, InputType.REQUEST,
                          AppLocalizations.of(context).validateErrorFormat),
                      InputPassword(AppLocalizations.of(context).newPassword,
                          newPassword),
                      InputPassword(
                          AppLocalizations.of(context).confirmPassword,
                          confirmPassword),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: RaisedButton(
                    onPressed: () {
                      onSubmit();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color(0xFF2661FA),
                            Color(0xFF6685E3),
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        AppLocalizations.of(context).restore,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // ButtonCustom(AppLocalizations.of(context).restore, Colors.lightBlueAccent, onSubmit),
              ],
            )));
  }
}
