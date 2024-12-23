part of 'test_otp_bloc.dart';

sealed class TestOtpEvent extends Equatable {
  const TestOtpEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
final class OnSubmitOtp extends TestOtpEvent {
  String? otp;
  String? mail;
  OnSubmitOtp({required this.otp, required this.mail});

  @override
  List<Object> get props => [otp!, mail!];
}
