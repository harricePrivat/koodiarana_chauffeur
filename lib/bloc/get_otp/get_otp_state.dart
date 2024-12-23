part of 'get_otp_bloc.dart';

sealed class GetOtpState extends Equatable {
  const GetOtpState();

  @override
  List<Object> get props => [];
}

final class GetOtpInitial extends GetOtpState {}

final class GetOtpLoading extends GetOtpState {}

// ignore: must_be_immutable
final class GetOtpError extends GetOtpState {
  String? message;
  String? titre;
  GetOtpError({required this.message, required this.titre});

  @override
  List<Object> get props => [message!, titre!];
}

// ignore: must_be_immutable
final class GetOtpDone extends GetOtpState {
  String? mail;
  GetOtpDone({required this.mail});

  @override
  List<Object> get props => [mail!];
}
