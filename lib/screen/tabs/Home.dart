import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/cardItem/Carditem.dart';
import 'package:english_center/domain/Course.dart';
import 'package:english_center/util/FirebaseApi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:english_center/components/circleItem/CircleItem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:english_center/services/StudyProgram.dart';
import 'package:english_center/domain/StudyProgram.dart';
import 'package:english_center/services/Course.dart';
import 'package:english_center/domain/Course.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  HomeScreen();

  @override
  _HomeScreen createState() => _HomeScreen();
}

/*class Course {
  final String courseName;
  final String courseId;
  Course( this.courseName, this.courseId);
}*/

class Class {
  final String name;
  final String numberOfStudent;
  final String price;
  final String schedule;

  Class(this.name, this.numberOfStudent, this.price, this.schedule);
}

class _HomeScreen extends State<HomeScreen> {

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

  UploadTask? task;
  File? file;
  final List<Class> _class = [
    Class("Toeic 500", "15", "3000000", "T2 T3 T4"),
    Class("Ielts 7.0", "10", "9000000", "T2 T4 T6"),
    Class("Ielts 8.5", "10", "12000000", "T3 T5 T7"),
    Class("Toeic 700", "20", "6000000", "T6 T7 CN"),
    Class("Trẻ em 1", "15", "3000000", "T5 T6 T7"),
    Class("Cơ bản 1", "25", "4000000", "T3 T4 T6"),
    Class("Cơ bản 2", "25", "5000000", "T2 T5 T7"),
    Class("Giao tiếp 1", "15", "6000000", "T2 T3 T4"),
  ];

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    const fileName = 'test.png';
    const destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }
  bool isClick = false;
  String categorySelect = "";
  String previousSelect = "empty";

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

  Widget scrollList(String id){
    if(categorySelect != "" && categorySelect != previousSelect)
      {
        getCourseByStudy(id);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          height: 50,
          child: ListView.builder(
            itemCount: _courses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return CardItem(
                  _courses[index].name!,
                  _courses[index].id!,
                      (categoryName){
                    setState(() {
                      previousSelect = categorySelect;
                      categorySelect = categoryName;
                    });
                  }

              );
            },
          ),
        );
      }
    else
      {
        previousSelect = "empty";
        categorySelect = "";
      }
    return Container();
  }


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file!.path : 'No File Selected';
    return Scaffold(
      body:
      Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).labelStudy,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            height: 50,
            child: ListView.builder(
              itemCount: _studyPrograms.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return CardItem(
                    _studyPrograms[index].name!,
                    _studyPrograms[index].id!,
                        (categoryId){
                      setState(() {
                        previousSelect = categorySelect;
                        categorySelect = categoryId;
                      });
                    }
                );
              },
            ),
          ),
          scrollList(categorySelect),
          Expanded(
            child: ListView.builder(
                itemCount: _class.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  return CircleItem(
                    _class[index].name,
                    _class[index].numberOfStudent,
                    _class[index].price,
                    _class[index].schedule
                  );
                }
            ),
          ),
        ],
      ),
      /*Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom("select", Colors.red, selectFile),
              Text(
                fileName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 48),
              ButtonCustom("upload", Colors.blueGrey, uploadFile),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),*/
    );
  }
}
