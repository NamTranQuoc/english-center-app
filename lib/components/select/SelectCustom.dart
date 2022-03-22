import 'package:flutter/material.dart';

class SelectCustom extends StatefulWidget {
  String item;
  final List<String> list;
  final String label;

  SelectCustom(this.item, this.list, this.label);

  @override
  State<SelectCustom> createState() => _SelectCustom();
}

class _SelectCustom extends State<SelectCustom> {
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
              },
              items: widget.list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
    );
  }
}
