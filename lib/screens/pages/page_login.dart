import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_state.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/screens/composants/login.dart';
import 'package:koodiarana_chauffeur/screens/pages/loading.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _LoginState();
}

class _LoginState extends State<PageLogin> {
  TextEditingController mailNum = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Se connecter:"),
        ),
        body: BlocListener<SignInGoogleBloc,SignInGoogleState>(
          listener: (context, state) {
            if (state is GoogleConnectionDone) {
              Provider.of<AppManager>(context, listen: false)
                  .connected(state.user!);
            }
          },
          child: BlocBuilder<SignInGoogleBloc, SignInGoogleState>(
              builder: (context, state) {
            if (state is GoogleConnectionLoading) {
              return Loading();
            }
            if (state is GoogleConnectionError) {
              return Login(error: true);
            }
            return Login(error: false);
          }),
        ));
  }
}
