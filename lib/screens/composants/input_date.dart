import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class InputDate extends StatelessWidget {
  DateTime datePicker;
  final ValueChanged<DateTime?> onDateChanged;

  InputDate({super.key, required this.datePicker, required this.onDateChanged});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: datePicker,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      onDateChanged(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      onPressed: () => _selectDate(context),
      readOnly: true,
      label: Text("entrez votre date de naissance *"),
      placeholder: Text(datePicker.toString()),
      decoration: ShadDecoration(
          border: ShadBorder(
        top: BorderSide(color: Colors.grey),
        bottom: BorderSide(color: Colors.grey),
        left: BorderSide(color: Colors.grey),
        right: BorderSide(color: Colors.grey),
      )),
    );
  }
}
