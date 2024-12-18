import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_event.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_state.dart';
import 'package:koodiarana_chauffeur/services/authentification.dart';

class SignInGoogleBloc extends Bloc<SignInGoogleEvent, SignInGoogleState> {
  SignInGoogleBloc() : super(GoogleConnectionInitial()) {
    on<TapGoogleButton>(
      (event, emit) async {
        try {
          emit(GoogleConnectionLoading());
          final userCredential = await AuthService().signInWithGoogle();
          emit(GoogleConnectionInitial());
          if (userCredential == null) {
            emit(GoogleConnectionError(message: "no user"));
          }
        } catch (e) {
          emit(GoogleConnectionError(message: "error"));
          print(e);
        }
      },
    );
  }
}
