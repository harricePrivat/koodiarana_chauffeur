import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';

part 'to_login_event.dart';
part 'to_login_state.dart';

class ToLoginBloc extends Bloc<ToLoginEvent, ToLoginState> {
  ToLoginBloc() : super(ToLoginInitial()) {
    on<OnSubmitLogin>((event, emit) async {
      emit(ToLoginLoading());
      try {
        final response = await SendData().goPost("${dotenv.env['URL']}/login",
            {"mailNum": event.mailNum!, "mdp": event.password!});
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          final data = body['data'];
          emit(ToLoginDone(
              user: Users(
                  nom: data['nom'],
                  prenom: data['prenom'],
                  datedeNaissance: data['dateDeNaissance'],
                  email: data['email'],
                  phoneNumber: data['num'])));
        } else {
          emit(ToLoginError(messsage: "Identifiant ou mot de passe incorrect"));
        }
      } catch (e) {
        print(e);
        emit(ToLoginError(messsage: "Erreur de connexion"));
      }
    });
  }
}
