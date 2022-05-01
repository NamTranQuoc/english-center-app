import 'dart:ui';

import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/button/ButtonText.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:english_center/components/select/SelectCustom.dart';
import 'package:english_center/components/select/SelectCustomV2.dart';
import 'package:english_center/domain/ClassroomAbsent.dart';
import 'package:english_center/domain/Schedule.dart';
import 'package:english_center/services/ScheduleService.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../services/AbsentService.dart';

class DetailSchedule extends StatefulWidget {
  static const routeName = '/detail_schedule';

  final Schedule schedule;

  DetailSchedule(this.schedule);

  @override
  _DetailSchedule createState() => _DetailSchedule();
}

class _DetailSchedule extends State<DetailSchedule> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController className = TextEditingController();
  TextEditingController session = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController room = TextEditingController();
  TextEditingController teacher = TextEditingController();

  bool f = false;
  Map<String, String> classroomAbsents = {};
  String absentId = "1";

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    className.text = widget.schedule.title!;
    session.text = widget.schedule.session!.toString();
    startTime.text = timestampToString(widget.schedule.start!);
    endTime.text = timestampToString(widget.schedule.end!);
    room.text = widget.schedule.room!;
    teacher.text = widget.schedule.teacher!;
  }

  Widget viewAbsent() {
    classroomAbsents = {};
    absentId = '1';
    if (!widget.schedule.tookPlace!) {
      if (!f) {
        return ButtonText(
            AppLocalizations.of(context).registerAbsent, const TextStyle(), () {
          getClassroomAbsent(widget.schedule.id!).then((value) {
            List<Map<String, dynamic>> list = List.from(value.payload);
            list.forEach((element) {
              ClassroomAbsent classroomAbsent =
                  ClassroomAbsent.fromJson(element);
              if (absentId == '1') {
                absentId = classroomAbsent.id!;
              }
              classroomAbsents.putIfAbsent(classroomAbsent.id!,
                  () => classroomAbsent.name!);
            });
            setState(() {
              f = true;
            });
          });
        });
      } else {
        return Column(
          children: [
            SelectCustomV2(
                absentId, classroomAbsents, AppLocalizations.of(context).gender,
                (val) {
              setState(() {
                absentId = val;
              });
            }),
            ButtonCustom(AppLocalizations.of(context).registerAbsent,
                Colors.blue, onSubmit),
          ],
        );
      }
    }
    return Container();
  }

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
                  key: formGlobalKey,
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
                                Text(
                                    '${AppLocalizations.of(context).className}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(className.text,
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
                                    '${AppLocalizations.of(context).session}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(session.text,
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
                                Text(startTime.text,
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
                                    '${AppLocalizations.of(context).endTime}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(endTime.text,
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
                                Text('${AppLocalizations.of(context).room}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(room.text,
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
                                    '${AppLocalizations.of(context).teacher}: ',
                                    style: const TextStyle(fontSize: 18)),
                                Text(teacher.text,
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
                viewAbsent(),
              ],
            )));
  }
}
