import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool logoMini;

  Logo(this.logoMini);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/logo.png',
      width: logoMini ? 150 : 200,
      height: logoMini ? 150 : 200,
    );
  }
}
