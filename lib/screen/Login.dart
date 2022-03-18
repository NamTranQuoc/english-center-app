import 'package:flutter/material.dart';
import 'package:week3/components/Image/Logo.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'package:week3/components/input/InputCustom.dart';
import 'package:week3/components/input/InputPassword.dart';
import 'package:week3/screen/Main.dart';
import 'package:week3/screen/Signup.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onLogin() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      if (usernameController.text == 'user@gmail.com' &&
          passwordController.text == 'user123') {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return MainScreen();
        }));
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Thông báo'),
                  content: const Text('Username hoăc password không đúng'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      }
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
                      InputCustom("Username", usernameController, InputType.EMAIL, 'Vui lòng nhập đúng định dạng email'),
                      InputPassword("Password", passwordController),
                    ],
                  ),
                ),
                ButtonCustom('ĐĂNG NHẬP', Colors.lightBlueAccent, onLogin),
                Container(
                  height: 75,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Quên mật khẩu?',
                    textAlign: TextAlign.right,
                  ),
                ),
                ButtonCustom('TẠO TÀI KHOẢN', Colors.blueGrey, () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return SignUpScreen();
                      }));
                    }),
                ButtonCustom('ĐĂNG NHẬP VỚI GOOGLE', Colors.green, () {}),
              ],
            )));
  }
}
