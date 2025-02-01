part of 'verification_mail_bloc.dart';

sealed class VerificationMailEvent extends Equatable {
  const VerificationMailEvent();

  @override
  List<Object> get props => [];
}

class OnSubmitMail extends VerificationMailEvent {
  final String mail;

  OnSubmitMail({required this.mail});
}