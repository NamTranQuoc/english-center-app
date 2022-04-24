import 'package:english_center/components/Image/Logo.dart';
import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/components/input/InputCustom.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:english_center/components/picker/DatePicker.dart';
import 'package:english_center/components/select/SelectCustom.dart';
import 'package:english_center/components/upload/AvatarCustom.dart';
import 'package:english_center/domain/Member.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/screen/Login.dart';
import 'package:english_center/screen/tabs/More.dart';
import 'package:english_center/services/AuthService.dart';
import 'package:english_center/services/MemberService.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    nickName.text = widget.member.nickName != null ? widget.member.nickName! : "";
    name.text = widget.member.name != null ? widget.member.name! : "";
    gender = widget.member.gender != null ? widget.member.gender! : "";
    phone.text = widget.member.phoneNumber != null ? widget.member.phoneNumber! : "";
    initDOB = widget.member.dob != null ? DateTime.fromMillisecondsSinceEpoch(widget.member.dob!) : DateTime.now();
    dob.text = DateFormat("dd-MM-yyyy").format(initDOB);
    note.text = widget.member.note != null ? widget.member.note! : "";
    currentScore = widget.member.currentScore != null ? widget.member.currentScore! : "";
    inScore = widget.member.inScore != null ? widget.member.inScore! : "";
    type = widget.member.type != null ? widget.member.type! : "member";
  }

  onSubmit() {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      updateMember(widget.member.id!, name.text, nickName.text, phone.text, gender, stringToTimeStamp(dob.text), type).then((value) {
        if (value.code == 9999) {
          MemberProvider memberProvider = Provider.of<MemberProvider>(context, listen: false);
          memberProvider.set(Member.fromJson(value.payload));
          Navigator.of(context).pop("ok");
        }
      });
    }
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
                AvatarCustom(),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  alignment: Alignment.center,
                  child: Consumer<MemberProvider>(
                    builder: (context, provider, child) {
                      return Text(provider.currentMember.email ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold));
                    },
                  ),
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
                      InputCustom(AppLocalizations.of(context).phoneNumber, phone, InputType.PHONE,
                          AppLocalizations.of(context).validateErrorFormat),
                      SelectCustom(gender, genders, AppLocalizations.of(context).gender, (val) {setState(() {
                        gender = val;
                      });}),
                      DatePicker(AppLocalizations.of(context).dob, dob, initDOB),
                    ],
                  ),
                ),
                ButtonCustom(AppLocalizations.of(context).update,
                    Colors.lightBlueAccent, onSubmit),
              ],
            )));
  }
}
