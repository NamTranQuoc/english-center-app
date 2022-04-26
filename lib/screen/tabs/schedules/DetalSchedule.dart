import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:english_center/domain/Schedule.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: ListView(
              children: <Widget>[
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputCustom(AppLocalizations.of(context).className, className, InputType.NONE, "", disable: true),
                      InputCustom(AppLocalizations.of(context).session, session, InputType.NONE, "", disable: true),
                      InputCustom(AppLocalizations.of(context).startTime, startTime, InputType.NONE, "", disable: true),
                      InputCustom(AppLocalizations.of(context).endTime, endTime, InputType.NONE, "", disable: true),
                      InputCustom(AppLocalizations.of(context).room, room, InputType.NONE, "", disable: true),
                      InputCustom(AppLocalizations.of(context).teacher, teacher, InputType.NONE, "", disable: true),
                    ],
                  ),
                ),
                ButtonCustom(AppLocalizations.of(context).labelLogin,
                    Colors.lightBlueAccent, onSubmit),
              ],
            )));
  }
}
