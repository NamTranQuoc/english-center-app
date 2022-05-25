import 'package:english_center/components/background/background.dart';
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
        body: Background(
          isShowIcon: true,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            AppLocalizations.of(context).changePasswordV2,
                            style: const TextStyle(
                              fontSize: 32,
                              color: Color(0xFF2661FA),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 40.0),
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
                  const SizedBox(height: 20,),
                  Padding(  padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [Expanded(child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF2661FA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            )),

                        onPressed: () {
                          onSubmit();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,

                          padding: const EdgeInsets.all(0),
                          child: Text(
                            AppLocalizations.of(context).update,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),)],
                    ),
                  ),
                ],
              )),
        )
    );
  }
}
