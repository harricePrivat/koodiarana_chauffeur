import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class InputMail extends StatelessWidget {
  TextEditingController mail = TextEditingController();
  String? label;
  String? placeholder;
  InputMail({super.key, this.placeholder, this.label, required this.mail});

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      label: Text(label ?? ""),
      controller: mail,
      placeholder: Text(placeholder ?? ''),
      keyboardType: TextInputType.emailAddress,
      decoration: ShadDecoration(
          border: ShadBorder(
        top: BorderSide(color: Colors.grey),
        bottom: BorderSide(color: Colors.grey),
        left: BorderSide(color: Colors.grey),
        right: BorderSide(color: Colors.grey),
      )),
      validator: (v) {
        if (v.isEmpty) {
          return 'ce champ est obligatoire';
        } else if (!v.contains('@') || !v.contains('.')) {
          return 'veuillez entrez un mail valide';
        }
        return null;
      },
    );
  }
}
