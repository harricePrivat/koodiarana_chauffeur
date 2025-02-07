import 'package:equatable/equatable.dart';
import 'package:koodiarana_chauffeur/models/user.dart';

class SignInGoogleState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleConnectionLoading extends SignInGoogleState {}

class GoogleConnectionInitial extends SignInGoogleState {}

// ignore: must_be_immutable
class GoogleConnectionDone extends SignInGoogleState {
  Users? user;
  GoogleConnectionDone({required this.user});

  @override
  List<Object> get props => [user!];
}

// ignore: must_be_immutable
class FirstGoogleConnection extends SignInGoogleState {
  Users? user;
  FirstGoogleConnection({required this.user});

  @override
  List<Object> get props => [user!];
}

// ignore: must_be_immutable
class GoogleConnectionError extends SignInGoogleState {
  String message;
  GoogleConnectionError({required this.message});

  @override
  List<Object> get props => [message];
}
