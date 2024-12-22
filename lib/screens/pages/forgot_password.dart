import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/screens/pages/change_password.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<ShadFormState>();
  TextEditingController mailNum = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        if (formKey.currentState!.saveAndValidate()) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                        }
                      },
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    ShadForm(
                      key: formKey,
                      child: ShadInputFormField(
                        id: 'username',
                        placeholder: const Text(
                            'Entrez votre email ou numero de telephone'),
                        // description:
                        //     const Text('This is your public display name.'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'ce champ est obligatoire';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                )),
          ),
        )));
  }
}
