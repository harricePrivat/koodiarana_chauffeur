import 'package:equatable/equatable.dart';

class SignInGoogleState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleConnectionLoading extends SignInGoogleState {}

class GoogleConnectionInitial extends SignInGoogleState {}

class GoogleConnectionDone extends SignInGoogleState {}

// ignore: must_be_immutable
class GoogleConnectionError extends SignInGoogleState {
  String message;
  GoogleConnectionError({required this.message});

  @override
  List<Object> get props => [message];
}
