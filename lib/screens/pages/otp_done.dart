import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/test_otp/test_otp_bloc.dart';
import 'package:koodiarana_chauffeur/screens/pages/change_password.dart';
import 'package:koodiarana_chauffeur/screens/pages/loading.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class OtpDone extends StatefulWidget {
  String mail;
  OtpDone({super.key, required this.mail});

  @override
  State<OtpDone> createState() => _OtpDoneState();
}

class _OtpDoneState extends State<OtpDone> {
  final formKey = GlobalKey<ShadFormState>();
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OTP"),
        ),
        body: BlocListener<TestOtpBloc, TestOtpState>(
          listener: (context, state) {
            if (state is TestOtpDone) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword(
                            mail: widget.mail,
                          )));
            }
            if (state is TestOtpError) {
              showDialog(
                  context: context,
                  builder: (context) => Padding(
                        padding: EdgeInsets.all(16),
                        child: ShadDialog.alert(
                          title: Text("Erreur OTP"),
                          description: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              state.message,
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
              BlocBuilder<TestOtpBloc, TestOtpState>(builder: (context, state) {
            if (state is TestOtpLoading) {
              return Loading();
            }
            return Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.00),
                child: ShadCard(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "OTP de récupération",
                      //    style: style,
                    ),
                    description: Text(
                        "Veuillez tapez ici l'OTP de récupération de votre compte"),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShadButton(
                          child: const Text('Récuperer'),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              context.read<TestOtpBloc>().add(OnSubmitOtp(
                                  otp: otp.text, mail: widget.mail));
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
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: otp,
                            id: 'otp',
                            placeholder: const Text('OTP de récupération'),
                            // description:
                            //     const Text('This is your public display name.'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'ce champ est obligatoire';
                              }
                              if (v.length < 6) {
                                return 'nombre insuffisant';
                              }
                              if (v.length > 6) {
                                return 'nombre trop élévé';
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
