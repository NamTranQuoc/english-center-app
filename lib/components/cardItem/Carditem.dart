import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  late final String child;
  CardItem({required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
        ),
        child: Center(
            child: Text(child, style: const TextStyle(fontSize: 15),)
        ),
      ),
    );
  }
}