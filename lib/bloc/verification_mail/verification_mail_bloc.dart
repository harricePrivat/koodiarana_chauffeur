import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../services/send_data.dart';

part 'verification_mail_event.dart';
part 'verification_mail_state.dart';

class VerificationMailBloc
    extends Bloc<VerificationMailEvent, VerificationMailState> {
  VerificationMailBloc() : super(VerificationMailInitial()) {
    on<OnSubmitMail>((event, emit) async {
      emit(VerificationMailLoading());
      try {
        final response = await SendData()
            .goPost("${dotenv.env["URL"]}/email/sendVerificationLink", {
          "token": event.tokens,
        });
        if (response.statusCode == 200) {
          emit(VerificationMailDone());
        } else if (response.statusCode == 401) {
          emit(VerificationMailError(message: "Email non trouvé"));
        } else {
          emit(VerificationMailError(message: "Erreur de connexion"));
        }
      } catch (e) {
        print(e);
        emit(VerificationMailError(message: "Erreur de connexion"));
      }
    });
  }
}
