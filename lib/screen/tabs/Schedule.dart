import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:week3/translate/cubits/languages_cubit.dart';
import 'package:flutter/cupertino.dart';

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
        BlocBuilder<LanguagesCubit, Locale?>(builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () =>
                      context.read<LanguagesCubit>().change(Locale('vi', '')),
                  child: Text("Tieng Viet")),
              GestureDetector(
                  onTap: () =>
                      context.read<LanguagesCubit>().change(Locale('en', '')),
                  child: Text("English")),
            ],
          );
        }),
      ],
    ));
  }
}
