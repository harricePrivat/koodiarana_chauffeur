import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_date.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_form.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_mail.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late Users user;
  late TextEditingController nom;
  late TextEditingController prenom;
  late DateTime datePicker;
  late TextEditingController mail;
  final formKey = GlobalKey<ShadFormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<AppManager>(context, listen: false).getUsers!;
    nom = TextEditingController(text: user.nom);
    prenom = TextEditingController(text: user.prenom);
    mail = TextEditingController(text: user.email);
    datePicker = DateTime.parse(user.datedeNaissance!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mon compte"),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.00),
                child: ShadForm(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16.00,
                    children: [
                      Center(
                        child: ShadAvatar(
                            size: Size(100, 100), "assets/Logo_koodiarana.png"),
                      ),
                      InputForm(controller: nom, label: "votre nom"),
                      InputForm(controller: prenom, label: "votre prenom"),
                      InputMail(label: "votre email", mail: mail),
                      InputDate(
                          label: "votre date de naissance",
                          datePicker: datePicker,
                          onDateChanged: (value) {}),
                      ShadButton(
                        child: Text("Sauvegarder les changements"),
                      ),
                      ShadButton(
                        backgroundColor: Colors.red[300],
                        child: Text("Supprimer mon compte"),
                      )
                    ],
                  ),
                ))));
  }
}
