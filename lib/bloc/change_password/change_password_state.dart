part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

// ignore: must_be_immutable
final class ChangePasswordError extends ChangePasswordState {
  String message;
  ChangePasswordError({required this.message});
  @override
  List<Object> get props => [message];
}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordDone extends ChangePasswordState {}
