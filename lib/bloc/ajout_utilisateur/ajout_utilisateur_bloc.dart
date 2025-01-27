import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
part 'ajout_utilisateur_event.dart';
part 'ajout_utilisateur_state.dart';

class AjoutUtilisateurBloc
    extends Bloc<AjoutUtilisateurEvent, AjoutUtilisateurState> {
  AjoutUtilisateurBloc() : super(AjoutUtilisateurInitial()) {
    on<OnAddUser>((event, emit) async {
      emit(AjoutUtilisateurLoading());
      try {
        final response = await SendData()
            .goPost("${dotenv.env["URL"]}/users/create", {
          "nom": event.users!.nom,
          "prenom": event.users!.prenom,
          "num": event.users!.phoneNumber,
          "email": event.users!.email,
          "password": event.password,
          "dateDeNaissance": event.users!.datedeNaissance,
          "emailVerified": false,
          "client": false
        });
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          if ("send_mail".compareTo(body['message']) == 0) {
            emit(AjoutUtilisateurDone());
          } else {
            emit(AjoutUtilisateurError(message: "Utilisateur existe déja"));
          }
        }
      } catch (e) {
       // print(e);
        emit(AjoutUtilisateurError(
            message: "Erruer de l'ajout de l'utilisateur"));
      }
    });
  }
}
