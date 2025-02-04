import 'dart:convert';

import 'package:dio/dio.dart';
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
          emit(StepDone1(tokens: data['token']));
        } else if (response.statusCode == 500) {
          emit(StepError1());
        } else if (response.statusCode == 401) {
          emit(StepError1());
        } else {
          emit(StepError1());
        }
      } catch (e) {
        print("Erreur : $e");
        emit(StepError1());
      }
    });

    on<Step3Event>((event, emit) async {
      emit(StepLoading());
      try {
        FormData formDataRecto = FormData.fromMap({
          "email": event.email,
          "CIN2": await MultipartFile.fromFile(event.versoCIN.path),
          "CIN1": await MultipartFile.fromFile(event.rectoCIN.path)
        });

        // FormData formDataVerso = FormData.fromMap({
        //   "email": event.email,
        //   "file": await MultipartFile.fromFile(event.versoCIN.path)
        // });

        final responseRecto = await Dio()
            .post("${dotenv.env['URL']}/users/uploadCIN", data: formDataRecto);

        if (responseRecto.statusCode == 201) {
          emit(StepDone2());
        } else if (responseRecto.statusCode == 500) {
          emit(StepError2());
        } else {
          emit(StepError2());
        }
      } catch (e) {
        print("Erreur: $e");
        emit(StepError2());
      }
    });

    on<Step4Event>((event, emit) async {
      emit(StepLoading());
      try {
        FormData others = FormData.fromMap({
          "email": event.email,
          "Profile": await MultipartFile.fromFile(event.pdp.path),
          "Moto": await MultipartFile.fromFile(event.moto.path)
        });
        final response = await Dio()
            .post("${dotenv.env['URL']}/users/uploadOthers", data: others);

        if (response.statusCode == 201) {
          emit(StepDone3());
        }
        if (response.statusCode == 500) {
          emit(StepError3());
        }
      } catch (e) {
        print("Erreur: $e");
        emit(StepError3());
      }
    });
  }
}
