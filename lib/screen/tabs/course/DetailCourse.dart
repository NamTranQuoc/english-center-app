import 'package:english_center/constants.dart';
import 'package:english_center/domain/Classroom.dart';
import 'package:english_center/domain/Course.dart';
import 'package:english_center/screen/tabs/classroom/DetailClassRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/ClassStudy.dart';
import '../../../util/ParseUtil.dart';

class DetailCourse extends StatefulWidget {
  static const routeName = '/detail_course';

  final Course course;

  DetailCourse(this.course);

  @override
  _DetailCourseScreen createState() => _DetailCourseScreen();
}

class _DetailCourseScreen extends State<DetailCourse> {

  @override
  void initState() {
    super.initState();

    getClassByCourse(widget.course.id!);
  }

  List<Classroom> _class = [];
  void getClassByCourse(String id) {
    getClassRoomByCourse(id).then((value) {
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
                    children: <Widget>[
                      SvgPicture.asset("assets/icons/arrow-left.svg"),
                      SvgPicture.asset("assets/icons/more-vertical.svg"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ClipPath(
                    clipper: BestSellerClipper(),
                    child: Container(
                      color: kBestSellerColor,
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 5),
                      child: const Text(
                        "Thông tin khóa học",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(widget.course.name!, style: kHeadingextStyle),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset("assets/icons/person.svg"),
                      const SizedBox(width: 5),
                      const Text("18K"),
                      const SizedBox(width: 20),
                      SvgPicture.asset("assets/icons/star.svg"),
                      const SizedBox(width: 5),
                      const Text("4.8")
                    ],
                  ),
                  const SizedBox(height: 20),
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
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 5),
                      child: const Text("Danh sách lớp học", style: kTitleTextStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: ListView.builder(
                        itemCount: _class.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index){
                          /*return CardItem(
                              courses[index].name!,
                              courses[index].name!,
                                  (categoryId){
                                setState(() {});
                              }
                          );*/
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  (index + 1).toString(),
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
                                        text: _class[index].name! + "\n",
                                        style: kSubtitleTextSyule.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Ngày khai giảng: " + timestampToDate(_class[index].startDate!) + "\n",
                                        style: TextStyle(
                                          color: kTextColor.withOpacity(.5),
                                          fontSize: 18,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Lịch học: " + listToString(_class[index].dow!),
                                        style: TextStyle(
                                          color: kTextColor.withOpacity(.5),
                                          fontSize: 18,
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
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailClassRoom(_class[index]),
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
