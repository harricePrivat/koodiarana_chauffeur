import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';

part 'step_event.dart';
part 'step_state.dart';

class StepBloc extends Bloc<StepEvent, StepsState> {
  StepBloc() : super(StepInitial()) {
    on<Step1Event>((event, emit) async {
      emit(StepLoading());
      try {
        final response =
            await SendData().goPost("${dotenv.env["URL"]}/users/create", {
          "nom": event.nom,
          "prenom": event.prenom,
          "email": event.email,
          "num": event.phoneNumber,
          "password": event.password,
          "dateNaissance": event.dateOfBirth.toString(),
          "status": true
        });
        if (response.statusCode == 201) {
          final data = jsonDecode(response.body);
          emit(StepDone(tokens: data['tokens']));
        } else if (response.statusCode == 500) {
          emit(StepError());
        } else {
          emit(StepError());
        }
      } catch (e) {
        emit(StepError());
      }
    });
  }
}
