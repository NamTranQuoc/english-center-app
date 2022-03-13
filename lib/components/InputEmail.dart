
import 'package:flutter/material.dart';

class InputEmail extends StatefulWidget {
  InputEmail(this.label, this.usernameController);

  final String label;
  final TextEditingController usernameController;

  @override
  State<StatefulWidget> createState() => _InputEmail();

}

class _InputEmail extends State<InputEmail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (email) {
          if (isEmailValid(email!)) {
            return null;
          } else {
            return 'Vui lòng nhập email đúng định dạng';
          }
        },
        controller: widget.usernameController,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label),
      ),
    );
  }

  bool isEmailValid(String s) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(s);
  }
}
