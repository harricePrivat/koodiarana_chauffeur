import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_event.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_state.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/services/authentification.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';

class SignInGoogleBloc extends Bloc<SignInGoogleEvent, SignInGoogleState> {
  SignInGoogleBloc() : super(GoogleConnectionInitial()) {
    on<TapGoogleButton>(
      (event, emit) async {
        try {
          emit(GoogleConnectionLoading());
          final userCredential = await AuthService().signInWithGoogle();
          // emit(GoogleConnectionInitial());
          if (userCredential == null) {
            emit(GoogleConnectionError(message: "no user"));
          } else {
            final name = userCredential.user!.displayName!.split(' ');
            final response =
                await SendData().goPost("${dotenv.env['URL']}/login-google", {
              "nom": name[0],
              "prenom": name.length >= 2 ? name[1] : "",
              "email": userCredential.user!.email!,
              "emailVerified": true
            });
            if (response.statusCode == 200) {
              final body = jsonDecode(response.body);
              emit(GoogleConnectionDone(
                  user: Users(
                nom: body['nom'],
                prenom: body['prenom'],
                email: body['email'],
              )));
              emit(GoogleConnectionInitial());
            } else {
              emit(GoogleConnectionError(message: "Erreur de connexion"));
            }
          }
        } catch (e) {
          emit(GoogleConnectionError(message: "error"));
          print(e);
        }
      },
    );
  }
}
