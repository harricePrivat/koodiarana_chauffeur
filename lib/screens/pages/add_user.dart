import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koodiarana_chauffeur/bloc/stepper/step_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/verification_mail/verification_mail_bloc.dart';
import 'package:koodiarana_chauffeur/providers/stepper.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_cin.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_date.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_form.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_mail.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_num.dart';
import 'package:koodiarana_chauffeur/screens/composants/password_input.dart';
import 'package:koodiarana_chauffeur/screens/composants/pick_images.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formKey1 = GlobalKey<ShadFormState>();
  final formKey2 = GlobalKey<ShadFormState>();

  XFile? rectoCIN;
  XFile? versoCIN;
  XFile? pdp;
  XFile? moto;
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController num = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController cin = TextEditingController();

  DateTime pickedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un utilisateur'),
      ),
      body: Consumer<StepperNotifier>(builder: (context, step, child) {
        return SingleChildScrollView(
          child: Stepper(
              physics: NeverScrollableScrollPhysics(),
              controlsBuilder: (context, controlDetails) {
                return Row(
                  children: [
                    if (step.currentStep != 0)
                      BlocBuilder<StepBloc, StepsState>(
                          builder: (context, state) {
                        return ShadButton(
                          onPressed: state is StepLoading
                              ? null
                              : () {
                                  if (step.currentStep > 0) {
                                    step.onChange(step.currentStep - 1);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                          child: state is StepLoading
                              ? Text(".....")
                              : Text("Précédent"),
                        );
                      }),
                    if (step.currentStep != 3)
                      BlocBuilder<StepBloc, StepsState>(
                          builder: (context, state) {
                        return ShadButton(
                          onPressed: state is StepLoading
                              ? null
                              : () {
                                  if (step.currentStep == 0) {
                                    if (formKey1.currentState!.validate()) {
                                      if (step.currentStep < 4) {
                                        step.onChange(step.currentStep + 1);
                                      } else {
                                        //
                                      }
                                    }
                                  } else if (step.currentStep == 1) {
                                    if (formKey2.currentState!.validate()) {
                                      context.read<StepBloc>().add(Step1Event(
                                          password: password.text,
                                          nom: nom.text,
                                          prenom: prenom.text,
                                          email: mail.text,
                                          phoneNumber: num.text,
                                          dateOfBirth: pickedDate));
                                      // if (step.currentStep < 4) {
                                      //   step.onChange(step.currentStep + 1);
                                      // } else {
                                      //   //
                                      // }
                                    }
                                  } else if (step.currentStep == 2) {
                                    //  if (formKey3.currentState!.validate()) {
                                    if (rectoCIN != null && versoCIN != null) {
                                      context.read<StepBloc>().add(Step3Event(
                                          email: mail.text,
                                          rectoCIN: rectoCIN!,
                                          versoCIN: versoCIN!));
                                      // if (step.currentStep < 4) {
                                      //   step.onChange(step.currentStep + 1);
                                      // } else {
                                      //   //
                                      // }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Padding(
                                                padding: EdgeInsets.all(16),
                                                child: ShadDialog.alert(
                                                  title: Text("Erreur"),
                                                  description: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Text(
                                                      "Vous devez ajouter les photos de votre CIN (recto et verso)",
                                                    ),
                                                  ),
                                                  actions: [
                                                    ShadButton(
                                                      child: const Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    }
                                  } else if (step.currentStep == 3) {
                                    // if (formKey4.currentState!.validate()) {
                                    if (moto != null && pdp != null) {
                                      context.read<StepBloc>().add(Step4Event(
                                          email: mail.text,
                                          pdp: pdp!,
                                          moto: moto!));
                                      // if (step.currentStep < 4) {
                                      //   step.onChange(step.currentStep + 1);
                                      // } else {
                                      //   //
                                      // }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Padding(
                                                padding: EdgeInsets.all(16),
                                                child: ShadDialog.alert(
                                                  title: Text("Erreur"),
                                                  description: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Text(
                                                      "Vous devez ajouter les photos de votre moto et de votre profil",
                                                    ),
                                                  ),
                                                  actions: [
                                                    ShadButton(
                                                      child: const Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    }
                                    // }
                                  }
                                },
                          child: state is StepLoading
                              ? CircularProgressIndicator(
                                  color: theme.primaryColor,
                                )
                              : Text("Suivaint"),
                        );
                      }),
                    if (step.currentStep == 3)
                      BlocBuilder<StepBloc, StepsState>(
                          builder: (context, state) {
                        return ShadButton(
                          onPressed: state is StepLoading
                              ? null
                              : () {
                                  context.read<StepBloc>().add(Step4Event(
                                      email: mail.text,
                                      pdp: pdp!,
                                      moto: moto!));
                                },
                          child: state is StepLoading
                              ? CircularProgressIndicator(
                                  color: theme.primaryColor,
                                )
                              : Text("Terminer"),
                        );
                      })
                  ],
                );
              },
              currentStep: step.currentStep,
              type: StepperType.vertical,
              steps: [
                Step(
                    title: Text('Informations personnelles'),
                    content: ShadForm(
                      key: formKey1,
                      child: Column(
                        children: [
                          InputForm(
                              label: "votre nom *",
                              placeholder: "entrez votre nom",
                              controller: nom),
                          InputForm(
                              label: "votre prénom *",
                              placeholder: "entrez votre prénom",
                              controller: prenom),
                          InputDate(
                            label: "entrez vote date de naissance * ",
                            datePicker: pickedDate,
                            onDateChanged: (value) {
                              setState(() {
                                pickedDate = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    )),
                Step(
                    title: Text("Information suppelementaire"),
                    content: ShadForm(
                        key: formKey2,
                        child: BlocListener<StepBloc, StepsState>(
                          listener: (context, state) {
                            if (state is StepDone1) {
                              step.onChange(step.currentStep + 1);
                            } else if (state is StepError1) {
                              showDialog(
                                  context: context,
                                  builder: (context) => Padding(
                                        padding: EdgeInsets.all(16),
                                        child: ShadDialog.alert(
                                          title: Text("Erreur"),
                                          description: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Text(
                                              "Une erreur s'est produite lors de l'ajout de l'information",
                                            ),
                                          ),
                                          actions: [
                                            ShadButton(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ));
                            }
                          },
                          child: BlocBuilder<StepBloc, StepsState>(
                              builder: (context, state) {
                            if (state is StepLoading) {
                              return Padding(
                                padding: EdgeInsets.all(16.00),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: theme.primaryColor,
                                )),
                              );
                            }
                            return Column(
                              children: [
                                InputCin(
                                  controller: cin,
                                  label: "votre cin *",
                                  placeholder: "entrez votre cin",
                                ),
                                InputNum(controller: num),
                                InputMail(
                                  mail: mail,
                                  label: "votre mail * ",
                                  placeholder: "entrez votre mail ",
                                ),
                                PasswordInput(
                                    rePassword: false,
                                    controller: password,
                                    color: theme.primaryColor),
                              ],
                            );
                          }),
                        ))),
                Step(
                    title: Text("Photo de votre CIN"),
                    content: BlocListener<StepBloc, StepsState>(
                      listener: (context, state) {
                        if (state is StepDone2) {
                          if (step.currentStep < 4) {
                            step.onChange(step.currentStep + 1);
                          }
                        }
                        if (state is StepError2) {
                          showDialog(
                              context: context,
                              builder: (context) => Padding(
                                    padding: EdgeInsets.all(16),
                                    child: ShadDialog.alert(
                                      title: Text("Erreur"),
                                      description: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Une erreur s'est produite lors de l'ajout des photos de votre CIN",
                                        ),
                                      ),
                                      actions: [
                                        ShadButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ));
                        }
                      },
                      child: BlocBuilder<StepBloc, StepsState>(
                          builder: (context, state) {
                        if (state is StepLoading) {
                          return Padding(
                            padding: EdgeInsets.all(16.00),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            )),
                          );
                        }
                        return Column(
                          spacing: 16,
                          children: [
                            PickImages(
                                images: rectoCIN,
                                onPicked: () async {
                                  final picker = ImagePicker();
                                  rectoCIN = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                                name: "Ajouter la photo de votre CIN (recto)"),
                            PickImages(
                                images: versoCIN,
                                onPicked: () async {
                                  final picker = ImagePicker();
                                  versoCIN = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                                name: "Ajouter la photo de votre CIN (verso)"),
                          ],
                        );
                      }),
                    )),
                Step(
                    title: Text("Photo supplementaire"),
                    content: BlocListener<StepBloc, StepsState>(
                      listener: (context, state) {
                        if (state is StepDone3) {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => Padding(
                                    padding: EdgeInsets.all(16),
                                    child: ShadDialog.alert(
                                      title: Text("Créer avec succès"),
                                      description: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: BlocBuilder<
                                                  VerificationMailBloc,
                                                  VerificationMailState>(
                                              builder: (context, state) {
                                            if (state
                                                is VerificationMailError) {
                                              return Text(
                                                  "Une erreur s'est produite lors de l'envoi du mail de vérification");
                                            }
                                            if (state
                                                is VerificationMailLoading) {
                                              return CircularProgressIndicator(
                                                color:
                                                    theme.secondaryHeaderColor,
                                              );
                                            }
                                            if (state is VerificationMailDone) {
                                              return Text(
                                                  "Votre compte a été créé avec succès, veuillez vérifier votre boîte mail pour activer votre compte");
                                            }
                                            return Text(
                                              "Votre compte a été créé avec succès, veuillez vérifier votre boîte mail pour activer votre compte",
                                            );
                                          })),
                                      actions: [
                                        BlocBuilder<VerificationMailBloc,
                                                VerificationMailState>(
                                            builder: (context, state) {
                                          return ShadButton(
                                              child: Text(state
                                                      is VerificationMailLoading
                                                  ? "Loading...."
                                                  : "OK"),
                                              onPressed: () {
                                                if (state
                                                    is VerificationMailLoading) {
                                                  null;
                                                }
                                                if (state
                                                        is VerificationMailError ||
                                                    state
                                                        is VerificationMailInitial) {
                                                  context
                                                      .read<
                                                          VerificationMailBloc>()
                                                      .add(OnSubmitMail(
                                                          mail: mail.text));
                                                  if (state
                                                      is VerificationMailDone) {
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              });
                                        })
                                      ],
                                    ),
                                  ));
                        }
                        if (state is StepError3) {
                          showDialog(
                              context: context,
                              builder: (context) => Padding(
                                    padding: EdgeInsets.all(16),
                                    child: ShadDialog.alert(
                                      title: Text("Erreur"),
                                      description: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Une erreur s'est produite lors de l'ajout des photos de votre moto et de votre profil",
                                        ),
                                      ),
                                      actions: [
                                        ShadButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ));
                        }
                      },
                      child: BlocBuilder<StepBloc, StepsState>(
                          builder: (context, state) {
                        if (state is StepLoading) {
                          return Padding(
                            padding: EdgeInsets.all(16.00),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            )),
                          );
                        }
                        return Column(
                          spacing: 16,
                          children: [
                            PickImages(
                                images: pdp,
                                onPicked: () async {
                                  final picker = ImagePicker();
                                  pdp = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                                name: "Ajouter la photo de profil"),
                            PickImages(
                                images: moto,
                                onPicked: () async {
                                  final picker = ImagePicker();
                                  moto = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                                name: "Ajouter la photo de votre moto"),
                          ],
                        );
                      }),
                    ))
              ]),
        );
      }),
    );
  }
}
