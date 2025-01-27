import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_event.dart';
import 'package:koodiarana_chauffeur/bloc/to_login/to_login_bloc.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/button_google.dart';
import 'package:koodiarana_chauffeur/screens/pages/add_user.dart';
// import 'package:koodiarana_chauffeur/screens/pages/ajout_utilisateur.dart';
import 'package:koodiarana_chauffeur/screens/pages/forgot_password.dart';
import 'package:koodiarana_chauffeur/screens/pages/loading.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../composants/password_input.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  bool error;
  Login({super.key, required this.error});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mailNum = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.error) {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<ShadFormState>();
    // final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return BlocListener<ToLoginBloc, ToLoginState>(listener: (context, state) {
      if (state is ToLoginDone) {
        Provider.of<AppManager>(context, listen: false).connected(state.user);
      }
      if (state is ToLoginError) {
        showDialog(
            context: context,
            builder: (context) => Padding(
                  padding: EdgeInsets.all(16),
                  child: ShadDialog.alert(
                    title: Text("Erreur connexion"),
                    description: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        state.messsage,
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
    }, child: BlocBuilder<ToLoginBloc, ToLoginState>(builder: (context, state) {
      if (state is ToLoginLoading) {
        return Loading();
      }
      return Padding(
          padding: EdgeInsets.all(16.00),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ShadCard(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Chauffeur",
                      //    style: style,
                    ),
                    description: Text(
                        "Se connecter avec votre compte chauffeur Koodiarana"),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShadButton(
                          child: const Text('Se connecter'),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              context.read<ToLoginBloc>().add(OnSubmitLogin(
                                  mailNum: mailNum.text,
                                  password: password.text));
                              mailNum.clear();
                              password.clear();
                            }
                          },
                        ),
                        ShadButton.link(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddUser()));
                            },
                            child: Text(
                              'S\'inscrire',
                              //  style: style,
                            ))
                      ],
                    ),
                    child: ShadForm(
                      key: formKey,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(),
                            ShadInputFormField(
                              controller: mailNum,
                              id: 'username',
                              label:
                                  const Text('adresse ou numéro de téléphone'),
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
                            PasswordInput(
                                rePassword: false,
                                controller: password,
                                color: theme.primaryColor)
                          ],
                        ),
                      ),
                    ),
                  ),
                  ShadButton.link(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      "Mot de passe oublié?",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Center(
                    child: ButtonGoogle(
                      onPressed: () {
                        context.read<SignInGoogleBloc>().add(TapGoogleButton());
                      },
                    ),
                  )
                ],
              ),
            ),
          ));
    }));
  }
}
