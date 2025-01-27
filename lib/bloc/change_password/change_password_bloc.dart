// import 'dart:convert';

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
            '${dotenv.env['URL']}/users/changePassword',
            {"email": event.mail, "newPassword": event.password});

        if (response.statusCode == 200) {
         // final body = jsonDecode(response.body);
          emit(ChangePasswordDone());
        } else if (response.statusCode == 404) {
          emit(ChangePasswordError(message: "Utilisateur introuvable"));
        } else if (response.statusCode == 500) {
          emit(ChangePasswordError(message: "Erreur de connexion"));
        } else {
          emit(ChangePasswordError(message: "Erreur de connexion"));
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
