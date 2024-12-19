import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/screens/composants/password_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: Text("Changer de mot de passe")),
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.00),
            child: ShadCard(
              backgroundColor: Colors.transparent,
              title: Text(
                "Changer de mot de passe",
                //    style: style,
              ),
              description: Text(
                  "Entrez votre nouveau mot de passe pour récupérer votre compte"),
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadButton(
                    child: const Text('Récuperer'),
                    onPressed: () async {},
                  ),
                ],
              ),
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(),
                  PasswordInput(controller: controller1, color: theme.primaryColor),
                  PasswordInput(controller: controller2, color: theme.primaryColor),
                ],
              ),
            ),
          ),
        )));
  }
}
