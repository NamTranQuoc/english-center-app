import 'package:flutter/material.dart';

class CircleItem extends StatelessWidget {
  late final String child;
  CircleItem({required this.child});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.pink,
          ),
          child: Center(
              child: Text(child, style: const TextStyle(fontSize: 15),)
          ),
        ),
    );
  }
}