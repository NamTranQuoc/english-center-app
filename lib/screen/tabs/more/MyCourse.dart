import 'package:english_center/constants.dart';
import 'package:english_center/domain/Classroom.dart';
import 'package:english_center/screen/tabs/classroom/DetailClassRoom.dart';
import 'package:english_center/screen/tabs/more/Document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../services/Register.dart';
import '../../../util/ParseUtil.dart';

class MyCourse extends StatefulWidget {
  static const routeName = '/detail_course';

  MyCourse();

  @override
  _MyCourseScreen createState() => _MyCourseScreen();
}

class _MyCourseScreen extends State<MyCourse> {
  @override
  void initState() {
    super.initState();

    getClassByCourse();
  }

  List<Classroom> _class = [];
  String name = "";

  void getClassByCourse() {
    getRegisterByStudent().then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var element in list) {
          Classroom classStudy = Classroom.fromJson(element);
          _class.add(classStudy);
          setState(() {});
        }
      }
    });
  }

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
                        AppLocalizations.of(context).labelClassList,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(name, style: kHeadingextStyle),
                ],
              ),
            ),
            const SizedBox(height: 40),
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
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: _class.length,
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
                                        text: _class[index].name! + "\n",
                                        style: kSubtitleTextSyule.copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)
                                            .labelDateStart +
                                            ": " +
                                            timestampToDate(
                                                _class[index].startDate!) +
                                            "\n",
                                        style: TextStyle(
                                          color: kTextColor.withOpacity(.8),
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)
                                            .labelSchedule +
                                            ": " +
                                            listToString(_class[index].dow!),
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
                                              Document(_class[index]),
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
