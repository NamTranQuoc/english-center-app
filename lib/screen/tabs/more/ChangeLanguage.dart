import 'package:english_center/components/background/background.dart';
import 'package:english_center/util/LocalStorage.dart';
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

  @override
  void initState() {
    super.initState();
    CommandProvider provider =
        Provider.of<CommandProvider>(context, listen: false);
    if (provider.currentLocale.languageCode == 'vi') {
      language = "Việt Nam";
    } else {
      language = "English";
    }
  }

  onSubmit() {
    CommandProvider provider =
        Provider.of<CommandProvider>(context, listen: false);
    if (language == 'Việt Nam') {
      provider.set(const Locale('vi', ''));
      LocalStorage().setLanguage('vi');
    } else {
      provider.set(const Locale('en', ''));
      LocalStorage().setLanguage('en');
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
                      child: Text(
                        AppLocalizations.of(context).changeLanguage,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Color(0xFF2661FA),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    SelectCustom(language, languages,
                        AppLocalizations.of(context).labelLanguage, (val) {
                      setState(() {
                        language = val;
                      });
                    }),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
