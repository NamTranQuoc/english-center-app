import 'package:flutter/material.dart';
import 'package:week3/components/Image/Logo.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'package:week3/components/input/InputCustom.dart';
import 'package:week3/components/input/InputPassword.dart';
import 'package:week3/components/message/NotiDialog.dart';
import 'package:week3/components/message/Notification.dart';
import 'package:week3/screen/Main.dart';
import 'package:week3/screen/Signup.dart';
import 'package:week3/services/AuthService.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
                ButtonCustom(AppLocalizations.of(context)!.helloWorld, Colors.lightBlueAccent, onLogin),
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
