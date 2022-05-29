import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/picker/DatePicker.dart';
import 'package:english_center/components/select/SelectCustom.dart';
import 'package:english_center/domain/Member.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/services/MemberService.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/background/background.dart';

class UpdateInformation extends StatefulWidget {
  static const routeName = '/update_information';

  final Member member;

  UpdateInformation(this.member);

  @override
  _UpdateInformation createState() => _UpdateInformation();
}

class _UpdateInformation extends State<UpdateInformation> {
  final formGlobalKey = GlobalKey<FormState>();

  List<String> genders = ['male', 'female', 'other'];

  TextEditingController name = TextEditingController();
  TextEditingController nickName = TextEditingController();
  String gender = "male";
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController note = TextEditingController();
  String email = "";
  String currentScore = "0";
  String inScore = "0";
  var initDOB = DateTime.now();
  String type = "member";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    email = widget.member.email != null ? widget.member.email! : "";
    nickName.text =
        widget.member.nickName != null ? widget.member.nickName! : "";
    name.text = widget.member.name != null ? widget.member.name! : "";
    gender = widget.member.gender != null ? widget.member.gender! : "";
    phone.text =
        widget.member.phoneNumber != null ? widget.member.phoneNumber! : "";
    initDOB = widget.member.dob != null
        ? DateTime.fromMillisecondsSinceEpoch(widget.member.dob!)
        : DateTime.now();
    dob.text = DateFormat("dd-MM-yyyy").format(initDOB);
    note.text = widget.member.note != null ? widget.member.note! : "";
    currentScore =
        widget.member.currentScore != null ? widget.member.currentScore! : "";
    inScore = widget.member.inScore != null ? widget.member.inScore! : "";
    type = widget.member.type != null ? widget.member.type! : "member";
  }

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      updateMember(widget.member.id!, name.text, nickName.text, phone.text,
              gender, stringToTimeStamp(dob.text), type)
          .then((value) {
        if (value.code == 9999) {
          MemberProvider memberProvider =
              Provider.of<MemberProvider>(context, listen: false);
          memberProvider.set(Member.fromJson(value.payload));
          Navigator.of(context).pop("ok");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
            isShowIcon: true,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppLocalizations.of(context).information,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Color(0xFF2661FA),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formGlobalKey,
                      child: Column(
                        children: [
                          InputCustom(
                              AppLocalizations.of(context).name,
                              name,
                              InputType.REQUEST,
                              AppLocalizations.of(context).validateErrorFormat),
                          InputCustom(
                              AppLocalizations.of(context).nickName,
                              nickName,
                              InputType.NONE,
                              AppLocalizations.of(context).validateErrorFormat),
                          InputCustom(
                              AppLocalizations.of(context).phoneNumber,
                              phone,
                              InputType.PHONE,
                              AppLocalizations.of(context).validateErrorFormat),
                          SelectCustom(gender, genders,
                              AppLocalizations.of(context).gender, (val) {
                            setState(() {
                              gender = val;
                            });
                          }),
                          DatePicker(
                              AppLocalizations.of(context).dob, dob, initDOB),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: RaisedButton(
                                onPressed: () {
                                  onSubmit();
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
                                    AppLocalizations.of(context).update,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
