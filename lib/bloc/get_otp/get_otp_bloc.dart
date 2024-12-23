import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';

part 'get_otp_event.dart';
part 'get_otp_state.dart';

class GetOtpBloc extends Bloc<GetOtpEvent, GetOtpState> {
  GetOtpBloc() : super(GetOtpInitial()) {
    on<OnSearchMailEvent>((event, emit) async {
      emit(GetOtpLoading());
      try {
        final response = await SendData().goPost(
            "${dotenv.env['URL']}/send-mail-mdp/", {"mail": event.mail!});
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          if ('OK'.compareTo(body['message']) == 0) {
            emit(GetOtpDone(mail: event.mail));
          } else {
            emit(GetOtpError(
                titre: "Erreur de récupération",
                message: "Utilisateur introuvable"));
          }
        }
      } catch (e) {
        emit(GetOtpError(
            titre: "Erreur connnexion", message: "Erreur de connexion"));
      }
    });
  }
}
