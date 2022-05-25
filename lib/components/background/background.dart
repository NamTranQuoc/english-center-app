import 'package:flutter/material.dart';

import '../Image/Logo.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool isShowIcon;

  const Background({
    Key? key,
    required this.child,
    this.isShowIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height + MediaQuery.of(context).viewInsets.bottom,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top1.png",
                width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top2.png",
                width: size.width
            ),
          ),
          if (isShowIcon)
            Align(
            alignment: Alignment.topRight,
            child: Logo(),
          ),
          /*Positioned(
            top: 50,
            right: 30,
            child: Logo()
          ),*/
          /*Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom1.png",
                width: size.width
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom2.png",
                width: size.width
            ),
          ),*/
          child
        ],
      ),
    );
  }
}