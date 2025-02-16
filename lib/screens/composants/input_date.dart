import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class InputDate extends StatelessWidget {
  DateTime datePicker;
  final ValueChanged<DateTime?> onDateChanged;
  String? label;
  InputDate(
      {super.key,
      this.label,
      required this.datePicker,
      required this.onDateChanged});

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
    final theme = Theme.of(context);
    return ShadInputFormField(
      cursorColor: theme.primaryColor,
      onPressed: () => _selectDate(context),
      readOnly: true,
      label: Text(label!, style: TextStyle(color: theme.primaryColor)),
      placeholder: Text(
        datePicker.toString(),
        style: TextStyle(color: theme.primaryColor),
      ),
      decoration: ShadDecoration(
          border: ShadBorder(
        top: ShadBorderSide(color: Colors.grey),
        bottom: ShadBorderSide(color: Colors.grey),
        left: ShadBorderSide(color: Colors.grey),
        right: ShadBorderSide(color: Colors.grey),
      )),
    );
  }
}
