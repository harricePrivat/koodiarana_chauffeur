import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koodiarana_chauffeur/bloc/change_password/change_password_bloc.dart';
import 'package:koodiarana_chauffeur/screens/composants/password_input.dart';
import 'package:koodiarana_chauffeur/screens/pages/loading.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class ChangePassword extends StatefulWidget {
  String mail;
  ChangePassword({super.key, required this.mail});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final formKey = GlobalKey<ShadFormState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: Text("Changer de mot de passe")),
        body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordDone) {
              Fluttertoast.showToast(msg: "Modification réussie");
              Navigator.pop(context);
            }
            if (state is ChangePasswordError) {
              showDialog(
                  context: context,
                  builder: (context) => Padding(
                        padding: EdgeInsets.all(16),
                        child: ShadDialog.alert(
                          title: Text("Erreur connexion"),
                          description: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Echec de changement du mot de passe",
                            ),
                          ),
                          actions: [
                            ShadButton(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ));
            }
          },
          child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
              builder: (context, state) {
            if (state is ChangePasswordLoading) {
              return Loading();
            }
            return Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.00),
                child: ShadCard(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Changer de mot de passe",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    description: Text(
                      "Entrez votre nouveau mot de passe pour récupérer votre compte",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShadButton(
                          backgroundColor: theme.primaryColor,
                          child:  Text(
                            'Récuperer',
                            style: TextStyle(color: theme.secondaryHeaderColor),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              context.read<ChangePasswordBloc>().add(
                                  OnChangePassword(
                                      mail: widget.mail,
                                      password: controller1.text));
                            }
                          },
                        ),
                      ],
                    ),
                    child: ShadForm(
                      key: formKey,
                      child: Column(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(),
                          PasswordInput(
                            rePassword: false,
                            controller: controller1,
                          ),
                          PasswordInput(
                            rePassword: false,
                            // password: controller1.text,
                            controller: controller2,
                          ),
                        ],
                      ),
                    )),
              ),
            ));
          }),
        ));
  }
}
