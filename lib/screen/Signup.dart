import 'package:flutter/material.dart';
import 'package:week3/components/Image/Logo.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'package:week3/components/button/ButtonText.dart';
import 'package:week3/components/input/InputCustom.dart';
import 'package:week3/components/select/SelectCustom.dart';
import 'package:week3/screen/Login.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  List<String> genders = ['Nam', 'Nữ', 'Khác'];

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String gender = 'Nam';

  void onSignUp() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return LoginScreen();
      }));

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
                          "Name", name, InputType.REQUEST, "Vui lòng nhập tên"),
                      InputCustom("Email", email, InputType.EMAIL,
                          "Vui lòng nhập đúng định dạng email"),
                      InputCustom("Phone number", phone, InputType.PHONE,
                          "Vui lòng nhập số điện thoại"),
                      SelectCustom(gender, genders, 'Gender'),
                    ],
                  ),
                ),
                ButtonCustom('ĐĂNG NHẬP', Colors.lightBlueAccent, onSignUp),
                ButtonText(
                    "Đăng nhập ngay", const TextStyle(color: Colors.black), () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                }),
              ],
            )));
  }
}
