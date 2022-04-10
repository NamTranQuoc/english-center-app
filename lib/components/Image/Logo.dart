
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: const Image(
          image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/englishcenter-2021.appspot.com/o/images%2Flogo.png?alt=media'),
        ));
  }
}
