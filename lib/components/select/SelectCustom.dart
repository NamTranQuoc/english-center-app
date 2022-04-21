
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCustom extends StatefulWidget {
  String item;
  final List<String> list;
  final String label;
  final StringCallback callback;

  SelectCustom(this.item, this.list, this.label, this.callback);

  @override
  State<SelectCustom> createState() => _SelectCustom();
}

class _SelectCustom extends State<SelectCustom> {

  String getDisplay(String g) {
    switch (g) {
      case 'male':
        return AppLocalizations.of(context).male;
      case "female":
        return AppLocalizations.of(context).female;
      case "other":
        return AppLocalizations.of(context).other;
    }
    return "null";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: InputDecorator(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 15),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              labelText: widget.label),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.item,
              isDense: true,
              onChanged: (i) {
                widget.item = i!;
                setState(() {
                  widget.item;
                });
                widget.callback(i);
              },
              items: widget.list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(getDisplay(value)),
                );
              }).toList(),
            ),
          )),
    );
  }
}

typedef void StringCallback(String val);
