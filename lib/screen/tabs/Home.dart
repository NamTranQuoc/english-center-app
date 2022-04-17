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

class _HomeScreen extends State<HomeScreen> {
  UploadTask? task;
  File? file;
  final List _studyProgram =["Toeic", "Ielts", "Giao Tiep", "Toeic", "Ielts", "Giao Tiep"];
  final List _class =["Toeic", "Ielts", "Giao Tiep", "Toeic", "Ielts", "Giao Tiep"];

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


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file!.path : 'No File Selected';
    return Scaffold(
      body:
      Column(
        children: [
          Container(
            child: Text(
              AppLocalizations.of(context).labelStudy,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
                itemCount: _studyProgram.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return CircleItem(
                    child: _studyProgram[index],
                  );
                }
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _studyProgram.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  return CardItem(
                    child: _studyProgram[index],
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
