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
    final theme = Theme.of(context);
    return ShadInputFormField(
      cursorColor: theme.primaryColor,
      label: Text(
        label ?? "",
        style: TextStyle(color: theme.primaryColor),
      ),
      controller: mail,
      placeholder: Text(
        placeholder ?? '',
        style: TextStyle(color: theme.primaryColor),
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: ShadDecoration(
          border: ShadBorder(
        top: ShadBorderSide(color: Colors.grey),
        bottom: ShadBorderSide(color: Colors.grey),
        left: ShadBorderSide(color: Colors.grey),
        right: ShadBorderSide(color: Colors.grey),
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
