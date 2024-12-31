import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/ajout_utilisateur/ajout_utilisateur_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/change_password/change_password_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/get_otp/get_otp_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/test_otp/test_otp_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/to_login/to_login_bloc.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/providers/scroll_manager.dart';
import 'package:koodiarana_chauffeur/screens/pages/splash_screen.dart';
import 'package:koodiarana_chauffeur/services/authentification.dart';
import 'package:koodiarana_chauffeur/services/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../screens/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, data) {
    if (task.compareTo("sendLocation") == 0) {
      print("Bonjour les amis");
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask("taskLocation", "sendLocation",
      frequency: Duration(minutes: 15));
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(
      MultiProvider(
          providers: [
            StreamProvider.value(
                value: AuthService().userConnection, initialData: null),
            ChangeNotifierProvider(create: (context) => ScrollManager()),
            ChangeNotifierProvider(create: (context) => NavigationManager()),
            ChangeNotifierProvider(create: (context) => AppManager())
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => SignInGoogleBloc()),
              BlocProvider(create: (context) => ToLoginBloc()),
              BlocProvider(create: (contet) => GetOtpBloc()),
              BlocProvider(create: (contet) => TestOtpBloc()),
              BlocProvider(create: (context) => ChangePasswordBloc()),
              BlocProvider(
                create: (context) => AjoutUtilisateurBloc(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          )),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    late final routers = GoRouters();
    final router = routers.router;
    return ShadApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp.router(
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
