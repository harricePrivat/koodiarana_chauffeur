import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_date.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_form.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_mail.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_num.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late Users user;
  late TextEditingController nom = TextEditingController();
  late TextEditingController prenom = TextEditingController();
  late DateTime datePicker;
  late TextEditingController mail = TextEditingController();
  late TextEditingController num = TextEditingController();
  final formKey = GlobalKey<ShadFormState>();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   user = Provider.of<AppManager>(context, listen: false).getUsers!;
  //   nom = TextEditingController(text: user.nom);
  //   prenom = TextEditingController(text: user.prenom);
  //   mail = TextEditingController(text: user.email);
  //   datePicker = DateTime.parse(user.datedeNaissance!);
  //   num = TextEditingController(text: user.phoneNumber);
  // }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppManager>(context, listen: false).getUsers!;
    datePicker = DateTime.parse(user.datedeNaissance!);
    final theme = Theme.of(context);
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
                      InputForm(
                        controller: nom,
                        label: "votre nom",
                        placeholder: user.nom,
                      ),
                      InputForm(
                        controller: prenom,
                        label: "votre prenom",
                        placeholder: user.prenom,
                      ),
                      InputMail(label: "votre email", mail: mail,placeholder: user.email,),
                      InputDate(
                          label: "votre date de naissance",
                          datePicker: datePicker,
                          onDateChanged: (value) {}),
                      InputNum(controller: num,placeholder: user.phoneNumber,),
                      ShadButton(
                        backgroundColor: theme.primaryColor,
                        child: Text(
                          "Sauvegarder les changements",
                          style: TextStyle(color: theme.secondaryHeaderColor),
                        ),
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
