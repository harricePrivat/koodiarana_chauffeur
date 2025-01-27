part of 'step_bloc.dart';

sealed class StepEvent extends Equatable {
  const StepEvent();

  @override
  List<Object> get props => [];
}

final class Step1Event extends StepEvent {
  final String nom;
  final String prenom;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;

  const Step1Event({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props =>
      [nom, prenom, email, phoneNumber, dateOfBirth];
}

final class Step2Event extends StepEvent {
  final String cin;
  final String number;
  final String mail;

  const Step2Event({
    required this.cin,
    required this.number,
    required this.mail,
  });

  @override
  List<Object> get props => [cin, number, mail];
}

// ignore: must_be_immutable
final class Step3Event extends StepEvent {
  XFile rectoCIN;
  XFile versoCIN;
  Step3Event({required this.rectoCIN, required this.versoCIN});
  @override
  List<Object> get props => [rectoCIN, versoCIN];
}

// ignore: must_be_immutable
final class Step4Event extends StepEvent {
  XFile pdp;
  XFile moto;
  Step4Event({required this.pdp, required this.moto});
  @override
  List<Object> get props => [pdp, moto];
}
