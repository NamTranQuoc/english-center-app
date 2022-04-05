import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:week3/components/button/ButtonCustom.dart';
import 'dart:io';

import 'package:week3/util/firebase_api.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  HomeScreen();

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  UploadTask? task;
  File? file;

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
      body: Container(
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
      ),
    );
  }
}
