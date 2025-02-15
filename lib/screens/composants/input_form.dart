import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class InputForm extends StatelessWidget {
  TextEditingController controller;
  String? label;
  String? placeholder;
  InputForm(
      {super.key, this.placeholder, this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      label: (label != null) ? Text(label!) : SizedBox(),
      controller: controller,
      placeholder: (placeholder != null) ? Text(placeholder!) : SizedBox(),
      decoration: const ShadDecoration(
        border: ShadBorder(
          top: ShadBorderSide(color: Colors.grey),
          bottom: ShadBorderSide(color: Colors.grey),
          left: ShadBorderSide(color: Colors.grey),
          right: ShadBorderSide(color: Colors.grey),
        ),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'ce champ est obligatoire';
        }
        return null;
      },
    );
  }
}
