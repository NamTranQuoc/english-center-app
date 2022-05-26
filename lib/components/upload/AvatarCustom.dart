import 'dart:io';

import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/util/FirebaseApi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarCustom extends StatefulWidget {
  AvatarCustom();

  @override
  State<AvatarCustom> createState() => _AvatarCustom();
}

class _AvatarCustom extends State<AvatarCustom> {
  String path = 'avatar.png';
  String url = '';
  UploadTask? task;
  File? file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile(String avatar) async {
    if (file == null) return;

    final destination = 'images/$avatar';

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
    return Center(
        child: InkWell(
          child: Container(
            width: 170,
            height: 170,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Consumer<MemberProvider>(
                builder: (context, provider, child) {
                  return Consumer<MemberProvider>(
                    builder: (context, provider, child) {
                      return Image(image: NetworkImage(url == '' ? FirebaseApi.getUrl("images", provider.currentMember.avatar ?? path) : url));
                    },
                  );
                },
              )
            ),
          ),
          onTap: () async {
            await selectFile();
            MemberProvider memberProvider = Provider.of<MemberProvider>(context, listen: false);
            uploadFile(memberProvider.currentMember.avatar!);
            },
        ));
  }
}
