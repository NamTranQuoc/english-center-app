import 'dart:ui';

import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/message/Notification.dart';
import 'package:english_center/domain/RegisExamScreen.dart';
import 'package:english_center/services/RegisExam.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';

class DetailRegisExam extends StatefulWidget {
  static const routeName = '/detail_class';

  final RegisExam regisExam;

  DetailRegisExam(this.regisExam);

  @override
  _DetailRegisExam createState() => _DetailRegisExam();
}

class _DetailRegisExam extends State<DetailRegisExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: ListView(
              children: <Widget>[
                Form(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Tên: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(widget.regisExam.code ?? "",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            ),
                            Row(
                              children: [
                                Text('Thời gian bắt đầu: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    timestampToString(
                                        widget.regisExam.startTime!),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            ),
                            Row(
                              children: [
                                Text('Thời gian kết thúc: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    timestampToString(
                                        widget.regisExam.endTime!),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            ),
                            Row(
                              children: [
                                Text('Số lượng tối thiểu: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(widget.regisExam.minQuantity.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            ),
                            Row(
                              children: [
                                Text('Số lượng tối đa: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(widget.regisExam.maxQuantity.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                ),
                ButtonCustom("Ghi danh", Colors.lightBlue, () {
                  registerExam(widget.regisExam.id!).then((value) {
                    if (value.code == 9999) {
                      showSuccess("Ghi danh thành công");
                    }
                  });
                })
              ],
            )));
  }
}
