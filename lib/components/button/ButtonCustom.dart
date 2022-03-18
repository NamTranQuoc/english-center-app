import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  ButtonCustom(this.label, this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            child: Text(label),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              primary: color,
            )));
  }
}
