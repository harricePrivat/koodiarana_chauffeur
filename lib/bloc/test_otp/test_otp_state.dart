part of 'test_otp_bloc.dart';

sealed class TestOtpState extends Equatable {
  const TestOtpState();

  @override
  List<Object> get props => [];
}

final class TestOtpInitial extends TestOtpState {}

// ignore: must_be_immutable
final class TestOtpError extends TestOtpState {
  String message;
  TestOtpError({required this.message});

  @override
  List<Object> get props => [message];
}

final class TestOtpLoading extends TestOtpState {}

// ignore: must_be_immutable
final class TestOtpDone extends TestOtpState {
  String mail;
  TestOtpDone({required this.mail});
  @override
  List<Object> get props => [mail];
}
