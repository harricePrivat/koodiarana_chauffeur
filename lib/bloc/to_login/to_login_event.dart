part of 'to_login_bloc.dart';

sealed class ToLoginEvent extends Equatable {
  const ToLoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
final class OnSubmitLogin extends ToLoginEvent {
  String? mailNum;
  String? password;

  OnSubmitLogin({required this.mailNum, required this.password});

  @override
  List<Object> get props => [mailNum!, password!];
}
