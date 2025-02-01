part of 'verification_mail_bloc.dart';

sealed class VerificationMailState extends Equatable {
  const VerificationMailState();

  @override
  List<Object> get props => [];
}

final class VerificationMailInitial extends VerificationMailState {}

final class VerificationMailLoading extends VerificationMailState {}

// ignore: must_be_immutable
final class VerificationMailError extends VerificationMailState {
  String message;
  VerificationMailError({required this.message});

  @override
  List<Object> get props => [message];
}

final class VerificationMailDone extends VerificationMailState {}
