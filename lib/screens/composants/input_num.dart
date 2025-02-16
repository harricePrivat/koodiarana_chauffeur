import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class InputNum extends StatelessWidget {
  TextEditingController controller;
  String? placeholder;
  InputNum({super.key, required this.controller, this.placeholder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadInputFormField(
      cursorColor: theme.primaryColor,
      controller: controller,
      label: Text(
        "votre numéro de téléphone *",
        style: TextStyle(color: theme.primaryColor),
      ),
      placeholder: Text(
        (placeholder!.isEmpty)
            ? "entrez votre numero de téléphone"
            : placeholder!,
        style: TextStyle(color: theme.primaryColor),
      ),
      decoration: ShadDecoration(
          border: ShadBorder(
        top: ShadBorderSide(color: Colors.grey),
        bottom: ShadBorderSide(color: Colors.grey),
        left: ShadBorderSide(color: Colors.grey),
        right: ShadBorderSide(color: Colors.grey),
      )),
      keyboardType: TextInputType.phone,
      validator: (v) {
        if (v.length < 10) {
          return 'nombre insuffisant';
        } else if (v.length > 10) {
          return 'nombre trop élevé';
        }
        return null;
      },
    );
  }
}
