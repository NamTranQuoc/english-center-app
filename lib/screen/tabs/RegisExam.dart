import 'package:english_center/constants.dart';
import 'package:english_center/domain/RegisExamScreen.dart';
import 'package:english_center/screen/tabs/regisExam/DetailRegisExam.dart';
import 'package:english_center/services/RegisExam.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisExamScreen extends StatefulWidget {
  static const routeName = '/detail_studyProgram';

  RegisExamScreen();

  @override
  _RegisExamScreen createState() => _RegisExamScreen();
}

class _RegisExamScreen extends State<RegisExamScreen> {
  @override
  void initState() {
    super.initState();

    gets();
  }

  void gets() {
    getRegister().then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var element in list) {
          RegisExam regisExam = RegisExam.fromJson(element);
          exam.add(regisExam);
          setState(() {});
        }
      }
    });
  }

  List<RegisExam> exam = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.chevron_left, color: Colors.black54),
        backgroundColor: Colors.white,
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
              padding: const EdgeInsets.only(left: 20, top: 80, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[],
                  ),
                  ClipPath(
                    clipper: BestSellerClipper(),
                    child: Container(
                      color: kBestSellerColor,
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 5),
                      child: Text(
                        AppLocalizations.of(context).labelExamList,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Toeic", style: kHeadingextStyle),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: exam.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  (index + 1).toString(),
                                  style: kHeadingextStyle.copyWith(
                                    color: kTextColor.withOpacity(.45),
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            exam[index].code.toString() + "\n",
                                        style: kSubtitleTextSyule.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)
                                                .labelStart +
                                            timestampToString(
                                                exam[index].startTime!) +
                                            "\n",
                                        style: TextStyle(
                                          color: kTextColor.withOpacity(.8),
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)
                                                .labelEnd +
                                            timestampToString(
                                                exam[index].endTime!),
                                        style: TextStyle(
                                          color: kTextColor.withOpacity(.8),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kGreenColor.withOpacity(1),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRegisExam(exam[index]),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
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
  final double duration;
  final String title;
  final bool isDone;

  CourseContent({
    required this.number,
    required this.duration,
    required this.title,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number,
            style: kHeadingextStyle.copyWith(
              color: kTextColor.withOpacity(.15),
              fontSize: 32,
            ),
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$duration mins\n",
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
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(left: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGreenColor.withOpacity(isDone ? 1 : .5),
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white),
          )
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
