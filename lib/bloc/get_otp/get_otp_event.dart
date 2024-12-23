part of 'get_otp_bloc.dart';

sealed class GetOtpEvent extends Equatable {
  const GetOtpEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
final class OnSearchMailEvent extends GetOtpEvent {
  String ?mail;

  OnSearchMailEvent({required this.mail});

  @override
  List<Object> get props => [mail!];
}
