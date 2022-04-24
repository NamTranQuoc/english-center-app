
import 'package:english_center/components/Image/Logo.dart';
import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/button/ButtonText.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/message/Notification.dart';
import 'package:english_center/components/picker/DatePicker.dart';
import 'package:english_center/components/select/SelectCustom.dart';
import 'package:english_center/screen/Login.dart';
import 'package:english_center/services/MemberService.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  List<String> genders = ['male', 'female', 'other'];

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  String gender = 'male';

  void onSignUp() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      signUp(name.text, email.text, gender, phone.text, stringToTimeStamp(dob.text)).then((value) {
        if (value.code == 9999) {
          showSuccess("Sign Up Success");
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return LoginScreen();
          }));
        }
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
                Logo(),
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputCustom(
                          AppLocalizations.of(context).name, name, InputType.REQUEST,
                          AppLocalizations.of(context).validateErrorInputBlank),
                      InputCustom(AppLocalizations.of(context).email, email, InputType.EMAIL,
                          AppLocalizations.of(context).validateErrorFormat),
                      InputCustom(AppLocalizations.of(context).phoneNumber, phone, InputType.PHONE,
                          AppLocalizations.of(context).validateErrorFormat),
                      SelectCustom(gender, genders, AppLocalizations.of(context).gender, (val) {setState(() {
                        gender = val;
                      });}),
                      DatePicker(AppLocalizations.of(context).dob, dob, DateTime.now()),
                    ],
                  ),
                ),
                ButtonCustom(AppLocalizations.of(context).signUp, Colors.lightBlueAccent, onSignUp),
                ButtonText(
                    AppLocalizations.of(context).labelLogin, const TextStyle(color: Colors.black), () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                }),
              ],
            )));
  }
}
