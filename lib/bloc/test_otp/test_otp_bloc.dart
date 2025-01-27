import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';
//import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
part 'test_otp_event.dart';
part 'test_otp_state.dart';

class TestOtpBloc extends Bloc<TestOtpEvent, TestOtpState> {
  TestOtpBloc() : super(TestOtpInitial()) {
    on<OnSubmitOtp>((event, emit) async {
      emit(TestOtpLoading());
      try {
        final response = await SendData()
            .goPost("${dotenv.env['URL']}/users/verifyOTP", {"otp": event.otp});
        print(response.statusCode);
        if (response.statusCode == 200) {
         // final body = jsonDecode(response.body);
          //if ("OK".compareTo(body['message']) == 0) {
            emit(TestOtpDone(mail: event.mail!));
          
        } else if (response.statusCode == 401) {
          emit(
              TestOtpError(message: "OTP incorrect, veuillez bien vérifier!!"));
        } else if (response.statusCode == 500) {
          emit(TestOtpError(message: "Erreur de connexion"));
        } else {
          emit(
              TestOtpError(message: "Erreur de connexion, veuillez réessayer"));
        }
      } catch (e) {
        emit(TestOtpError(message: "Erreur de connexion"));
        print(e);
      }
    });
  }
}
