part of 'to_login_bloc.dart';

sealed class ToLoginState extends Equatable {
  const ToLoginState();

  @override
  List<Object> get props => [];
}

final class ToLoginInitial extends ToLoginState {}

// ignore: must_be_immutable
final class ToLoginError extends ToLoginState {
  String messsage;
  ToLoginError({required this.messsage});
}

final class ToLoginLoading extends ToLoginState {}

// ignore: must_be_immutable
final class ToLoginDone extends ToLoginState {
  Users user;
  ToLoginDone({required this.user});

  @override
  List<Object> get props => [user];
}
