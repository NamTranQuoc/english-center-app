import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:english_center/constants.dart';

class DetailsClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F4EF),
          image: DecorationImage(
            image: AssetImage("assets/images/ux_big.png"),
            alignment: Alignment.topRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                  const SizedBox(height: 30),
                  const Text("Toeic 500+", style: kHeadingextStyle),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset("assets/icons/person.svg"),
                      const SizedBox(width: 5),
                      const Text("2k"),
                      const SizedBox(width: 20),
                      SvgPicture.asset("assets/icons/star.svg"),
                      const SizedBox(width: 5),
                      const Text("4.5")
                    ],
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "5.000.000 vnđ \n",
                          style: kHeadingextStyle.copyWith(fontSize: 25),
                        ),
                        TextSpan(
                          text: "7.000.000 vnđ",
                          style: TextStyle(
                            color: kTextColor.withOpacity(.5),
                            fontSize: 20,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text("Class information", style: kTitleTextStyle),
                          SizedBox(height: 10),
                          CourseContent(
                            number: "01",
                            type: "Schedule",
                            title: "T2 T4 T6 (8h - 10h)",
                            isDone: true,
                          ),
                          CourseContent(
                            number: '02',
                            type: "Number of student",
                            title: "20 students",
                            isDone: true,
                          ),
                          CourseContent(
                            number: '03',
                            type: "Number of lession",
                            title: "50 lession",
                          ),
                          CourseContent(
                            number: '03',
                            type: "Date start",
                            title: "15/05/2022",
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 50,
                              color: kTextColor.withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(14),
                              height: 56,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEDEE),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: SvgPicture.asset(
                                  "assets/icons/shopping-bag.svg"),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: kBlueColor,
                                ),
                                child: Text(
                                  "Register",
                                  style: kSubtitleTextSyule.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseContent extends StatelessWidget {
  final String number;
  final String type;
  final String title;
  final bool isDone;
  const CourseContent({
    required this.number,
    required this.type,
    required this.title,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$type\n",
                  style: TextStyle(
                    color: kTextColor.withOpacity(.5),
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: kSubtitleTextSyule.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
