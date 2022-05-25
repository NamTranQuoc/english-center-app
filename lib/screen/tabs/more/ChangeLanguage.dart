import 'package:english_center/components/background/background.dart';
import 'package:english_center/components/input/InputPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../components/select/SelectCustom.dart';
import '../../../providers/CommonProvider.dart';

class ChangeLanguage extends StatefulWidget {
  static const routeName = '/change_language';

  ChangeLanguage();

  @override
  _ChangeLanguage createState() => _ChangeLanguage();
}

class _ChangeLanguage extends State<ChangeLanguage> {
  final formGlobalKey = GlobalKey<FormState>();

  List<String> languages = ['Việt Nam', 'English'];
  String language = "Việt Nam";

  /*@override
  void initState() {
    super.initState();
    CommandProvider provider = Provider.of<CommandProvider>(context, listen: false);
    language =  != null ? widget.member.gender! : "";
  }*/

  onSubmit() {
    CommandProvider provider = Provider.of<CommandProvider>(context, listen: false);
    if (language == 'Việt Nam') {
      provider.set(const Locale('vi', ''));
    } else {
      provider.set(const Locale('en', ''));
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
                  Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                            "Đổi ngôn ngữ",
                            style: TextStyle(
                              fontSize: 32,
                              color: Color(0xFF2661FA),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        SelectCustom(language, languages, "Ngôn ngữ", (val) {setState(() {
                          language = val;
                        });}),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(  padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [Expanded(child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Color(0xFF2661FA),),

                        onPressed: () {
                          onSubmit();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,

                          padding: const EdgeInsets.all(0),
                          child: Text(
                            AppLocalizations.of(context).update,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),)],
                    ),
                  ),
                ],
              )),
        )
    );
  }
}
