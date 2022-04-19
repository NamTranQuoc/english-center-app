import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/change_password';

  ChangePassword();

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      changePassword(oldPassword.text, newPassword.text, confirmPassword.text).then((value) {
        print(value.code);
        if(value.code == 9999) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: ListView(
              children: <Widget>[
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputPassword(AppLocalizations.of(context).oldPassword,
                          oldPassword),
                      InputPassword(AppLocalizations.of(context).newPassword,
                          newPassword),
                      InputPassword(
                          AppLocalizations.of(context).confirmPassword,
                          confirmPassword),
                    ],
                  ),
                ),
                ButtonCustom(AppLocalizations.of(context).labelLogin,
                    Colors.lightBlueAccent, onSubmit),
              ],
            )));
  }
}
