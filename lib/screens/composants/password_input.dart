import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class PasswordInput extends StatefulWidget {
  TextEditingController controller;
  bool rePassword;
  String? password;
  // Color color;
  PasswordInput({
    super.key,
    this.password,
    required this.rePassword,
    required this.controller,
    // required this.color
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadInputFormField(
      id: 'mdp',
      label: Text("mot de passe", style: TextStyle(color: theme.primaryColor)),
      cursorColor: theme.primaryColor,
      controller: widget.controller,
      placeholder: const Text('*******'),
      obscureText: obscure,
      decoration: ShadDecoration(
          // label: Text(
          //   'Mot de passe',
          //   style: textTheme.titleSmall,
          // ),
          // border: const ShadBorder(
          //     borderSide: BorderSide(width: 0.2),
          //     borderRadius: BorderRadius.all(Radius.circular(8))),
          // hintText: '*******',

          ),
      prefix: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          size: 16,
          LucideIcons.lock,
          color: theme.primaryColor,
        ),
      ),
      suffix: ShadButton(
        width: 24,
        height: 24,
        padding: EdgeInsets.zero,
        decoration: const ShadDecoration(
          secondaryBorder: ShadBorder.none,
          secondaryFocusedBorder: ShadBorder.none,
        ),
        icon: Icon(
          obscure ? LucideIcons.eyeOff : LucideIcons.eye,
          color: Colors.white,
          size: 16,
        ),
        onPressed: () {
          setState(() => obscure = !obscure);
        },
      ),
      validator: (v) {
        if (!widget.rePassword) {
          final passwordRegex = RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*.?&]{8,}$');

          if (v.isEmpty) {
            return 'ce champ est obligatoire';
          }
          if (!passwordRegex.hasMatch(v)) {
            return 'Le mot de passe doit contenir :\n'
                '- Au moins 8 caractères\n'
                '- Une majuscule\n'
                '- Une minuscule\n'
                '- Un chiffre\n'
                '- Un caractère spécial (@\$!%*.?&)';
          }
        } else {
          if (widget.password!.compareTo(v) != 0) {
            return 'vérifiez votre mot de passe';
          }
          if (v.isEmpty) {
            return 'ce champ est obligatoire';
          }
        }
        return null;
      },
      style: TextStyle(color: theme.primaryColor),
    );
  }
}
