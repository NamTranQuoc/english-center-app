import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/cardItem/Carditem.dart';
import 'package:english_center/util/FirebaseApi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:english_center/components/circleItem/CircleItem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  HomeScreen();

  @override
  _HomeScreen createState() => _HomeScreen();
}

class StudyProgram {
  final String categoryName;
  final String categoryId;
  final String categoryUrlImage;
  const StudyProgram({required this.categoryName, required this.categoryId, required this.categoryUrlImage});
}

class Class {
  final String name;
  final String numberOfStudent;
  final String price;
  final String schedule;

  Class(this.name, this.numberOfStudent, this.price, this.schedule);
}

class _HomeScreen extends State<HomeScreen> {
  UploadTask? task;
  File? file;
  final List<StudyProgram> _studyProgram = [
    StudyProgram(categoryName: "Toeic", categoryId: "Toeic", categoryUrlImage: "abc"),
    StudyProgram(categoryName: "Ielts", categoryId: "Ielts", categoryUrlImage: "abc"),
    StudyProgram(categoryName: "Giao tiếp", categoryId: "Giao tiếp", categoryUrlImage: "abc"),
    StudyProgram(categoryName: "Trẻ em", categoryId: "Trẻ em", categoryUrlImage: "abc"),
    StudyProgram(categoryName: "Cơ bản", categoryId: "Cơ bản", categoryUrlImage: "abc"),
    StudyProgram(categoryName: "Nâng cao", categoryId: "Nâng cao", categoryUrlImage: "abc"),
  ];
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

  Widget scrollList(){
    if(categorySelect != "" && categorySelect != previousSelect)
      {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          height: 50,
          child: ListView.builder(
            itemCount: _studyProgram.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return CardItem(
                  _studyProgram[index].categoryName,
                  _studyProgram[index].categoryId,
                  _studyProgram[index].categoryUrlImage,
                  (categoryName){
                    print(categoryName);
                  }
              );
            },
          ),
        );
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
              itemCount: _studyProgram.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return CardItem(
                    _studyProgram[index].categoryName,
                    _studyProgram[index].categoryId,
                    _studyProgram[index].categoryUrlImage,
                        (categoryName){
                      setState(() {
                        previousSelect = categorySelect;
                        categorySelect = categoryName;
                      });
                    }
                );
              },
            ),
          ),
          scrollList(),
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
