import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:koodiarana_chauffeur/providers/app_manager.dart';
import 'package:koodiarana_chauffeur/providers/navigation_manager.dart';
import 'package:koodiarana_chauffeur/screens/pages/accueil.dart';
import 'package:koodiarana_chauffeur/screens/pages/first_login.dart';
import 'package:koodiarana_chauffeur/screens/pages/page_login.dart';
import 'package:provider/provider.dart';

class GoRouters {
  late final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/first-login', builder: (context, state) => FirstLogin()),
      GoRoute(path: '/login', builder: (context, state) => PageLogin()),
      GoRoute(path: '/accueil', builder: (context, state) => Accueil()),
    ],
    redirect: (context, state) {
      final user = Provider.of<User?>(context);
      final firstLogin = Provider.of<AppManager>(context).getLogin;
      if (user == null) {
        Provider.of<NavigationManager>(context).goToFirst();
        return '/login';
      } else {
        if (firstLogin) {
          return '/first-login';
        } else {
          return '/accueil';
        }
      }
      // return null;
    },
  );
}
