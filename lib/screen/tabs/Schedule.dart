import 'package:english_center/components/button/ButtonCustom.dart';
import 'package:english_center/providers/CommonProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';

  ScheduleScreen();

  @override
  _ScheduleScreen createState() => _ScheduleScreen();
}

class _ScheduleScreen extends State<ScheduleScreen> {
  int selectedIndex = 0;
  TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.helloWorld),
        const SizedBox(
          height: 10,
        ),
        ButtonCustom(Provider.of<CommandProvider>(context).currentLocale.languageCode, Colors.red, () {
          CommandProvider provider = Provider.of<CommandProvider>(context, listen: false);
          if (provider.currentLocale.languageCode == 'vi') {
            provider.set(const Locale('en', ''));
          } else {
            provider.set(const Locale('vi', ''));
          }
        })
      ],
    ));
  }
}
