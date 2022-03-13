import 'package:flutter/material.dart';
import 'package:week3/components/InputEmail.dart';
import 'package:week3/components/InputPassword.dart';
import 'package:week3/screen/Home.dart';
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
          return const HomeScreen();
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
                Container(
                    height: 100,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: const Image(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/englishcenter-2021.appspot.com/o/images%2Flogo.png?alt=media'),
                    )),
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputEmail("Username", usernameController),
                      InputPassword("Password", passwordController),
                    ],
                  ),
                ),
                Container(
                    height: 75,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text('ĐĂNG NHẬP'),
                      onPressed: onLogin,
                    )),
                Container(
                  height: 75,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Forgot Password?',
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                    height: 75,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        child: const Text('TẠO TÀI KHOẢN'),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return SignUpScreen();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                        ))),
                Container(
                    height: 75,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        child: const Text('ĐĂNG NHẬP VỚI GOOGLE'),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ))),
              ],
            )));
  }
}
