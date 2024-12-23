import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<OnChangePassword>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        final response = await SendData().goPost(
            '${dotenv.env['URL']}/change-password',
            {"mail": event.mail, "newMdp": event.password});

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          print(body);
          if ("OK".compareTo(body['message']) == 0) {
            emit(ChangePasswordDone());
          } else {
            emit(ChangePasswordError(message: "Erreur de connexion"));
          }
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
