import 'package:flutter/material.dart';
import 'package:week3/screen/Signup.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> with InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

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
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (email) {
                            if (isEmailValid(email!)) {
                              return null;
                            } else {
                              return 'Vui lòng nhâp email';
                            }
                          },
                          controller: usernameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (password) {
                            if (isPasswordValid(password!)) {
                              return null;
                            } else {
                              return 'Password phải dài hơn 6 ký tự';
                            }
                          },
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  })),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 75,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text('ĐĂNG NHẬP'),
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                        }
                      },
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

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length > 6;

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
