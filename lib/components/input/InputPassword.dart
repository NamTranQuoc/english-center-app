
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  InputPassword(this.label, this.password);

  final String label;
  final TextEditingController password;

  @override
  State<StatefulWidget> createState() => _InputPassword();

}

class _InputPassword extends State<InputPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        controller: widget.password,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
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
    );
  }

  bool isPasswordValid(String password) => password.length > 6;
}
