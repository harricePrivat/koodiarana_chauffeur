import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:koodiarana_chauffeur/screens/pages/change_password.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailNum = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(title: Text("Recupération de compte")),
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.00),
            child: ShadCard(
              backgroundColor: Colors.transparent,
              title: Text(
                "Mot de passe oulbié",
                //    style: style,
              ),
              description: Text(
                  "Entrez votre mail ou numéro de téléphone pour récupérer votre compte"),
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadButton(
                    child: const Text('Récuperer'),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 14),
                  FormBuilderTextField(
                    controller: mailNum,
                    name: "mailNum",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(color: theme.primaryColor),
                    decoration: InputDecoration(
                      label: Text('Mail ou Numero de telephone',
                          style: textTheme.titleSmall),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.00)),
                      ),
                      hintText: "...@gmail.com ou +261....",
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Ce champ  est obligatoire"),
                    ]),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        )));
  }
}
