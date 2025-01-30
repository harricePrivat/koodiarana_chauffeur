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
  final String password;
  final DateTime dateOfBirth;

  const Step1Event({
    required this.password,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props =>
      [nom, password, prenom, email, phoneNumber, dateOfBirth];
}

// ignore: must_be_immutable
final class Step3Event extends StepEvent {
  XFile rectoCIN;
  String email;
  XFile versoCIN;
  Step3Event(
      {required this.email, required this.rectoCIN, required this.versoCIN});
  @override
  List<Object> get props => [rectoCIN, versoCIN, email];
}

// ignore: must_be_immutable
final class Step4Event extends StepEvent {
  String email;
  XFile pdp;
  XFile moto;
  Step4Event({required this.email,required this.pdp, required this.moto});
  @override
  List<Object> get props => [email,pdp, moto];
}
