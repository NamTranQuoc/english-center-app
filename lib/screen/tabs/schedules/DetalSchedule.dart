import 'dart:ui';

import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/button/ButtonText.dart';
import 'package:english_center/components/message/Notification.dart';
import 'package:english_center/components/select/SelectCustomV2.dart';
import 'package:english_center/domain/ClassroomAbsent.dart';
import 'package:english_center/domain/Schedule.dart';
import 'package:english_center/providers/ScheduleProvider.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../services/AbsentService.dart';

class DetailSchedule extends StatefulWidget {
  static const routeName = '/detail_schedule';
  
  final String date;
  final int index;

  DetailSchedule(this.date, this.index);

  @override
  _DetailSchedule createState() => _DetailSchedule();
}

class _DetailSchedule extends State<DetailSchedule> {
  final formGlobalKey = GlobalKey<FormState>();

  bool f = false;
  Map<String, String> classroomAbsents = {};
  String absentId = "";
  late Schedule schedule;

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      if (absentId == "") {
        showError("param_not_null");
      } else {
        registerAbsent(schedule.id!, absentId).then((value) {
          if (value.code == 9999) {
            ScheduleProvider scheduleProvider = Provider.of<ScheduleProvider>(context, listen: false);
            List<Schedule> list = scheduleProvider.schedules[widget.date] ?? [];
            list.removeAt(widget.index);
            scheduleProvider.putIfAbsent(widget.date, list);

            Schedule r = Schedule.fromJson(value.payload);
            DateTime d = DateTime.fromMillisecondsSinceEpoch(r.start!);
            String key = getKey(d);
            List<Schedule> list1 = scheduleProvider.schedules[key] ?? [];
            list1.add(r);
            scheduleProvider.putIfAbsent(key, list1);

            Navigator.of(context).pop("ok");
          }
        });
      }
    }
  }

  String getKey(DateTime day) {
    return '${day.year}-${day.month}-${day.day}';
  }

  @override
  void initState() {
    // TODO: implement initState
    List<Schedule> list = Provider.of<ScheduleProvider>(context, listen: false).schedules[widget.date] ?? [];
    schedule = list[widget.index];
  }

  Widget viewAbsent() {
    if (!schedule.tookPlace!) {
      if (!f) {
        classroomAbsents = {};
        absentId = "";
        return ButtonText(
            AppLocalizations.of(context).registerAbsent, const TextStyle(), () {
          getClassroomAbsent(schedule.id!).then((value) {
            List<Map<String, dynamic>> list = List.from(value.payload);
            for (var element in list) {
              ClassroomAbsent classroomAbsent = ClassroomAbsent.fromJson(element);
              if (absentId == "") {
                absentId = classroomAbsent.id!;
              }
              classroomAbsents.putIfAbsent(
                  classroomAbsent.id!, () => classroomAbsent.name!);
            }
            setState(() {
              f = true;
            });
          });
        });
      } else {
        return Column(
          children: [
            SelectCustomV2(absentId, classroomAbsents,
                AppLocalizations.of(context).className, (val) {
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
                                Text(schedule.title ?? "",
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
                                Text(schedule.session!.toString(),
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
                                Text(timestampToString(schedule.start!),
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
                                Text(timestampToString(schedule.end!),
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
                                Text(schedule.room ?? "",
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
                                Text(schedule.teacher ?? "",
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