import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koodiarana_chauffeur/services/send_data.dart';

part 'step_event.dart';
part 'step_state.dart';

class StepBloc extends Bloc<StepEvent, StepState> {
  StepBloc() : super(StepInitial()) {
    on<Step1Event>((event, emit) async {
      try {
        final response = await SendData().goPost("${dotenv.env["URL"]}/", {
          //  "name": event.name,
          "email": event.email,
          "phoneNumber": event.phoneNumber,
          //  "password": event.password,
          "dateOfBirth": event.dateOfBirth,
          "status": true
        });
      } catch (e) {
        emit(StepError());
      }
    });
  }
}
