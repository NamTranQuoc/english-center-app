
import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  final String label;
  final TextEditingController usernameController;
  final InputType inputType;
  final String textError;
  final bool? disable;

  InputCustom(this.label, this.usernameController, this.inputType, this.textError, {this.disable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        readOnly: disable ?? false,
        validator: (text) {
          if (validation(text!)) {
            return null;
          } else {
            return textError;
          }
        },
        controller: usernameController,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 18, top: 18),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0))),
            labelText: label),
      ),
    );
  }

  bool validation(String s) {
    switch (inputType) {
      case InputType.EMAIL:
        return isEmailValid(s);
      case InputType.REQUEST:
        return isNotBlank(s);
      case InputType.PHONE:
        return isPhoneNumber(s);
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

  bool isPhoneNumber(String s) {
    String pattern = r'^(84|0[3|5|7|8|9])+([0-9]{8})$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(s);
  }
}

enum InputType { EMAIL, REQUEST, NONE, PHONE }
