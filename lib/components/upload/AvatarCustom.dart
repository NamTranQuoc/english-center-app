import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:week3/domain/Member.dart';
import 'package:week3/services/UserService.dart';
import 'package:week3/util/Enums.dart';
import 'package:week3/util/firebase_api.dart';

class AvatarCustom extends StatefulWidget {
  AvatarCustom();

  @override
  State<AvatarCustom> createState() => _AvatarCustom();
}

class _AvatarCustom extends State<AvatarCustom> {
  String path = '';
  String url = Common.avatarDefault;
  UploadTask? task;
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentMember().then((value) {
      Member member = Member.fromJson(value.payload);
      setState(() {
        path = member.avatar!;
        url = FirebaseApi.getUrl("images", member.avatar!);
      });
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final destination = 'images/$path';
    print(destination);

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      url = urlDownload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(left: 100, right: 100, bottom: 18, top: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image(
              image: NetworkImage(url)),
        ),
      ),
      onTap: () async {
        await selectFile();
        uploadFile();
      },
    );
  }
}
