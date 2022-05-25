
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo();

  @override
  Widget build(BuildContext context) {
    /*return Container(
        height: 100,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Image.asset('images/logo.png', width: 200, height: 200,));*/
    return Image.asset('images/logo.png', width: 200, height: 200,);
  }
}
