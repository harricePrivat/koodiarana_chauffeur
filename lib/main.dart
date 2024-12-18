import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koodiarana_chauffeur/bloc/signInGoogle/sign_in_google_bloc.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/screens/pages/splash_screen.dart';
import 'package:koodiarana_chauffeur/services/authentification.dart';
import 'package:koodiarana_chauffeur/services/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../screens/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(
      MultiProvider(
          providers: [
            StreamProvider.value(
                value: AuthService().userConnection, initialData: null),
            ChangeNotifierProvider(create: (context) => NavigationManager()),
            ChangeNotifierProvider(create: (context) => AppManager())
          ],
          child: MultiBlocProvider(
            providers: [BlocProvider(create: (context) => SignInGoogleBloc())],
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
