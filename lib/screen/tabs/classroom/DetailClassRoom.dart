import 'dart:ui';

import 'package:english_center/components/background/background.dart';
import 'package:english_center/components/message/Notification.dart';
import 'package:english_center/domain/Classroom.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../services/Register.dart';

class DetailClassRoom extends StatefulWidget {
  static const routeName = '/detail_class';

  final Classroom classroom;

  DetailClassRoom(this.classroom);

  @override
  _DetailClassRoom createState() => _DetailClassRoom();
}

class _DetailClassRoom extends State<DetailClassRoom> {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    AppLocalizations.of(context).detailSchedule,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xFF2661FA),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${AppLocalizations.of(context).className}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(widget.classroom.name ?? "",
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
                                Text(
                                    '${AppLocalizations.of(context).labelNumberOfStudent}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    widget.classroom.minStudent!.toString() +
                                        " -> " +
                                        widget.classroom.maxStudent.toString(),
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
                                Text(
                                    '${AppLocalizations.of(context).startTime}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    timestampToDate(
                                        widget.classroom.startDate!),
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
                                Text(
                                    '${AppLocalizations.of(context).labelSchedule}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(listToString(widget.classroom.dow!),
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
                Container(
                  alignment: Alignment.center,
                  // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: RaisedButton(
                    onPressed: () {
                      registerClassroom(widget.classroom.id!).then((value) {
                        if (value.code == 9999) {
                          showSuccess("register_success");
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color(0xFF2661FA),
                            Color(0xFF6685E3),
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        AppLocalizations.of(context).register,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
