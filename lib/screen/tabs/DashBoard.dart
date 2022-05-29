import 'package:english_center/components/background/background.dart';
import 'package:english_center/constants.dart';
import 'package:english_center/domain/Member.dart';
import 'package:english_center/domain/StudyProgram.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/screen/tabs/course/DetailCourse.dart';
import 'package:english_center/screen/tabs/studyPrograms/DetailStudyProgram.dart';
import 'package:english_center/services/MemberService.dart';
import 'package:english_center/services/StudyProgram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/home';

  const DashBoardScreen();

  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class Class {
  final String name;
  final String numberOfStudent;
  final String price;
  final String schedule;

  Class(this.name, this.numberOfStudent, this.price, this.schedule);
}

class _DashBoardScreen extends State<DashBoardScreen> {
  final List<String> pathImage = [
    "assets/images/bg2.png",
    "assets/images/bg1.png",
    "assets/images/bg3.png",
    "assets/images/bg4.png",
    "assets/images/bg5.png"
  ];
  final TextEditingController keyword = TextEditingController();

  @override
  void initState() {
    super.initState();
    MemberProvider memberProvider =
        Provider.of<MemberProvider>(context, listen: false);
    if (memberProvider.currentMember.id == null) {
      getCurrentMember().then((value) {
        Member member = Member.fromJson(value.payload);
        memberProvider.set(member);
      });
    }
    gets();
  }

  List<StudyProgram> _studyPrograms = [];

  void gets() {
    getStudyProgram().then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var i = 0; i < list.length; i++) {
          Map<String, dynamic> json = list[i];
          json.putIfAbsent("image", () => pathImage[i % 5]);
          StudyProgram studyProgram = StudyProgram.fromJson(json);
          _studyPrograms.add(studyProgram);
          setState(() {});
        }
      }
    });
  }

  String getName() {
    Member member = Provider.of<MemberProvider>(
      context,
    ).currentMember;
    if (member.name != null) {
      return member.name!;
    }
    return "User";
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        hasButtonBack: false,
        logoMini: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(AppLocalizations.of(context).labelHi + " " + getName(),
                  style: kHeadingextStyle),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: AppLocalizations.of(context).labelFindYourCourse,
                  hintStyle: const TextStyle(fontSize: 20),
                  contentPadding: const EdgeInsets.only(left: 0),
                ),
                onEditingComplete: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  if (keyword.text != "") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCourse(
                          keyword: keyword.text,
                        ),
                      ),
                    );
                  }
                },
                controller: keyword,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppLocalizations.of(context).labelStudy,
                      style: kTitleTextStyle),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  padding: const EdgeInsets.all(0),
                  crossAxisCount: 2,
                  itemCount: _studyPrograms.length,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailStudyProgram(_studyPrograms[index]),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: index.isEven ? 200 : 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(_studyPrograms[index].image ??
                                pathImage[index % 5]),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _studyPrograms[index].name.toString(),
                              style: kTitleTextStyle,
                            ),
                            Text(
                              '${_studyPrograms[index].numberOfCourse} ' +
                                  AppLocalizations.of(context).labelCourse,
                              style: TextStyle(
                                color: kTextColor.withOpacity(.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                ),
              ),
            ],
          ),
        ));
  }
}
