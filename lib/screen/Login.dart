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
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
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
  }

  onLoginWithGoogle() {
    loginWithGoogle().then((value) {
      if (value.code == 9999) {
        widget.storage.setToken(value.payload);
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
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF2661FA),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 40.0),
              ),

              const SizedBox(height: 40.0),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: InputCustom(AppLocalizations.of(context).username, usernameController, InputType.REQUEST, AppLocalizations.of(context).validateErrorFormat),
              ),

              SizedBox(height: size.height * 0.03),

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

              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        onLoginWithGoogle();
                      },
                      mini: true,
                      elevation: 2,
                      child: const Image(
                        image: AssetImage("assets/images/google.png"),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xFF2661FA),),

                      onPressed: () {
                        onLogin();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          "LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()))
                  },
                  child: const Text(
                    "Don't Have an Account? Sign up",
                    style: TextStyle(
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
