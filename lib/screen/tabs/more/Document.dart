import 'dart:isolate';
import 'dart:ui';

import 'package:english_center/constants.dart';
import 'package:english_center/domain/Classroom.dart';
import 'package:english_center/domain/Document.dart';
import 'package:flutter/material.dart';
import '../../../services/Document.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class Document extends StatefulWidget {
  static const routeName = '/detail_course';

  final Classroom classroom;

  Document(this.classroom);

  @override
  _DocumentScreen createState() => _DocumentScreen();
}

class _DocumentScreen extends State<Document> {
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if(status == DownloadTaskStatus.complete) {
        print("======================================================");
      }

      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();

    getDocument();
  }

  List<DocumentDomain> _document = [];
  String name = "";

  void getDocument() {
    getDocumentByStudent(widget.classroom.courseId!).then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var element in list) {
          DocumentDomain document = DocumentDomain.fromJson(element);
          _document.add(document);
          setState(() {});
        }
      }
    });
  }

  Future downloadFile(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: "https://firebasestorage.googleapis.com/v0/b/englishcenter-2021.appspot.com/o/documents%2F"+ url +"?alt=media",
        savedDir: "/storage/emulated/0/Download/",
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );
    }
  }

  ReceivePort _port = ReceivePort();

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
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
                      child: const Text("Tài Liệu",
                        style: TextStyle(
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
                      padding: const EdgeInsets.all(30),
                      child: ListView.builder(
                        itemCount: _document.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                        text: _document[index].name! + "\n",
                                        style: kSubtitleTextSyule.copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Type" +
                                            ": " + _document[index].type! +
                                            "\n",
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
                                  margin: const EdgeInsets.only(right: 20),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kGreenColor.withOpacity(1),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: ()  {
                                      downloadFile(_document[index].path!);
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
    path.lineTo(size.width, size.height);
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
