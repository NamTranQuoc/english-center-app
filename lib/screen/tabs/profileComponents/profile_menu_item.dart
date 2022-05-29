import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconSrc;
  final String title;
  final VoidCallback press;

  ProfileMenuItem(
    this.iconSrc,
    this.title,
    this.press,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10 * 2, vertical: 10 * 3),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              SvgPicture.asset(iconSrc),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18, //16
                  color: Color(0xFF2661FA),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[700],
              )
            ],
          ),
        ),
      ),
    );
  }
}
