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
        final response = await SendData().goPost(
            "${dotenv.env['URL']}/auth/login",
            {"email": event.mailNum!, "password": event.password!});
        print("Status code : ${response.statusCode}");
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          print(body);
          emit(ToLoginDone(
              user: Users(
                  nom: body['nom'],
                  prenom: body['prenom'],
                  datedeNaissance: body['dateNaissance'],
                  email: body['email'],
                  phoneNumber: body['num'])));
        } else if (response.statusCode == 401) {
          final body = jsonDecode(response.body);
          final data = body['message'];
          emit(ToLoginError(messsage: data));
        } else if (response.statusCode == 404) {
          final body = jsonDecode(response.body);
          final data = body['message'];
          emit(ToLoginError(messsage: data));
        }
      } catch (e) {
        print(e);
        emit(ToLoginError(messsage: "Erreur de connexion"));
      }
    });
  }
}
