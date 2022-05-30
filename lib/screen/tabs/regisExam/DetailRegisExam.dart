import 'dart:ui';

import 'package:english_center/components/background/background.dart';
import 'package:english_center/components/message/Notification.dart';
import 'package:english_center/domain/RegisExamScreen.dart';
import 'package:english_center/services/RegisExam.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${AppLocalizations.of(context).examName}: ',
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
                                Text(
                                    '${AppLocalizations.of(context).labelStart} ',
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
                                Text(
                                    '${AppLocalizations.of(context).labelEnd} ',
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
                                Text(
                                    '${AppLocalizations.of(context).labelNumberOfStudent}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    widget.regisExam.minQuantity.toString() +
                                        " -> " +
                                        widget.regisExam.maxQuantity.toString(),
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
                      registerExam(widget.regisExam.id!).then((value) {
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
