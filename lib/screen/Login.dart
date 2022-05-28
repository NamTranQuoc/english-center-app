import 'package:english_center/screen/Main.dart';
import 'package:english_center/screen/Signup.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:english_center/services/Common.dart';
import 'package:english_center/util/Enums.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/background/background.dart';
import '../components/button/ButtonText.dart';
import '../components/input/InputCustom.dart';
import '../components/input/InputPassword.dart';
import '../util/LocalStorage.dart';
import 'forget_password/RequestPassword.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  final LocalStorage storage = LocalStorage();

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.storage.getToken().then((value) {
      if (value != '') {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return MainScreen();
        }));
      }
    });
  }

  onLogin() {
      login(usernameController.text, passwordController.text).then((value) {
        widget.storage.setToken(value.payload);
        FirebaseMessaging.instance.getToken().then((v) {
          if (v != null) {
            postAuthenticated('${Common.host}/auth/login_success?token=$v', {}, token: value.payload, loader: false);
          }
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return MainScreen();
        }));
      });
  }

  onLoginWithGoogle() {
    loginWithGoogle().then((value) {
      if (value.code == 9999) {
        widget.storage.setToken(value.payload);
        FirebaseMessaging.instance.getToken().then((v) {
          if (v != null) {
            postAuthenticated('${Common.host}/auth/login_success?token=$v', {}, token: value.payload, loader: false);
          }
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return MainScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  AppLocalizations.of(context).login,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Color(0xFF2661FA),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 80.0),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: InputCustom(AppLocalizations.of(context).username, usernameController, InputType.REQUEST, AppLocalizations.of(context).validateErrorFormat),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: InputPassword(AppLocalizations.of(context).password, passwordController),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: ButtonText(AppLocalizations.of(context).forgetPassword + "?", const TextStyle(color: Color(0xFF2661FA)), () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return RequestPassword();
                  }));
                }),
              ),

              Container(
                alignment: Alignment.centerRight,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 50, bottom: 10, left: 20),
                      child: RaisedButton(
                        onPressed: () {
                          onLogin();
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 240,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2661FA),
                                    Color(0xFF6685E3),
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            AppLocalizations.of(context).labelLogin,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onLoginWithGoogle();
                      },
                      mini: true,
                      elevation: 2,
                      child: const Image(
                        image: AssetImage("assets/images/google.png"),
                      ),
                    )
                    /*ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF2661FA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          )),

                      onPressed: () {
                        onLogin();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          AppLocalizations.of(context).labelLogin,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()))
                  },
                  child: Text(
                    AppLocalizations.of(context).labelDontHaveAccount,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
