import 'package:flutter/material.dart';

class SelectCustomV2 extends StatefulWidget {
  String item;
  final Map<String, String> list;
  final String label;
  final StringCallback callback;

  SelectCustomV2(this.item, this.list, this.label, this.callback);

  @override
  State<SelectCustomV2> createState() => _SelectCustomV2();
}

class _SelectCustomV2 extends State<SelectCustomV2> {
  List<DropdownMenuItem<String>> getDisplay() {
    List<DropdownMenuItem<String>> list = [];
    widget.list.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(value),
      ));
    });
    return list;
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
              items: getDisplay(),
            ),
          )),
    );
  }
}

typedef void StringCallback(String val);
