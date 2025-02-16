import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koodiarana_chauffeur/bloc/get_otp/get_otp_bloc.dart';
import 'package:koodiarana_chauffeur/screens/pages/loading.dart';
import 'package:koodiarana_chauffeur/screens/pages/otp_done.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: Text("Recupération de compte")),
        body: BlocListener<GetOtpBloc, GetOtpState>(
          listener: (context, state) {
            if (state is GetOtpDone) {
              Fluttertoast.showToast(
                  msg: "Un email de récupération a été envoyé",
                  toastLength: Toast.LENGTH_LONG);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpDone(
                            mail: state.mail!,
                          )));
            }
            if (state is GetOtpError) {
              showDialog(
                  context: context,
                  builder: (context) => Padding(
                        padding: EdgeInsets.all(16),
                        child: ShadDialog.alert(
                          title: Text(state.titre!),
                          description: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              state.message!,
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
          child:
              BlocBuilder<GetOtpBloc, GetOtpState>(builder: (context, state) {
            if (state is GetOtpLoading) {
              return Loading();
            }
            return Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.00),
                child: ShadCard(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Mot de passe oulbié",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    description: Text(
                      "Entrez votre mail ou numéro de téléphone pour récupérer votre compte",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShadButton(
                          backgroundColor: theme.primaryColor,
                          child: Text(
                            'Récuperer',
                            style: TextStyle(color: theme.secondaryHeaderColor),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              context
                                  .read<GetOtpBloc>()
                                  .add(OnSearchMailEvent(mail: mailNum.text));
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
                            style: TextStyle(color: theme.primaryColor),
                            cursorColor: theme.primaryColor,
                            controller: mailNum,
                            id: 'username',
                            placeholder: Text(
                              'Entrez votre email ou numero de telephone',
                              style: TextStyle(color: theme.primaryColor),
                            ),
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
            ));
          }),
        ));
  }
}
