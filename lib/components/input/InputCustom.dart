
import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  final String label;
  final TextEditingController usernameController;
  final InputType inputType;
  final String textError;

  InputCustom(this.label, this.usernameController, this.inputType, this.textError);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (text) {
          if (validation(text!)) {
            return null;
          } else {
            return textError;
          }
        },
        controller: usernameController,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label),
      ),
    );
  }

  bool validation(String s) {
    switch(inputType) {
      case InputType.EMAIL:
        return isEmailValid(s);
      case InputType.REQUEST:
        return isNotBlank(s);
      default:
        return true;
    }
  }

  bool isEmailValid(String s) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(s);
  }

  bool isNotBlank(String s) {
    return s.isNotEmpty;
  }
}

enum InputType {
  EMAIL,
  REQUEST,
  NONE
}
