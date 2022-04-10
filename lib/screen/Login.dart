
import 'package:english_center/components/Image/Logo.dart';
import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:english_center/screen/Main.dart';
import 'package:english_center/screen/Signup.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../util/LocalStorage.dart';

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
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return MainScreen();
        }));
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
                          "Username",
                          usernameController,
                          InputType.EMAIL,
                          'Vui lòng nhập đúng định dạng email'),
                      InputPassword("Password", passwordController),
                    ],
                  ),
                ),
                ButtonCustom(AppLocalizations.of(context).labelLogin, Colors.lightBlueAccent, onLogin),
                Container(
                  height: 75,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Quên mật khẩu?',
                    textAlign: TextAlign.right,
                  ),
                ),
                ButtonCustom('Tạo Tài Khoản', Colors.blueGrey, () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return SignUpScreen();
                  }));
                }),
                ButtonCustom('Đăng nhập Với Google', Colors.green, () {}),
              ],
            )));
  }
}
