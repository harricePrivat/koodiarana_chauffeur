part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class OnChangePassword extends ChangePasswordEvent {
  String password;
  String mail;
  OnChangePassword({required this.mail, required this.password});

  @override
  List<Object> get props => [password, mail];
}
