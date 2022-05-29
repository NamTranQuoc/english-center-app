import 'package:flutter/material.dart';

import '../Image/Logo.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool isShowIcon;
  final bool hasButtonBack;
  final bool logoMini;

  const Background({
    Key? key,
    required this.child,
    this.isShowIcon = true,
    this.hasButtonBack = true,
    this.logoMini = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        floatingActionButton: hasButtonBack
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left, color: Colors.black54),
                backgroundColor: Colors.white,
                mini: true,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SizedBox(
          width: double.infinity,
          height: size.height + MediaQuery.of(context).viewInsets.bottom,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/images/top1.png", width: size.width),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/images/top2.png", width: size.width),
              ),
              if (isShowIcon)
                Align(
                  alignment: Alignment.topRight,
                  child: Logo(logoMini),
                ),
              child
            ],
          ),
        ));
  }
}
