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

import '../components/background/background.dart';

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
      signUp(name.text, email.text, gender, phone.text,
              stringToTimeStamp(dob.text))
          .then((value) {
        if (value.code == 9999) {
          showSuccess("signup_success");
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
      body: Background(
        child: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
            ),
            Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      AppLocalizations.of(context).labelSignUp,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Color(0xFF2661FA),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  InputCustom(
                      AppLocalizations.of(context).name,
                      name,
                      InputType.REQUEST,
                      AppLocalizations.of(context).validateErrorInputBlank),
                  InputCustom(
                      AppLocalizations.of(context).email,
                      email,
                      InputType.EMAIL,
                      AppLocalizations.of(context).validateErrorFormat),
                  InputCustom(
                      AppLocalizations.of(context).phoneNumber,
                      phone,
                      InputType.PHONE,
                      AppLocalizations.of(context).validateErrorFormat),
                  SelectCustom(
                      gender, genders, AppLocalizations.of(context).gender,
                      (val) {
                    setState(() {
                      gender = val;
                    });
                  }),
                  DatePicker(
                      AppLocalizations.of(context).dob, dob, DateTime.now()),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          onSignUp();
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
                            AppLocalizations.of(context).labelSignUp,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ButtonText(AppLocalizations.of(context).labelLogin,
                const TextStyle(color: Colors.black), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return LoginScreen();
              }));
            }),
          ],
        ),
      ),
    );
  }
}
