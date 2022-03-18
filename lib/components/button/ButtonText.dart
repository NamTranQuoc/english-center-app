
import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle style;

  ButtonText(this.label, this.style, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: onPressed,
          child: Text(label, style: style),
        ));
  }
}
