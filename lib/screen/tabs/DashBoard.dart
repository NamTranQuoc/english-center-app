import 'package:english_center/domain/Course.dart';
import 'package:english_center/screen/tabs/studyPrograms/DetailStudyProgram.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:english_center/services/StudyProgram.dart';
import 'package:english_center/domain/StudyProgram.dart';
import 'package:english_center/services/Course.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:english_center/constants.dart';
import 'package:english_center/model/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/home';

  const DashBoardScreen();

  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class Class {
  final String name;
  final String numberOfStudent;
  final String price;
  final String schedule;

  Class(this.name, this.numberOfStudent, this.price, this.schedule);
}

class _DashBoardScreen extends State<DashBoardScreen> {

  @override
  void initState() {
    super.initState();

    gets();
  }

  List<StudyProgram> _studyPrograms = [];
  void gets() {
    getStudyProgram().then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var element in list) {
          StudyProgram studyProgram = StudyProgram.fromJson(element);
          _studyPrograms.add(studyProgram);
          setState(() {});
        }
      }
    });
  }

  List<Course> _courses = [];
  void getCourseByStudy(String id) {
    getCourseByStudyProgram(id).then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var element in list) {
          Course course = Course.fromJson(element);
          _courses.add(course);
          setState(() {});
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20,),
            Text( AppLocalizations.of(context).labelHi + " Nam", style: kHeadingextStyle),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(AppLocalizations.of(context).labelFindYourCourse, style: kSubheadingextStyle),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(AppLocalizations.of(context).labelStudy, style: kTitleTextStyle),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: _studyPrograms.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailStudyProgram(_studyPrograms[index]),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: index.isEven ? 200 : 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(categories[index].image),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _studyPrograms[index].name.toString(),
                            style: kTitleTextStyle,
                          ),
                          Text(
                            '${_studyPrograms[index].numberOfCourse} ' + AppLocalizations.of(context).labelCourse,
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
