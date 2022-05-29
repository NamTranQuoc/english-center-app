import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final String label;
  final TextEditingController dateController;
  final DateTime initDate;

  DatePicker(this.label, this.dateController, this.initDate);

  final _format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: DateTimeField(
          format: _format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? initDate,
                lastDate: DateTime(2100));
          },
          controller: dateController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 18, top: 18),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              labelText: label)),
    );
  }
}

typedef void StringCallback(String val);
