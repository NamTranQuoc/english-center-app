import 'package:english_center/components/Image/Logo.dart';
import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/screen/forget_password/ForgetPassword.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestPassword extends StatefulWidget {
  static const routeName = '/request_password';

  RequestPassword();

  @override
  _RequestPassword createState() => _RequestPassword();
}

class _RequestPassword extends State<RequestPassword> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      requestForgetPassword(email.text).then((value) {
        if (value.code == 9999) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return ForgetPassword(email.text);
          }));
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
                Logo(),
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputCustom(
                          AppLocalizations.of(context).email,
                          email,
                          InputType.EMAIL,
                          AppLocalizations.of(context).validateErrorFormat)
                    ],
                  ),
                ),
                ButtonCustom(AppLocalizations.of(context).send,
                    Colors.lightBlueAccent, onSubmit),
              ],
            )));
  }
}
