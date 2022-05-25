import 'package:english_center/components/background/background.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background(
          isShowIcon: true,
            child: ListView(
              padding: const EdgeInsets
              .symmetric(horizontal: 16,),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 130.0),
                ),
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          AppLocalizations.of(context).labelForgetPassword,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Color(0xFF2661FA),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 40,),
                      InputCustom(
                          AppLocalizations.of(context).email,
                          email,
                          InputType.EMAIL,
                          AppLocalizations.of(context).validateErrorFormat)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
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
                          width: size.width * 0.5,
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            AppLocalizations.of(context).send,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
