import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koodiarana_chauffeur/providers/stepper.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_cin.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_date.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_form.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_mail.dart';
import 'package:koodiarana_chauffeur/screens/composants/input_num.dart';
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
                        ShadButton(
                          child: Text("Précédent"),
                          onPressed: () {
                            if (step.currentStep > 0) {
                              step.onChange(step.currentStep - 1);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      if (step.currentStep != 3)
                        ShadButton(
                          child: Text("Suivant"),
                          onPressed: () {
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
                                if (step.currentStep < 4) {
                                  step.onChange(step.currentStep + 1);
                                } else {
                                  //
                                }
                              }
                            } else if (step.currentStep == 2) {
                              //  if (formKey3.currentState!.validate()) {
                              if (rectoCIN != null && versoCIN != null) {
                                if (step.currentStep < 4) {
                                  step.onChange(step.currentStep + 1);
                                } else {
                                  //
                                }
                              } else {
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
                                                "Vous devez ajouter les photos de votre CIN (recto et verso)",
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
                            } else if (step.currentStep == 3) {
                              // if (formKey4.currentState!.validate()) {
                              if (moto != null && pdp != null) {
                                if (step.currentStep < 4) {
                                  step.onChange(step.currentStep + 1);
                                } else {
                                  //
                                }
                              } else {
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
                                                "Vous devez ajouter les photos de votre moto et de votre profil",
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
                              // }
                            }
                          },
                        ),
                      if (step.currentStep == 3)
                        ShadButton(
                          child: Text("Terminer"),
                          onPressed: () {},
                        )
                    ],
                  );
                },
                currentStep: step.currentStep,
                onStepTapped: (step) {},
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
                          child: Column(
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
                            ],
                          ))),
                  Step(
                      title: Text("Photo de votre CIN"),
                      content: Column(
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
                      )),
                  Step(
                      title: Text("Photo supplementaire"),
                      content: Column(
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
                      ))
                ]),
          );
        }));
  }
}
