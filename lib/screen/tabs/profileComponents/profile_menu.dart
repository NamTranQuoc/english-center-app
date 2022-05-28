import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
    this.color
  }) : super(key: key);

  final String text, icon;
  final Color? color;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xFF2661FA),
          padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey[200],
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.black54,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(fontSize: 17, color: color ?? Color(0xFF2661FA)),)),
            const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black54,),
          ],
        ),
      ),
    );
  }
}