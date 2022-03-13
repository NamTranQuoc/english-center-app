
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  static const routeName = '/signup';

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Gender',
                    ),
                  ),
                ),
                Container(
                    height: 75,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text('ĐĂNG NHẬP'),
                      onPressed: () {},
                    )),
                Container(
                  height: 75,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Forgot Password',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            )));
  }
}
